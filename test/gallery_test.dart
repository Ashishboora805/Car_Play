import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';
import 'package:drive/features/gallery/gallery_controller.dart';
import 'package:drive/features/gallery/gallery_format.dart';
import 'package:drive/features/gallery/gallery_library.dart';
import 'package:drive/features/gallery/gallery_permission_screen.dart';
import 'package:drive/features/gallery/gallery_screen.dart';
import 'package:drive/features/gallery/gallery_video.dart';
import 'package:drive/features/gallery/gallery_viewer.dart';
import 'package:drive/l10n/app_localizations.dart';

class FakeLibrary extends GalleryLibrary {
  PermissionState state = PermissionState.authorized;
  final records = <int>[];
  GalleryFilter? filter;
  VoidCallback? callback;
  int requests = 0;
  int settings = 0;
  bool fails = false;
  List<AssetEntity> assets = List.generate(
    85,
    (i) => AssetEntity(
      id: '$i',
      typeInt: i.isEven ? 1 : 2,
      width: 100,
      height: 100,
      isFavorite: i == 84,
    ),
  );
  Completer<List<AssetEntity>>? pending;
  @override
  Future<PermissionState> permission({bool request = false}) async {
    if (request) {
      requests++;
    }
    return state;
  }

  @override
  Future<List<AssetPathEntity>> albums(GalleryFilter type) async {
    filter = type;
    if (fails) {
      throw StateError('Failed');
    }
    return [AssetPathEntity(id: 'root', name: 'Recent', isAll: true)];
  }

  @override
  Future<List<AssetEntity>> page(AssetPathEntity album, int index) async {
    records.add(index);
    if (pending != null) {
      return pending!.future;
    }
    if (fails) {
      throw StateError('Failed');
    }
    final result = assets
        .where(
          (a) => filter == GalleryFilter.photos
              ? a.type == AssetType.image
              : filter == GalleryFilter.videos
              ? a.type == AssetType.video
              : true,
        )
        .toList();
    return result.skip(index * 80).take(80).toList();
  }

  @override
  Future<void> selectMore() async {
    state = PermissionState.limited;
  }

  @override
  Future<void> openSettings() async {
    settings++;
  }

  @override
  Future<void> watch(VoidCallback callback) async {
    this.callback = callback;
  }

  @override
  Future<void> unwatch() async {
    callback = null;
  }

  @override
  Future<bool> delete(AssetEntity asset) async {
    assets.removeWhere((a) => a.id == asset.id);
    return true;
  }
}

class FileAsset extends AssetEntity {
  FileAsset() : super(id: 'video', typeInt: 2, width: 640, height: 360);
  @override
  Future<File?> get file async => File('test-video.mp4');
  @override
  Future<File?> loadFile({
    bool isOrigin = true,
    bool withSubtype = false,
    PMProgressHandler? progressHandler,
    PMCancelToken? cancelToken,
    PMDarwinAVFileType? darwinFileType,
  }) => file;
}

class FakeVideoPlatform extends VideoPlayerPlatform {
  int pauses = 0;
  bool disposed = false;
  @override
  Future<void> init() async {}
  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async => 1;
  @override
  Stream<VideoEvent> videoEventsFor(int id) async* {
    yield VideoEvent(
      eventType: VideoEventType.initialized,
      duration: const Duration(seconds: 60),
      size: const Size(640, 360),
    );
  }

  @override
  Future<void> dispose(int id) async {
    disposed = true;
  }

  @override
  Future<void> setLooping(int id, bool looping) async {}
  @override
  Future<void> play(int id) async {}
  @override
  Future<void> pause(int id) async {
    pauses++;
  }

  @override
  Future<void> setVolume(int id, double volume) async {}
  @override
  Future<void> seekTo(int id, Duration position) async {}
  @override
  Future<void> setPlaybackSpeed(int id, double speed) async {}
  @override
  Future<Duration> getPosition(int id) async => Duration.zero;
  @override
  Widget buildViewWithOptions(VideoViewOptions options) => const SizedBox();
}

