import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:photo_manager/photo_manager.dart';

class Song {
  const Song({
    required this.id,
    required this.title,
    required this.folder,
    required this.uri,
    required this.duration,
  });
  final String id, title, folder, uri;
  final Duration duration;
}

/// Reads audio files stored on the device through MediaStore.
class MusicLibrary {
  static const permissionOption = PermissionRequestOption(
    androidPermission: AndroidPermission(
      type: RequestType.audio,
      mediaLocation: false,
    ),
  );
  List<Song>? _cache;

  Future<PermissionState> permission({bool request = false}) => request
      ? PhotoManager.requestPermissionExtend(requestOption: permissionOption)
      : PhotoManager.getPermissionState(requestOption: permissionOption);

  Future<void> openSettings() => PhotoManager.openSetting();

  Future<bool> get allowed async => (await permission()).hasAccess;

  Future<List<Song>> songs({bool refresh = false}) async {
    if (!refresh && _cache != null) {
      return _cache!;
    }
    if (!await allowed) {
      return const [];
    }
    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.audio,
      onlyAll: true,
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(type: OrderOptionType.createDate, asc: false),
        ],
      ),
    );
    if (albums.isEmpty) {
      return _cache = const [];
    }
    final count = await albums.first.assetCountAsync;
    final assets = await albums.first.getAssetListRange(start: 0, end: count);
    final result = <Song>[];
    for (final asset in assets) {
      final uri = Platform.isAndroid
          ? 'content://media/external/audio/media/${asset.id}'
          : await asset.getMediaUrl();
      if (uri == null) continue;
      final name = asset.title ?? await asset.titleAsync;
      final folder = path.basename(
        (asset.relativePath ?? '').replaceAll(RegExp(r'/+$'), ''),
      );
      result.add(
        Song(
          id: asset.id,
          title: path.basenameWithoutExtension(name),
          folder: folder.isEmpty ? '-' : folder,
          uri: uri,
          duration: Duration(seconds: asset.duration),
        ),
      );
    }
    return _cache = result;
  }

  Future<List<String>> folders() async =>
      (await songs()).map((song) => song.folder).toSet().toList()..sort();
}
