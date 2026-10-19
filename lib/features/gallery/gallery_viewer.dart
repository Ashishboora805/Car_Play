import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/app_localizations.dart';
import 'gallery_controller.dart';
import 'gallery_format.dart';
import 'gallery_video.dart';
import 'gallery_asset.dart';

class GalleryViewer extends StatefulWidget {
  const GalleryViewer({
    super.key,
    required this.controller,
    required this.initialIndex,
  });
  final GalleryController controller;
  final int initialIndex;
  @override
  State<GalleryViewer> createState() => _GalleryViewerState();
}

class _GalleryViewerState extends State<GalleryViewer> {
  late final PageController pages;
  late List<AssetEntity> items;
  late int index;
  bool acting = false;
  bool extending = false;
  bool closing = false;
  void libraryChanged() {
    if (!mounted || !widget.controller.busy || closing) {
      return;
    }
    final route = ModalRoute.of(context);
    if (route == null || !route.isActive) {
      return;
    }
    closing = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // A popped route stays mounted during its exit animation.
      if (!mounted || !route.isActive) {
        return;
      }
      final navigator = Navigator.of(context);
      navigator.popUntil((candidate) => candidate == route);
      if (route.isCurrent) {
        navigator.pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(libraryChanged);
    items = List.of(widget.controller.items);
    index = widget.initialIndex;
    pages = PageController(initialPage: index);
    if (index >= items.length - 4) {
      extend();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(libraryChanged);
    pages.dispose();
    super.dispose();
  }

  Future<void> extend() async {
    if (extending ||
        widget.controller.busy ||
        widget.controller.loadingMore ||
        !widget.controller.hasMore) {
      return;
    }
    extending = true;
    final oldLength = items.length;
    // Favorites may be sparse; keep reading bounded native pages until a new item is found.
    do {
      await widget.controller.loadMore();
      if (!mounted) {
        return;
      }
      final ids = items.map((asset) => asset.id).toSet();
      items.addAll(widget.controller.items.where((asset) => ids.add(asset.id)));
    } while (items.length == oldLength &&
        widget.controller.hasMore &&
        widget.controller.error == null &&
        !widget.controller.busy);
    if (mounted) {
      setState(() => extending = false);
    }
  }

  void message(String value) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }
  }

  Future<void> action(
    Future<void> Function(AssetEntity asset) operation,
  ) async {
    if (acting || items.isEmpty) {
      return;
    }
    setState(() => acting = true);
    try {
      await operation(items[index]);
    } catch (_) {
      if (mounted) {
        message(AppLocalizations.of(context)!.actionFailed);
      }
    } finally {
      if (mounted) {
        setState(() => acting = false);
      }
    }
  }

  Future<void> share(AssetEntity asset) async {
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null
        ? null
        : box.localToGlobal(Offset.zero) & box.size;
    final file = await resolveGalleryFile(context, asset);
    if (!mounted) {
      return;
    }
    if (file == null) {
      message(AppLocalizations.of(context)!.mediaUnavailable);
      return;
    }
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], sharePositionOrigin: origin),
    );
  }

  Future<void> delete(AssetEntity asset) async {
    final text = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(text.deleteMedia),
        content: Text(text.deleteHint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(text.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(text.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }
    final deleted = await widget.controller.library.delete(asset);
    if (!mounted) {
      return;
    }
    if (!deleted) {
      message(text.deleteCancelled);
      return;
    }
    // Return to a refreshed grid, avoiding stale PageView indices after deletion.
    Navigator.of(context).pop();
  }

  Future<void> info(AssetEntity asset) async {
    final text = AppLocalizations.of(context)!;
    int? size;
    try {
      final local = await asset.isLocallyAvailable();
      final file = local ? await asset.file : null;
      size = await file?.length();
    } catch (_) {
      /* Metadata remains available for cloud-only assets. */
    }
    if (!mounted) {
      return;
    }
    final album = widget.controller.selectedAlbum == 'favorites'
        ? text.favorites
        : widget.controller.selectedAlbum == 'videos'
        ? text.videos
        : widget.controller.selectedAlbum == 'all'
        ? text.allMedia
        : widget.controller.albums
                  .where((a) => a.id == widget.controller.selectedAlbum)
                  .map((a) => a.name)
                  .firstOrNull ??
              text.notAvailable;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final created = asset.createDateSecond == null
        ? text.notAvailable
        : DateFormat.yMMMd(locale).add_jm().format(asset.createDateTime);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.75,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(text.info, style: Theme.of(context).textTheme.headlineSmall),
            for (final field in [
              (text.filename, asset.title ?? text.notAvailable),
              (text.created, created),
              (
                text.fileSize,
                size == null
                    ? text.notAvailable
                    : '${(size / 1048576).toStringAsFixed(2)} MB',
              ),
              (text.resolution, '${asset.width} × ${asset.height}'),
              if (asset.type == AssetType.video)
                (text.duration, mediaDuration(asset.duration)),
              (text.album, album),
            ])
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(field.$1),
                subtitle: Text(field.$2),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(text.close),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('${index + 1} / ${items.length}'),
        actions: [
          IconButton(
            tooltip: text.share,
            onPressed: acting ? null : () => action(share),
            icon: const Icon(Icons.share),
          ),
          IconButton(
            tooltip: text.info,
            onPressed: acting ? null : () => action(info),
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(
            tooltip: text.delete,
            onPressed: acting ? null : () => action(delete),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (acting || extending) const LinearProgressIndicator(),
            Expanded(
              child: AbsorbPointer(
                absorbing: acting,
                child: PageView.builder(
                  controller: pages,
                  itemCount: items.length,
                  onPageChanged: (value) {
                    setState(() => index = value);
                    if (value >= items.length - 4) {
                      extend();
                    }
                  },
                  itemBuilder: (context, page) {
                    final item = items[page];
                    return item.type == AssetType.video
                        ? GalleryVideo(
                            key: ValueKey(item.id),
                            asset: item,
                            active: page == index && !acting,
                          )
                        : GalleryAssetContent(
                            key: ValueKey(item.id),
                            asset: item,
                            active: page == index,
                            builder: (context, file) =>
                                PhotoViewGestureDetectorScope(
                                  axis: Axis.horizontal,
                                  child: PhotoView(
                                    imageProvider: FileImage(file),
                                    minScale: PhotoViewComputedScale.contained,
                                    maxScale:
                                        PhotoViewComputedScale.covered * 4,
                                    initialScale:
                                        PhotoViewComputedScale.contained,
                                    backgroundDecoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface,
                                    ),
                                    loadingBuilder: (context, event) =>
                                        const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    errorBuilder: (context, error, stack) =>
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(24),
                                            child: Text(text.mediaUnavailable),
                                          ),
                                        ),
                                  ),
                                ),
                          );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  tooltip: text.previousItem,
                  onPressed: index == 0 || acting
                      ? null
                      : () => pages.previousPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        ),
                  icon: const Icon(Icons.chevron_left),
                ),
                if (index == items.length - 1 && widget.controller.hasMore)
                  TextButton(
                    onPressed: extending ? null : extend,
                    child: Text(text.loadMore),
                  ),
                IconButton(
                  tooltip: text.nextItem,
                  onPressed: index >= items.length - 1 || acting
                      ? null
                      : () => pages.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        ),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
