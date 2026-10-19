import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

import '../../l10n/app_localizations.dart';
import 'gallery_asset.dart';

class GalleryVideo extends StatefulWidget {
  const GalleryVideo({super.key, required this.asset, required this.active});
  final AssetEntity asset;
  final bool active;
  @override
  State<GalleryVideo> createState() => _GalleryVideoState();
}

class _GalleryVideoState extends State<GalleryVideo>
    with WidgetsBindingObserver {
  VideoPlayerController? video;
  ChewieController? chewie;
  bool failed = false;
  bool loading = false;
  int generation = 0;
  late final GalleryAssetTransfer transfer = GalleryAssetTransfer(widget.asset);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.active && video == null && !loading && !failed) {
      initialize();
    }
  }

  @override
  void didUpdateWidget(covariant GalleryVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.active) {
      releasePlayer();
    } else if (video == null && !loading && !failed) {
      initialize();
    }
  }

  Future<void> initialize() async {
    if (loading) {
      return;
    }
    final current = ++generation;
    loading = true;
    failed = false;
    VideoPlayerController? candidate;
    try {
      await transfer.load();
      final file = transfer.file;
      if (!mounted || current != generation) {
        return;
      }
      if (file == null) {
        throw StateError('Media unavailable');
      }
      candidate = VideoPlayerController.file(file);
      await candidate.initialize();
      if (!mounted || current != generation) {
        await candidate.dispose();
        return;
      }
      final text = AppLocalizations.of(context)!;
      final player = ChewieController(
        videoPlayerController: candidate,
        autoPlay: false,
        allowMuting: true,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: false,
        showOptions: false,
        errorBuilder: (context, error) => Center(child: Text(text.videoError)),
      );
      video = candidate;
      chewie = player;
      setState(() => loading = false);
    } catch (_) {
      await candidate?.dispose();
      if (mounted && current == generation) {
        setState(() {
          loading = false;
          failed = true;
        });
      }
    }
  }

  void pause() {
    final controller = video;
    if (controller != null) {
      unawaited(controller.pause().catchError((Object _) {}));
    }
  }

  void releasePlayer() {
    generation++;
    transfer.cancel();
    loading = false;
    chewie?.dispose();
    chewie = null;
    final controller = video;
    video = null;
    if (controller != null) {
      unawaited(
        controller
            .pause()
            .catchError((Object _) {})
            .then((_) => controller.dispose())
            .catchError((Object _) {}),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      pause();
    }
  }

  @override
  void dispose() {
    releasePlayer();
    transfer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return const SizedBox.shrink();
    final text = AppLocalizations.of(context)!;
    if (failed) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text.videoError),
            TextButton(
              onPressed: () {
                setState(() => failed = false);
                initialize();
              },
              child: Text(text.retry),
            ),
          ],
        ),
      );
    }
    if (chewie == null) {
      return ListenableBuilder(
        listenable: transfer,
        builder: (context, _) => GalleryTransferStatus(transfer: transfer),
      );
    }
    return Center(child: Chewie(controller: chewie!));
  }
}