Widget localized(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'mixed gallery pages in batches of 80 without duplicate items',
    () async {
      final library = FakeLibrary();
      final controller = GalleryController(library);
      await controller.refresh();
      expect(controller.items.length, 80);
      expect(controller.hasMore, true);
      await controller.loadMore();
      expect(controller.items.length, 85);
      expect(controller.hasMore, false);
      expect(library.records, [0, 1]);
      expect(
        controller.items.where((a) => a.type == AssetType.video),
        isNotEmpty,
      );
      controller.dispose();
      expect(library.callback, isNull);
    },
  );
  test(
    'favorites continue across empty pages and filters reset paging',
    () async {
      final library = FakeLibrary();
      final controller = GalleryController(library);
      await controller.choose(album: 'favorites');
      expect(controller.items, isEmpty);
      expect(controller.hasMore, true);
      await controller.loadMore();
      expect(controller.items.single.id, '84');
      await controller.choose(type: GalleryFilter.videos, album: 'all');
      expect(controller.items.every((a) => a.type == AssetType.video), true);
      expect(library.records.last, 0);
      await controller.choose(album: 'videos');
      expect(library.filter, GalleryFilter.videos);
      controller.dispose();
    },
  );
  test(
    'limited access is usable and permission revocation clears assets',
    () async {
      final library = FakeLibrary()..state = PermissionState.limited;
      final controller = GalleryController(library);
      await controller.refresh();
      expect(controller.accessible, true);
      expect(controller.limited, true);
      expect(controller.items, isNotEmpty);
      library.state = PermissionState.denied;
      await controller.refresh();
      expect(controller.accessible, false);
      expect(controller.items, isEmpty);
      expect(controller.hasMore, false);
      controller.dispose();
    },
  );
  test(
    'stale page cannot restore assets after permission is revoked',
    () async {
      final library = FakeLibrary()..pending = Completer<List<AssetEntity>>();
      final controller = GalleryController(library);
      final first = controller.refresh();
      await Future<void>.delayed(Duration.zero);
      library.state = PermissionState.denied;
      await controller.refresh();
      library.pending!.complete(library.assets);
      await first;
      expect(controller.items, isEmpty);
      expect(controller.permission, PermissionState.denied);
      controller.dispose();
    },
  );
  test('failed library queries are recoverable', () async {
    final library = FakeLibrary()..fails = true;
    final controller = GalleryController(library);
    await controller.refresh();
    expect(controller.error, isNotNull);
    expect(controller.busy, false);
    library.fails = false;
    await controller.refresh();
    expect(controller.error, isNull);
    expect(controller.items.length, 80);
    controller.dispose();
  });
  test('duration supports videos longer than an hour', () {
    expect(mediaDuration(65), '01:05');
    expect(mediaDuration(3661), '1:01:01');
  });
  testWidgets(
    'permission-denied screen offers Settings and retry at large font',
    (tester) async {
      var settings = 0;
      var retry = 0;
      await tester.pumpWidget(
        localized(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: GalleryPermissionScreen(
              denied: true,
              onAllow: () => retry++,
              onSettings: () => settings++,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Photo and video access is turned off.'),
        findsOneWidget,
      );
      await tester.ensureVisible(find.text('Open Settings'));
      await tester.tap(find.text('Open Settings'));
      expect(settings, 1);
      await tester.ensureVisible(find.text('Retry'));
      await tester.tap(find.text('Retry'));
      expect(retry, 1);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('gallery waits for a user gesture before requesting permission', (
    tester,
  ) async {
    final library = FakeLibrary()..state = PermissionState.denied;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [galleryLibraryProvider.overrideWithValue(library)],
        child: localized(const GalleryScreen(active: true)),
      ),
    );
    await tester.pumpAndSettle();
    expect(library.requests, 0);
    await tester.tap(find.text('Allow access'));
    await tester.pumpAndSettle();
    expect(library.requests, 1);
    expect(find.text('Open Settings'), findsOneWidget);
    await tester.tap(find.text('Open Settings'));
    await tester.pumpAndSettle();
    expect(library.settings, 1);
    await tester.pumpWidget(const SizedBox());
  });
  testWidgets(
    'library change notifications refresh and dispose removes the callback',
    (tester) async {
      final library = FakeLibrary();
      final controller = GalleryController(library);
      await controller.refresh();
      library.assets = [];
      library.callback!();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();
      expect(controller.items, isEmpty);
      controller.dispose();
      expect(library.callback, isNull);
    },
  );
  testWidgets('video pauses when swiped away and when app backgrounds', (
    tester,
  ) async {
    final previous = VideoPlayerPlatform.instance;
    final platform = FakeVideoPlatform();
    VideoPlayerPlatform.instance = platform;
    addTearDown(() => VideoPlayerPlatform.instance = previous);
    final asset = FileAsset();
    final active = ValueNotifier(true);
    await tester.pumpWidget(
      localized(
        ValueListenableBuilder<bool>(
          valueListenable: active,
          builder: (context, value, child) =>
              GalleryVideo(asset: asset, active: value),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(Chewie), findsOneWidget);
    var controller = tester
        .widget<Chewie>(find.byType(Chewie))
        .controller
        .videoPlayerController;
    await controller.play();
    await tester.pump();
    expect(controller.value.isPlaying, true);
    active.value = false;
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      await Future<void>.delayed(Duration.zero);
    });
    await tester.pump();
    expect(controller.value.isPlaying, false);
    expect(platform.disposed, true);
    active.value = true;
    await tester.pumpAndSettle();
    controller = tester
        .widget<Chewie>(find.byType(Chewie))
        .controller
        .videoPlayerController;
    await controller.play();
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    expect(controller.value.isPlaying, false);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    await tester.runAsync(() async {
      await Future<void>.delayed(Duration.zero);
    });
    await tester.pump();
    expect(platform.disposed, true);
    active.dispose();
  });
  testWidgets(
    'returning from viewer refreshes without popping the gallery route',
    (tester) async {
      final previous = VideoPlayerPlatform.instance;
      VideoPlayerPlatform.instance = FakeVideoPlatform();
      addTearDown(() => VideoPlayerPlatform.instance = previous);
      final library = FakeLibrary()..assets = [FileAsset()];
      final controller = GalleryController(library);
      await controller.refresh();
      await tester.pumpWidget(
        localized(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                await Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (_) =>
                        GalleryViewer(controller: controller, initialIndex: 0),
                  ),
                );
                await controller.refresh();
              },
              child: const Text('Open viewer'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open viewer'));
      await tester.pumpAndSettle();
      expect(find.byType(GalleryViewer), findsOneWidget);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.text('Open viewer'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.runAsync(() async {
        await Future<void>.delayed(Duration.zero);
      });
      controller.dispose();
    },
  );
}
