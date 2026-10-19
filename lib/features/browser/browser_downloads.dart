import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'browser_models.dart';
import 'browser_platform.dart';
import 'browser_store.dart';
import 'browser_urls.dart';

class BrowserDownloads extends ChangeNotifier {
  BrowserDownloads(
    this.store,
    this.platform, {
    Dio? client,
    Future<Directory> Function()? temporaryDirectory,
  }) : temporaryDirectory = temporaryDirectory ?? getTemporaryDirectory,
       client =
           client ??
           Dio(
             BaseOptions(
               connectTimeout: const Duration(seconds: 20),
               receiveTimeout: const Duration(seconds: 60),
             ),
           );
  final Future<Directory> Function() temporaryDirectory;
  final BrowserStore store;
  final BrowserPlatform platform;
  // Browser traffic never uses the CP API authentication interceptor.
  final Dio client;
  List<BrowserDownload> items = [];
  final Map<String, CancelToken> _tokens = {};
  bool _disposed = false;
  Future<void> initialize() async {
    items = await store.downloads();
    if (_disposed) return;
    for (final item in items.where((d) => d.status == 'downloading')) {
      item.status = 'failed';
      await store.saveDownload(item);
    }
    if (!_disposed) {
      notifyListeners();
    }
  }

  Future<BrowserDownload> download({
    required Uri url,
    required String name,
    required String mime,
    required String completeTitle,
    bool private = false,
    String? cookie,
    String? userAgent,
    List<int>? bytes,
  }) async {
    if (_disposed) throw StateError('Browser session ended');
    if (bytes == null && !isWebAddress(url)) {
      throw ArgumentError('Unsupported download scheme');
    }
    final record = BrowserDownload(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: safeDownloadName(name),
      created: DateTime.now().millisecondsSinceEpoch,
      url: private ? '' : url.toString(),
      mime: mime,
    );
    items.insert(0, record);
    await store.saveDownload(record);
    if (_disposed) throw StateError('Browser session ended');
    if (!_disposed) {
      notifyListeners();
    }
    final token = CancelToken();
    _tokens[record.id] = token;
    File? temporary;
    IOSink? sink;
    try {
      temporary = File(
        path.join(
          (await temporaryDirectory()).path,
          'cpdrive_download_${record.id}',
        ),
      );
      if (bytes != null) {
        await temporary.writeAsBytes(bytes);
        record.bytes = bytes.length;
      } else {
        var current = url;
        Response<ResponseBody>? response;
        var crossedOrigin = false;
        for (var redirects = 0; redirects <= 5; redirects++) {
          response = await client.get<ResponseBody>(
            current.toString(),
            cancelToken: token,
            options: Options(
              responseType: ResponseType.stream,
              followRedirects: false,
              validateStatus: (s) => s != null && s >= 200 && s < 400,
              headers: {
                if (cookie != null &&
                    !crossedOrigin &&
                    current.origin == url.origin)
                  'Cookie': cookie,
                'User-Agent': ?userAgent,
              },
            ),
          );
          if (response.statusCode! < 300) {
            break;
          }
          final location = response.headers.value('location');
          await response.data?.stream.drain<void>();
          if (location == null || redirects == 5) {
            throw StateError('Invalid redirect');
          }
          final next = current.resolve(location);
          if (!isWebAddress(next) ||
              current.scheme == 'https' && next.scheme != 'https') {
            throw StateError('Unsafe redirect');
          }
          crossedOrigin = crossedOrigin || next.origin != url.origin;
          current = next;
          response = null;
        }
        if (response?.data == null) {
          throw StateError('Empty download response');
        }
        record.mime =
            response!.headers.value('content-type')?.split(';').first ?? mime;
        record.total = int.tryParse(
          response.headers.value('content-length') ?? '',
        );
        sink = temporary.openWrite();
        var last = DateTime.now();
        await for (final chunk in response.data!.stream) {
          if (token.isCancelled) {
            throw StateError('Download canceled');
          }
          sink.add(chunk);
          record.bytes += chunk.length;
          if (DateTime.now().difference(last).inMilliseconds > 200) {
            last = DateTime.now();
            if (!_disposed) {
              notifyListeners();
            }
          }
        }
        await sink.flush();
        await sink.close();
        sink = null;
      }
      if (token.isCancelled) {
        throw StateError('Download canceled');
      }
      final saved = await platform.publish(
        temporary.path,
        record.name,
        record.mime,
        completeTitle,
      );
      record.location = saved['location']!;
      record.name = saved['name']!;
      record.mime = saved['mime']!;
      record.status = 'complete';
    } catch (_) {
      record.status = 'failed';
    } finally {
      await sink?.close();
      if (temporary != null && await temporary.exists()) {
        await temporary.delete();
      }
      _tokens.remove(record.id);
      if (!_disposed) await store.saveDownload(record);
      if (!_disposed) {
        notifyListeners();
      }
    }
    return record;
  }

  Future<void> remove(BrowserDownload record) async {
    if (record.status == 'downloading') {
      _tokens[record.id]?.cancel();
      return;
    }
    if (record.location.isNotEmpty) {
      await platform.delete(record.location);
    }
    await store.removeDownload(record.id);
    items.remove(record);
    if (!_disposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    for (final token in _tokens.values) {
      token.cancel();
    }
    client.close(force: true);
    super.dispose();
  }
}
