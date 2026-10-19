import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../l10n/app_localizations.dart';
import 'music_handler.dart';
import 'music_library.dart';

class MusicScreen extends ConsumerStatefulWidget {
  const MusicScreen({super.key, required this.active});
  final bool active;
  @override
  ConsumerState<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends ConsumerState<MusicScreen> {
  List<Song>? songs;
  bool allowed = false, loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.active) load();
  }

  @override
  void didUpdateWidget(covariant MusicScreen old) {
    super.didUpdateWidget(old);
    if (widget.active && songs == null && !loading) load();
  }

  Future<void> load({bool request = false}) async {
    final library = ref.read(musicLibraryProvider);
    setState(() => loading = true);
    try {
      allowed = (await library.permission(request: request)).hasAccess;
      songs = allowed ? await library.songs(refresh: true) : const [];
    } catch (_) {
      songs = const [];
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final handler = ref.watch(musicHandlerProvider);
    final list = songs;
    if (list == null || loading && list.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!allowed) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.library_music, size: 64),
              const SizedBox(height: 16),
              Text(text.musicPermission, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => load(request: true),
                child: Text(text.musicAllow),
              ),
              TextButton(
                onPressed: () => ref.read(musicLibraryProvider).openSettings(),
                child: Text(text.openSettings),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: load,
            child: list.isEmpty
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          text.musicEmpty,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final song = list[index];
                      return ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text(
                          song.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(song.folder),
                        onTap: handler == null
                            ? null
                            : () => handler.playFromMediaId(
                                '${MusicHandler.songsId}::${song.id}',
                              ),
                      );
                    },
                  ),
          ),
        ),
        if (handler != null) _NowPlaying(handler: handler),
      ],
    );
  }
}

class _NowPlaying extends StatelessWidget {
  const _NowPlaying({required this.handler});
  final MusicHandler handler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: handler.mediaItem,
      builder: (context, item) {
        final current = item.data;
        if (current == null) return const SizedBox.shrink();
        return StreamBuilder<PlaybackState>(
          stream: handler.playbackState,
          builder: (context, state) {
            final playing = state.data?.playing ?? false;
            return Material(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              child: ListTile(
                leading: const Icon(Icons.graphic_eq),
                title: Text(
                  current.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: handler.skipToPrevious,
                    ),
                    IconButton(
                      icon: Icon(playing ? Icons.pause : Icons.play_arrow),
                      onPressed: playing ? handler.pause : handler.play,
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: handler.skipToNext,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
