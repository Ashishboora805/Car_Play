import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

final galleryLibraryProvider = Provider<GalleryLibrary>(
  (ref) => DeviceGalleryLibrary(),
);

enum GalleryFilter { all, photos, videos }

abstract class GalleryLibrary {
  Future<PermissionState> permission({bool request = false});
  Future<List<AssetPathEntity>> albums(GalleryFilter filter);
  Future<List<AssetEntity>> page(AssetPathEntity album, int index);
  Future<void> selectMore();
  Future<void> openSettings();
  Future<void> watch(VoidCallback callback);
  Future<void> unwatch();
  Future<bool> delete(AssetEntity asset);
}

class DeviceGalleryLibrary implements GalleryLibrary {
  static const permissionOption = PermissionRequestOption(
    androidPermission: AndroidPermission(
      type: RequestType.common,
      mediaLocation: false,
    ),
  );
  void Function(MethodCall)? _change;
  @override
  Future<PermissionState> permission({bool request = false}) => request
      ? PhotoManager.requestPermissionExtend(requestOption: permissionOption)
      : PhotoManager.getPermissionState(requestOption: permissionOption);
  @override
  Future<List<AssetPathEntity>> albums(GalleryFilter filter) =>
      PhotoManager.getAssetPathList(
        type: switch (filter) {
          GalleryFilter.all => RequestType.common,
          GalleryFilter.photos => RequestType.image,
          GalleryFilter.videos => RequestType.video,
        },
        filterOption: FilterOptionGroup(
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
  @override
  Future<List<AssetEntity>> page(AssetPathEntity album, int index) =>
      album.getAssetListPaged(page: index, size: 80);
  @override
  Future<void> selectMore() =>
      PhotoManager.presentLimited(type: RequestType.common);
  @override
  Future<void> openSettings() => PhotoManager.openSetting();
  @override
  Future<void> watch(VoidCallback callback) async {
    if (_change != null) {
      return;
    }
    _change = (_) => callback();
    PhotoManager.addChangeCallback(_change!);
    try {
      await PhotoManager.startChangeNotify();
    } catch (_) {
      PhotoManager.removeChangeCallback(_change!);
      _change = null;
      rethrow;
    }
  }

  @override
  Future<void> unwatch() async {
    final change = _change;
    _change = null;
    if (change != null) {
      PhotoManager.removeChangeCallback(change);
      await PhotoManager.stopChangeNotify();
    }
  }

  @override
  Future<bool> delete(AssetEntity asset) async =>
      (await PhotoManager.editor.deleteWithIds([asset.id])).contains(asset.id);
}
