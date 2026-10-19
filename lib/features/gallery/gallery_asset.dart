import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../l10n/app_localizations.dart';

/// Full-size media is fetched only for the active page, never for grid badges.
class GalleryAssetTransfer extends ChangeNotifier {
  GalleryAssetTransfer(this.asset);
  final AssetEntity asset;
  File? file;
  double? progress;
  bool cloud = false, loading = false, failed = false;
  bool _disposed = false;
  int _generation = 0;
  PMCancelToken? _token;
  PMProgressHandler? _handler;
  StreamSubscription<PMProgressState>? _subscription;

  Future<void> load() async {
    if (_disposed || loading || file != null) return;
    final generation = ++_generation;
    loading = true;
    failed = false;
    progress = null;
    notifyListeners();
    final token = PMCancelToken();
    _token = token;
    try {
      cloud =
          Platform.isIOS &&
          !await asset.isLocallyAvailable(
            isOrigin: asset.type == AssetType.image,
          );
      if (_disposed || generation != _generation) return;
      if (Platform.isIOS) {
        final handler = PMProgressHandler();
        _handler = handler;
        _subscription = handler.stream.listen((state) {
          if (!_disposed && generation == _generation) {
            progress = state.progress.clamp(0, 1);
            notifyListeners();
          }
        });
      }
      notifyListeners();
      final loaded = await asset.loadFile(
        isOrigin: asset.type == AssetType.image,
        progressHandler: _handler,
        cancelToken: token,
      );
      if (_disposed || generation != _generation) return;
      if (loaded == null) throw StateError('Media unavailable');
      file = loaded;
    } catch (_) {
      if (!_disposed && generation == _generation) failed = true;
    } finally {
      if (generation == _generation) {
        _releaseProgress();
        _token = null;
        loading = false;
        if (!_disposed) notifyListeners();
      }
    }
  }

  void _releaseProgress() {
    unawaited(_subscription?.cancel());
    _subscription = null;
    final handler = _handler;
    _handler = null;
    // photo_manager 3.12 exposes channelIndex but has no handler dispose API.
    // Remove its per-request channel binding after completion/cancellation.
    if (handler != null) {
      OptionalMethodChannel(
        'com.fluttercandies/photo_manager/progress/${handler.channelIndex}',
      ).setMethodCallHandler(null);
    }
  }

  void cancel() {
    _generation++;
    final token = _token;
    _token = null;
    if (token != null) {
      unawaited(token.cancelRequest().catchError((Object _) {}));
    }
    _releaseProgress();
    loading = false;
  }

  @override
  void dispose() {
    _disposed = true;
    cancel();
    super.dispose();
  }
}

class GalleryTransferStatus extends StatelessWidget {
  const GalleryTransferStatus({
    super.key,
    required this.transfer,
    this.onCancel,
  });
  final GalleryAssetTransfer transfer;
  final VoidCallback? onCancel;
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (transfer.failed) ...[
              Text(text.mediaUnavailable),
              TextButton(onPressed: transfer.load, child: Text(text.retry)),
            ] else ...[
              if (transfer.cloud) ...[
                const Icon(Icons.cloud_download_outlined),
                Text(text.cloudDownloading),
              ],
              const SizedBox(height: 12),
              CircularProgressIndicator(value: transfer.progress),
              if (transfer.progress != null)
                Text('${(transfer.progress! * 100).round()}%'),
            ],
            if (onCancel != null)
              TextButton(onPressed: onCancel, child: Text(text.cancel)),
          ],
        ),
      ),
    );
  }
}

class GalleryAssetContent extends StatefulWidget {
  const GalleryAssetContent({
    super.key,
    required this.asset,
    required this.active,
    required this.builder,
  });
  final AssetEntity asset;
  final bool active;
  final Widget Function(BuildContext, File) builder;
  @override
  State<GalleryAssetContent> createState() => _GalleryAssetContentState();
}

class _GalleryAssetContentState extends State<GalleryAssetContent> {
  late final GalleryAssetTransfer transfer = GalleryAssetTransfer(widget.asset);
  @override
  void initState() {
    super.initState();
    if (widget.active) unawaited(transfer.load());
  }

  @override
  void didUpdateWidget(covariant GalleryAssetContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.active) {
      transfer.cancel();
    } else if (!oldWidget.active) {
      unawaited(transfer.load());
    }
  }

  @override
  void dispose() {
    transfer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: transfer,
    builder: (context, _) => !widget.active
        ? const SizedBox.shrink()
        : transfer.file == null
        ? GalleryTransferStatus(transfer: transfer)
        : widget.builder(context, transfer.file!),
  );
}

Future<File?> resolveGalleryFile(
  BuildContext context,
  AssetEntity asset,
) async {
  final transfer = GalleryAssetTransfer(asset);
  unawaited(transfer.load());
  bool completing = false;
  try {
    return await showDialog<File>(
      context: context,
      builder: (context) => AlertDialog(
        content: ListenableBuilder(
          listenable: transfer,
          builder: (context, _) {
            if (transfer.file != null && !completing) {
              completing = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted &&
                    ModalRoute.of(context)?.isCurrent == true) {
                  Navigator.pop(context, transfer.file);
                }
              });
            }
            return GalleryTransferStatus(
              transfer: transfer,
              onCancel: () => Navigator.pop(context),
            );
          },
        ),
      ),
    );
  } finally {
    transfer.dispose();
  }
}

class GalleryCloudBadge extends StatefulWidget {
  const GalleryCloudBadge({super.key, required this.asset});
  final AssetEntity asset;
  @override
  State<GalleryCloudBadge> createState() => _GalleryCloudBadgeState();
}

class _GalleryCloudBadgeState extends State<GalleryCloudBadge> {
  late final Future<bool> local = Platform.isIOS
      ? widget.asset
            .isLocallyAvailable(isOrigin: widget.asset.type == AssetType.image)
            .catchError((Object _) => true)
      : Future.value(true);
  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
    future: local,
    builder: (context, snapshot) => snapshot.data != false
        ? const SizedBox.shrink()
        : Tooltip(
            message: AppLocalizations.of(context)!.cloudMedia,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.black87),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.cloud_download_outlined, color: Colors.white),
              ),
            ),
          ),
  );
}
