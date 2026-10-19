import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

import 'gallery_library.dart';

class GalleryController extends ChangeNotifier {
  GalleryController(this.library);
  final GalleryLibrary library;
  PermissionState? permission;
  GalleryFilter filter = GalleryFilter.all;
  String selectedAlbum = 'all';
  List<AssetPathEntity> albums = [];
  List<AssetEntity> items = [];
  bool requested = false;
  bool busy = false;
  bool loadingMore = false;
  bool hasMore = false;
  Object? error;
  int _generation = 0;
  int _page = 0;
  AssetPathEntity? _path;
  bool _disposed = false;
  bool _watching = false;
  Timer? _debounce;
  bool get accessible => permission?.hasAccess ?? false;
  bool get limited => permission == PermissionState.limited;
  Future<void> refresh({bool request = false}) async {
    if (_disposed) {
      return;
    }
    if (request) {
      requested = true;
    }
    final generation = ++_generation;
    busy = true;
    error = null;
    loadingMore = false;
    notifyListeners();
    try {
      final state = await library.permission(request: request);
      if (_disposed || generation != _generation) {
        return;
      }
      permission = state;
      // Do not retain assets after access is revoked or reduced.
      items = [];
      albums = [];
      _path = null;
      _page = 0;
      hasMore = false;
      if (!accessible) {
        return;
      }
      final paths = await library.albums(
        selectedAlbum == 'videos' ? GalleryFilter.videos : filter,
      );
      if (_disposed || generation != _generation) {
        return;
      }
      albums = paths;
      if (selectedAlbum != 'all' &&
          selectedAlbum != 'favorites' &&
          selectedAlbum != 'videos' &&
          !paths.any((p) => p.id == selectedAlbum)) {
        selectedAlbum = 'all';
      }
      if (paths.isNotEmpty) {
        _path =
            selectedAlbum == 'all' ||
                selectedAlbum == 'favorites' ||
                selectedAlbum == 'videos'
            ? paths.firstWhere((path) => path.isAll, orElse: () => paths.first)
            : paths.firstWhere((path) => path.id == selectedAlbum);
        hasMore = true;
        await _fetchPage(generation);
      }
      if (!_watching && !_disposed && generation == _generation && accessible) {
        _watching = true;
        try {
          await library.watch(() {
            _debounce?.cancel();
            _debounce = Timer(
              const Duration(milliseconds: 400),
              () => refresh(),
            );
          });
        } catch (_) {
          _watching = false;
        }
        if (_disposed) {
          await library.unwatch();
        }
      }
    } catch (failure) {
      if (!_disposed && generation == _generation) {
        error = failure;
      }
    } finally {
      if (!_disposed && generation == _generation) {
        busy = false;
        notifyListeners();
      }
    }
  }

  Future<void> _fetchPage(int generation) async {
    final path = _path;
    if (path == null) {
      return;
    }
    final page = await library.page(path, _page);
    if (_disposed || generation != _generation) {
      return;
    }
    _page++;
    hasMore = page.length == 80;
    final ids = items.map((a) => a.id).toSet();
    items = [
      ...items,
      ...page.where(
        (asset) =>
            (asset.type == AssetType.image || asset.type == AssetType.video) &&
            (selectedAlbum != 'favorites' || asset.isFavorite) &&
            ids.add(asset.id),
      ),
    ];
  }

  Future<void> loadMore() async {
    if (_disposed || busy || loadingMore || !hasMore) {
      return;
    }
    final generation = _generation;
    loadingMore = true;
    error = null;
    notifyListeners();
    try {
      await _fetchPage(generation);
    } catch (failure) {
      if (!_disposed && generation == _generation) {
        error = failure;
      }
    } finally {
      if (!_disposed && generation == _generation) {
        loadingMore = false;
        notifyListeners();
      }
    }
  }

  Future<void> choose({GalleryFilter? type, String? album}) async {
    if (type != null && selectedAlbum == 'videos') {
      selectedAlbum = 'all';
    }
    filter = album == 'videos' ? GalleryFilter.videos : type ?? filter;
    selectedAlbum = album ?? selectedAlbum;
    await refresh();
  }

  Future<void> selectMore() async {
    if (_disposed || busy) {
      return;
    }
    busy = true;
    notifyListeners();
    try {
      await library.selectMore();
      await refresh();
    } catch (failure) {
      if (!_disposed) {
        error = failure;
        busy = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _generation++;
    _debounce?.cancel();
    unawaited(library.unwatch().catchError((Object _) {}));
    super.dispose();
  }
}
