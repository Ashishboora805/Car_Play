import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BrowserPlatform {
  static const channel = MethodChannel('cpdrive/browser_files');
  Future<void> clearAllData() async {
    await CookieManager.instance().deleteAllCookies();
    if (Platform.isIOS) {
      await WebStorageManager.instance().removeDataModifiedSince(
        dataTypes: WebsiteDataType.ALL,
        date: DateTime.fromMillisecondsSinceEpoch(0),
      );
    } else if (Platform.isAndroid) {
      await WebStorageManager.instance().deleteAllData();
    }
    await InAppWebViewController.clearAllCache();
  }

  Future<void> clearPrivateData() async {
    if (!Platform.isAndroid) {
      return;
    }
    await CookieManager.instance().deleteAllCookies();
    await WebStorageManager.instance().deleteAllData();
    await InAppWebViewController.clearAllCache();
  }

  Future<Map<String, String>> publish(
    String source,
    String name,
    String mime,
    String notificationTitle,
  ) async {
    if (Platform.isAndroid) {
      final result = await channel.invokeMapMethod<String, dynamic>('publish', {
        'path': source,
        'name': name,
        'mime': mime,
        'title': notificationTitle,
      });
      if (result == null) {
        throw StateError('No saved download');
      }
      return {
        'location': result['location'] as String,
        'name': result['name'] as String,
        'mime': result['mime'] as String,
      };
    }
    final directory = Directory(
      path.join(
        (await getApplicationDocumentsDirectory()).path,
        'BrowserDownloads',
      ),
    );
    await directory.create(recursive: true);
    final destination = File(
      path.join(
        directory.path,
        '${DateTime.now().microsecondsSinceEpoch}_$name',
      ),
    );
    await File(source).copy(destination.path);
    await File(source).delete();
    return {'location': destination.path, 'name': name, 'mime': mime};
  }

  Future<void> open(String location, String mime) async {
    if (Platform.isAndroid) {
      await channel.invokeMethod<void>('open', {
        'location': location,
        'mime': mime,
      });
    } else {
      final result = await OpenFilex.open(location, type: mime);
      if (result.type != ResultType.done) {
        throw StateError(result.message);
      }
    }
  }

  Future<void> share(String location, String mime) async {
    if (Platform.isAndroid) {
      await channel.invokeMethod<void>('share', {
        'location': location,
        'mime': mime,
      });
    } else {
      await SharePlus.instance.share(
        ShareParams(files: [XFile(location, mimeType: mime)]),
      );
    }
  }

  Future<void> delete(String location) async {
    if (Platform.isAndroid) {
      final removed = await channel.invokeMethod<bool>('delete', {
        'location': location,
      });
      if (removed != true) {
        throw StateError('File not removed');
      }
    } else {
      final root = path.join(
        (await getApplicationDocumentsDirectory()).path,
        'BrowserDownloads',
      );
      if (!path.isWithin(root, location)) {
        throw StateError('Invalid download location');
      }
      final file = File(location);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}
