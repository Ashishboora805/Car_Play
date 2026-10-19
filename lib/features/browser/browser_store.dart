import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'browser_models.dart';

final browserStoreProvider = Provider<BrowserStore>((ref) {
  final store = BrowserStore();
  ref.onDispose(() => store.close());
  return store;
});

class BrowserStore {
  BrowserStore({DatabaseFactory? factory, String? databasePath})
    : _factory = factory ?? databaseFactory,
      _path = databasePath;
  final DatabaseFactory _factory;
  final String? _path;
  Database? _database;
  Future<Database>? _opening;
  Future<void> _writes = Future.value();
  bool _suspended = false;
  int _generation = 0;
  final Set<Future<void> Function()> beforeClear = {};
  void resumeWrites() => _suspended = false;
  Future<void> _write(Future<void> Function(Database) operation) {
    if (_suspended) return Future.value();
    final generation = _generation;
    final result = _writes.catchError((Object _) {}).then((_) async {
      final db = await database;
      if (!_suspended && generation == _generation) await operation(db);
    });
    _writes = result;
    return result;
  }

  Future<void> clearUserData() async {
    _suspended = true;
    _generation++;
    for (final stop in List.of(beforeClear)) {
      await stop();
    }
    await _writes.catchError((Object _) {});
    final db = await database;
    await db.transaction((txn) async {
      for (final table in [
        'tabs',
        'bookmarks',
        'history',
        'downloads',
        'metadata',
      ]) {
        await txn.delete(table);
      }
    });
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    try {
      return _database ??= await (_opening ??= _open());
    } catch (_) {
      _opening = null;
      rethrow;
    }
  }

  Future<Database> _open() async => _factory.openDatabase(
    _path ??
        path.join(
          (await getApplicationSupportDirectory()).path,
          'cpdrive_browser.db',
        ),
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE tabs(id TEXT PRIMARY KEY,url TEXT NOT NULL,title TEXT NOT NULL,position INTEGER NOT NULL,desktop INTEGER NOT NULL,zoom INTEGER NOT NULL,thumbnail BLOB)',
        );
        await db.execute(
          'CREATE TABLE bookmarks(url TEXT PRIMARY KEY,title TEXT NOT NULL,created INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT,url TEXT NOT NULL,title TEXT NOT NULL,visited INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE INDEX history_visited ON history(visited DESC)',
        );
        await db.execute(
          'CREATE TABLE downloads(id TEXT PRIMARY KEY,name TEXT NOT NULL,url TEXT NOT NULL,location TEXT NOT NULL,mime TEXT NOT NULL,status TEXT NOT NULL,bytes INTEGER NOT NULL,created INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE TABLE metadata(key TEXT PRIMARY KEY,value TEXT NOT NULL)',
        );
      },
    ),
  );
  Future<List<BrowserTab>> tabs() async => (await (await database).query(
    'tabs',
    orderBy: 'position',
  )).map(BrowserTab.fromMap).toList();
  Future<void> saveTabs(List<BrowserTab> tabs, String? selected) {
    final rows = [
      for (final (i, tab) in tabs.where((t) => !t.incognito).indexed)
        tab.toMap(i),
    ];
    return _write((db) async {
      await db.transaction((txn) async {
        await txn.delete('tabs');
        for (final row in rows) {
          await txn.insert('tabs', row);
        }
        if (selected != null) {
          await txn.insert('metadata', {
            'key': 'selected',
            'value': selected,
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        }
      });
    });
  }

  Future<String?> value(String key) async =>
      (await (await database).query(
            'metadata',
            where: 'key=?',
            whereArgs: [key],
          )).firstOrNull?['value']
          as String?;
  Future<void> setValue(String key, String value) => _write((db) async {
    await db
        .insert('metadata', {
          'key': key,
          'value': value,
        }, conflictAlgorithm: ConflictAlgorithm.replace)
        .then((_) {});
  });

  Future<void> addHistory(BrowserTab tab) async {
    if (_suspended) return;
    if (tab.incognito ||
        !['https', 'http'].contains(Uri.tryParse(tab.url)?.scheme)) {
      return;
    }
    final entry = {
      'url': tab.url,
      'title': tab.title,
      'visited': DateTime.now().millisecondsSinceEpoch,
    };
    await _write((db) async {
      await db.insert('history', entry);
    });
  }

  Future<List<BrowserEntry>> history([String search = '']) async {
    final rows = await (await database).query(
      'history',
      where: search.isEmpty ? null : 'instr(lower(url), lower(?)) > 0 OR instr(lower(title), lower(?)) > 0',
      whereArgs: search.isEmpty ? null : [search, search],
      orderBy: 'visited DESC',
    );
    return rows
        .map(
          (r) => BrowserEntry(
            url: r['url'] as String,
            title: r['title'] as String,
            time: r['visited'] as int,
          ),
        )
        .toList();
  }

  Future<void> clearHistory() => _write((db) async {
    await db.delete('history');
  });

  Future<List<BrowserEntry>> bookmarks() async =>
      (await (await database).query('bookmarks', orderBy: 'created DESC'))
          .map(
            (r) => BrowserEntry(
              url: r['url'] as String,
              title: r['title'] as String,
              time: r['created'] as int,
            ),
          )
          .toList();
  Future<void> bookmark(String url, String title, {String? previousUrl}) async {
    if (_suspended) return;
    await _write((db) async {
      await db.transaction((txn) async {
        if (previousUrl != null) {
          await txn.delete(
            'bookmarks',
            where: 'url=?',
            whereArgs: [previousUrl],
          );
        }
        await txn.insert('bookmarks', {
          'url': url,
          'title': title,
          'created': DateTime.now().millisecondsSinceEpoch,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      });
    });
  }

  Future<void> removeBookmark(String url) async {
    await _write((db) async {
      await db.delete('bookmarks', where: 'url=?', whereArgs: [url]);
    });
  }

  Future<List<BrowserDownload>> downloads() async =>
      (await (await database).query(
        'downloads',
        orderBy: 'created DESC',
      )).map(BrowserDownload.fromMap).toList();
  Future<void> saveDownload(BrowserDownload record) async {
    if (_suspended) return;
    await _write((db) async {
      await db.insert(
        'downloads',
        record.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<void> removeDownload(String id) async {
    await _write((db) async {
      await db.delete('downloads', where: 'id=?', whereArgs: [id]);
    });
  }

  Future<void> close() async {
    await _writes.catchError((Object _) {});
    await _database?.close();
  }
}
