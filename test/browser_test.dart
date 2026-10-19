import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:drive/features/browser/browser_downloads.dart';
import 'package:drive/features/browser/browser_models.dart';
import 'package:drive/features/browser/browser_platform.dart';
import 'package:drive/features/browser/browser_session.dart';
import 'package:drive/features/browser/browser_store.dart';
import 'package:drive/features/browser/browser_urls.dart';

class FakeFiles extends BrowserPlatform {
  List<int>? saved;
  bool deleted = false;
  @override
  Future<Map<String, String>> publish(
    String source,
    String name,
    String mime,
    String notificationTitle,
  ) async {
    saved = await File(source).readAsBytes();
    return {
      'location': 'content://media/external/downloads/42',
      'name': name,
      'mime': mime,
    };
  }

  @override
  Future<void> delete(String location) async {
    deleted = true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  late BrowserStore store;
  setUp(() {
    store = BrowserStore(
      factory: databaseFactoryFfi,
      databasePath: inMemoryDatabasePath,
    );
  });
  tearDown(() async {
    await store.close();
  });
  test('24 tabs retain at most four WebViews and selecting an evicted tab restores metadata', () async {
    final session = BrowserSession(
      store,
      android: false,
      clearPrivateData: () async {},
      afterViewsRemoved: () async {},
    );
    await session.initialize();
    final first = session.selected..url = 'https://example.com/first';
    for (var i = 0; i < 23; i++) {
      await session.add(url: 'https://example.com/$i');
      expect(
        session.tabs.where((tab) => tab.visited).length,
        lessThanOrEqualTo(4),
      );
    }
    expect(first.visited, false);
    await session.select(first);
    expect(first.visited, true);
    expect(first.url, 'https://example.com/first');
    expect(session.tabs.length, 24);
    expect(session.tabs.where((tab) => tab.visited).length, 4);
    session.dispose();
  });
  test('logout clears browser records and rejects late writes until the next session', () async {
    final tab = BrowserTab(
      id: 'old',
      url: 'https://example.com',
      title: 'Private account',
    );
    await store.saveTabs([tab], tab.id);
    await store.addHistory(tab);
    await store.bookmark(tab.url, tab.title);
    await store.saveDownload(
      BrowserDownload(id: 'download', name: 'account.pdf', created: 1),
    );
    var stopped = false;
    store.beforeClear.add(() async {
      stopped = true;
    });
    await store.clearUserData();
    await store.saveTabs([tab], tab.id);
    await store.addHistory(tab);
    await store.saveDownload(
      BrowserDownload(id: 'late', name: 'late.pdf', created: 2),
    );
    expect(stopped, true);
    expect(await store.tabs(), isEmpty);
    expect(await store.history(), isEmpty);
    expect(await store.bookmarks(), isEmpty);
    expect(await store.downloads(), isEmpty);
    expect(await store.value('selected'), isNull);
    store.resumeWrites();
    await store.saveTabs([BrowserTab(id: 'new')], 'new');
    expect((await store.tabs()).single.id, 'new');
  });
  test(
    'address input distinguishes websites, searches and explicit schemes',
    () {
      expect(
        browserAddress('example.com/path').toString(),
        'https://example.com/path',
      );
      expect(browserAddress('http://localhost:8080').scheme, 'http');
      expect(
        browserAddress('cricket scores today').queryParameters['q'],
        'cricket scores today',
      );
      expect(browserAddress('javascript:alert(1)').host, 'www.google.com');
      expect(browserAddress('file:///secret').host, 'www.google.com');
      expect(browserAddress(' ').toString(), 'about:blank');
      expect(isWebAddress(Uri.parse('https://user:pass@example.com')), false);
    },
  );
  test('intent fallback accepts encoded web URLs and refuses unsafe schemes', () {
    expect(
      intentFallback(
        'intent://play#Intent;S.browser_fallback_url=https%3A%2F%2Fexample.com%2Fwatch;end',
      )?.host,
      'example.com',
    );
    expect(
      intentFallback(
        'intent://play#Intent;S.browser_fallback_url=javascript%3Aalert(1);end',
      ),
      isNull,
    );
    expect(
      intentFallback('intent://play#Intent;S.browser_fallback_url=%ZZ;end'),
      isNull,
    );
  });
  test(
    'download names cannot traverse directories or retain control characters',
    () {
      expect(safeDownloadName('../../photo.jpg'), 'photo.jpg');
      expect(safeDownloadName('..\\photo.jpg'), 'photo.jpg');
      expect(safeDownloadName('..'), 'download');
      expect(safeDownloadName('a:b?.pdf'), 'a_b_.pdf');
      expect(safeDownloadName('x' * 300).length, 160);
    },
  );
  test('SQLite stores normal tabs, selection and thumbnails but excludes private tabs', () async {
    final normal = BrowserTab(
      id: 'normal',
      url: 'https://example.com',
      title: 'Example',
      desktop: true,
      zoom: 125,
    );
    final private = BrowserTab(
      id: 'private',
      url: 'https://secret.example',
      title: 'Secret',
      incognito: true,
    );
    await store.saveTabs([normal, private], normal.id);
    final restored = await store.tabs();
    expect(restored.length, 1);
    expect(restored.single.url, normal.url);
    expect(restored.single.desktop, true);
    expect(restored.single.zoom, 125);
    expect(await store.value('selected'), 'normal');
    final db = await store.database;
    expect(
      (await db.rawQuery(
        "SELECT count(*) AS total FROM tabs WHERE url LIKE '%secret%'",
      )).single['total'],
      0,
    );
  });
  test('serialized tab writes keep the newest snapshot', () async {
    final a = BrowserTab(id: 'a');
    final b = BrowserTab(id: 'b');
    final first = store.saveTabs([a], 'a');
    final second = store.saveTabs([b], 'b');
    await Future.wait([first, second]);
    expect((await store.tabs()).single.id, 'b');
  });
  test(
    'history ignores private navigation and treats wildcard searches literally',
    () async {
      await store.addHistory(
        BrowserTab(
          id: 'a',
          url: 'https://example.com/a_b',
          title: 'Cricket Highlights',
        ),
      );
      await store.addHistory(
        BrowserTab(
          id: 'b',
          url: 'https://secret.example',
          title: 'secret',
          incognito: true,
        ),
      );
      expect((await store.history()).length, 1);
      expect(
        (await store.history('CRICKET')).single.title,
        'Cricket Highlights',
      );
      expect((await store.history('_')).length, 1);
      expect(await store.history('%'), isEmpty);
      await store.clearHistory();
      expect(await store.history(), isEmpty);
    },
  );
  test('bookmarks can be edited by URL and removed', () async {
    await store.bookmark('https://example.com', 'First');
    await store.bookmark(
      'https://new.example',
      'Second',
      previousUrl: 'https://example.com',
    );
    expect((await store.bookmarks()).single.url, 'https://new.example');
    await store.removeBookmark('https://new.example');
    expect(await store.bookmarks(), isEmpty);
  });
  test('private mode transition removes views before clearing and leaves no restored private tab', () async {
    final events = <String>[];
    final session = BrowserSession(
      store,
      android: true,
      afterViewsRemoved: () async {
        events.add('removed');
      },
      clearPrivateData: () async {
        events.add('cleared');
      },
    );
    await session.initialize();
    final normal = session.selected;
    await session.add(private: true, url: 'https://private.example');
    expect(events, ['removed', 'cleared']);
    expect(await store.value('privateDirty'), 'true');
    expect((await store.tabs()).every((tab) => !tab.incognito), true);
    await session.select(normal);
    expect(events, ['removed', 'cleared', 'removed', 'cleared']);
    expect(await store.value('privateDirty'), 'false');
    await session.closeAll();
    expect(session.tabs.length, 1);
    expect(session.selected.incognito, false);
    session.dispose();
  });
  test(
    'private cleanup is recovered before a cold-start browser becomes ready',
    () async {
      await store.setValue('privateDirty', 'true');
      var cleaned = false;
      final session = BrowserSession(
        store,
        android: true,
        afterViewsRemoved: () async {},
        clearPrivateData: () async {
          cleaned = true;
        },
      );
      expect(session.ready, false);
      await session.initialize();
      expect(cleaned, true);
      expect(session.ready, true);
      expect(await store.value('privateDirty'), 'false');
      session.dispose();
    },
  );
  test('failed privacy cleanup blocks rendering and can be retried', () async {
    await store.setValue('privateDirty', 'true');
    var fail = true;
    final session = BrowserSession(
      store,
      android: true,
      afterViewsRemoved: () async {},
      clearPrivateData: () async {
        if (fail) {
          throw StateError('failed');
        }
      },
    );
    await session.initialize();
    expect(session.ready, false);
    expect(session.error, isNotNull);
    expect(await store.value('privateDirty'), 'true');
    fail = false;
    await session.initialize();
    expect(session.ready, true);
    session.dispose();
  });
  test('downloads strip cookies across redirects, do not send CP authentication, and persist completed files', () async {
    final directory = await Directory.systemTemp.createTemp(
      'cpdrive-browser-test-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final client = Dio();
    final headers = <Map<String, dynamic>>[];
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          headers.add(Map.of(options.headers));
          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: headers.length == 1 ? 302 : 200,
              headers: Headers.fromMap(
                headers.length == 1
                    ? {
                        'location': ['https://cdn.example/file'],
                      }
                    : {
                        'content-type': ['text/plain'],
                        'content-length': ['3'],
                      },
              ),
              data: ResponseBody.fromBytes(
                headers.length == 1 ? [] : [1, 2, 3],
                headers.length == 1 ? 302 : 200,
                headers: headers.length == 1
                    ? {
                        'location': ['https://cdn.example/file'],
                      }
                    : {
                        'content-type': ['text/plain'],
                        'content-length': ['3'],
                      },
              ),
            ),
          );
        },
      ),
    );
    final platform = FakeFiles();
    final downloads = BrowserDownloads(
      store,
      platform,
      client: client,
      temporaryDirectory: () async => directory,
    );
    await downloads.download(
      url: Uri.parse('https://example.com/file'),
      name: '../file.txt',
      mime: 'text/plain',
      completeTitle: 'Done',
      private: true,
      cookie: 'session=private',
    );
    expect(headers.first['Cookie'], 'session=private');
    expect(headers.length, 2, reason: '$headers');
    expect(headers.last.containsKey('Cookie'), false, reason: '$headers');
    expect(headers.every((h) => !h.containsKey('Authorization')), true);
    expect(platform.saved, [1, 2, 3]);
    expect(downloads.items.single.status, 'complete');
    expect(downloads.items.single.name, 'file.txt');
    expect((await store.downloads()).single.url, '');
    expect(await directory.list().toList(), isEmpty);
    await downloads.remove(downloads.items.single);
    expect(platform.deleted, true);
    expect(await store.downloads(), isEmpty);
    downloads.dispose();
  });
  test('interrupted downloads are marked failed on restoration', () async {
    await store.saveDownload(
      BrowserDownload(id: '1', name: 'file', created: 1),
    );
    final downloads = BrowserDownloads(store, FakeFiles());
    await downloads.initialize();
    expect(downloads.items.single.status, 'failed');
    expect((await store.downloads()).single.status, 'failed');
    downloads.dispose();
  });
  test('unsafe redirect fails instead of sending cookies over HTTP', () async {
    final directory = await Directory.systemTemp.createTemp(
      'cpdrive-browser-test-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final client = Dio();
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 302,
            headers: Headers.fromMap({
              'location': ['http://example.com/file'],
            }),
            data: ResponseBody.fromBytes(
              [],
              302,
              headers: {
                'location': ['http://example.com/file'],
              },
            ),
          ),
        ),
      ),
    );
    final downloads = BrowserDownloads(
      store,
      FakeFiles(),
      client: client,
      temporaryDirectory: () async => directory,
    );
    await downloads.download(
      url: Uri.parse('https://example.com/file'),
      name: 'file',
      mime: 'text/plain',
      completeTitle: 'Done',
      cookie: 'secret',
    );
    expect(downloads.items.single.status, 'failed');
    expect(downloads.items.single.location, '');
    downloads.dispose();
  });
}
