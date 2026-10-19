import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../l10n/app_localizations.dart';
import 'gallery_controller.dart';
import 'gallery_format.dart';
import 'gallery_library.dart';
import 'gallery_permission_screen.dart';
import 'gallery_viewer.dart';
import 'gallery_asset.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key, required this.active});
  final bool active;
  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen>
    with WidgetsBindingObserver {
  late final GalleryController controller;
  final scroll = ScrollController();
  bool started = false;
  @override
  void initState() {
    super.initState();
    controller = GalleryController(ref.read(galleryLibraryProvider));
    WidgetsBinding.instance.addObserver(this);
    scroll.addListener(more);
    if (widget.active) {
      started = true;
      controller.refresh();
    }
  }

  void more() {
    if (scroll.hasClients && scroll.position.extentAfter < 600) {
      controller.loadMore();
    }
  }

  @override
  void didUpdateWidget(covariant GalleryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      started = true;
      controller.refresh();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && widget.active && started) {
      controller.refresh();
    }
  }

  Future<void> openSettings() async {
    try {
      await controller.library.openSettings();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.actionFailed)),
        );
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scroll.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> viewer(int index) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) =>
            GalleryViewer(controller: controller, initialIndex: index),
      ),
    );
    if (mounted) {
      controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (controller.busy && !controller.accessible) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!controller.accessible) {
          if (controller.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(text.galleryError),
                  TextButton(
                    onPressed: controller.refresh,
                    child: Text(text.retry),
                  ),
                ],
              ),
            );
          }
          return GalleryPermissionScreen(
            denied:
                controller.requested &&
                controller.permission != null &&
                controller.permission != PermissionState.notDetermined,
            onAllow: () => controller.refresh(request: true),
            onSettings: openSettings,
          );
        }
        return Column(
          children: [
            if (controller.limited)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(text.limitedAccess),
                    TextButton(
                      onPressed: controller.busy ? null : controller.selectMore,
                      child: Text(text.selectMore),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                value:
                    [
                      'all',
                      'videos',
                      'favorites',
                      ...controller.albums.map((a) => a.id),
                    ].contains(controller.selectedAlbum)
                    ? controller.selectedAlbum
                    : 'all',
                isExpanded: true,
                hint: Text(text.albums),
                items: [
                  DropdownMenuItem(value: 'all', child: Text(text.allMedia)),
                  DropdownMenuItem(value: 'videos', child: Text(text.videos)),
                  DropdownMenuItem(
                    value: 'favorites',
                    child: Text(text.favorites),
                  ),
                  for (final album in controller.albums.where(
                    (album) => !album.isAll,
                  ))
                    DropdownMenuItem(
                      value: album.id,
                      child: Text(album.name, overflow: TextOverflow.ellipsis),
                    ),
                ],
                onChanged: controller.busy
                    ? null
                    : (value) => controller.choose(album: value),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  for (final (index, label) in [
                    text.allMedia,
                    text.photos,
                    text.videos,
                  ].indexed)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(label),
                        selected: controller.filter.index == index,
                        onSelected: controller.busy
                            ? null
                            : (_) => controller.choose(
                                type: GalleryFilter.values[index],
                              ),
                      ),
                    ),
                ],
              ),
            ),
            if (controller.busy) const LinearProgressIndicator(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refresh,
                child: CustomScrollView(
                  controller: scroll,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (controller.error != null)
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Text(text.galleryError),
                            TextButton(
                              onPressed: controller.busy
                                  ? null
                                  : controller.refresh,
                              child: Text(text.retry),
                            ),
                          ],
                        ),
                      ),
                    if (controller.items.isEmpty &&
                        !controller.busy &&
                        !controller.hasMore &&
                        controller.error == null)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: Text(text.emptyGallery)),
                      ),
                    SliverPadding(
                      padding: const EdgeInsets.all(4),
                      sliver: SliverLayoutBuilder(
                        builder: (context, constraints) {
                          final columns = (constraints.crossAxisExtent / 120)
                              .floor()
                              .clamp(2, 6);
                          return SliverGrid.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                ),
                            itemCount: controller.items.length,
                            itemBuilder: (context, index) {
                              final item = controller.items[index];
                              return Semantics(
                                key: ValueKey(item.id),
                                button: true,
                                label:
                                    '${item.type == AssetType.video ? text.videos : text.photos} ${index + 1}',
                                child: InkWell(
                                  onTap: () => viewer(index),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      AssetEntityImage(
                                        item,
                                        isOriginal: false,
                                        thumbnailSize:
                                            const ThumbnailSize.square(240),
                                        fit: BoxFit.cover,
                                        excludeFromSemantics: true,
                                        errorBuilder: (context, error, stack) =>
                                            const Center(
                                              child: Icon(
                                                Icons.broken_image_outlined,
                                              ),
                                            ),
                                      ),
                                      Positioned(
                                        left: 4,
                                        top: 4,
                                        child: GalleryCloudBadge(asset: item),
                                      ),
                                      if (item.type == AssetType.video)
                                        Positioned(
                                          right: 4,
                                          bottom: 4,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            color: Colors.black87,
                                            child: Text(
                                              mediaDuration(item.duration),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    if (controller.loadingMore)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    if (controller.hasMore &&
                        !controller.busy &&
                        !controller.loadingMore)
                      SliverToBoxAdapter(
                        child: TextButton(
                          onPressed: controller.loadMore,
                          child: Text(text.loadMore),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
