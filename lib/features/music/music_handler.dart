import 'dart:async';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../l10n/app_localizations.dart';
import 'music_library.dart';

final musicLibraryProvider = Provider<MusicLibrary>((ref) => MusicLibrary());

/// Null when native audio failed to start; the phone UI stays usable.
final musicHandlerProvider = Provider<MusicHandler?>((ref) => null);

Future<MusicHandler?> initializeMusic(MusicLibrary library) async {
  try {
    return await AudioService.init<MusicHandler>(
      builder: () => MusicHandler(library),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.cricketerspitch.drive.music',
        androidNotificationChannelName: 'CP Drive music',
        androidNotificationIcon: 'drawable/ic_audio_notification',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
  } catch (_) {
    return null;
  }
}

/// Plays device music and exposes it to Android Auto as a browsable tree:
/// root -> Songs | Folders -> folder -> songs.
/// Playable ids are `<parentId>::<songId>` so the queue follows the list
/// the song was picked from.
class MusicHandler extends BaseAudioHandler with SeekHandler {
  MusicHandler(this.library) {
    _player.playbackEventStream.listen(
      (_) => _broadcast(),
      onError: (Object error, StackTrace _) => _broadcast(error: error),
    );
    _player.playingStream.listen((_) => _broadcast());
    _player.currentIndexStream.listen((index) {
      final items = queue.value;
      if (index != null && index < items.length) {
        mediaItem.add(items[index]);
      }
    });
    _broadcast();
  }

  static const songsId = 'songs', foldersId = 'folders';
  static const folderPrefix = 'folder:';
  final MusicLibrary library;
  final _player = AudioPlayer();

  AppLocalizations get text => lookupAppLocalizations(
    Locale(
      PlatformDispatcher.instance.locale.languageCode == 'hi' ? 'hi' : 'en',
    ),
  );

  MediaItem _item(String parent, Song song) => MediaItem(
    id: '$parent::${song.id}',
    title: song.title,
    album: song.folder,
    duration: song.duration > Duration.zero ? song.duration : null,
    playable: true,
  );

  MediaItem _folder(String id, String title) =>
      MediaItem(id: id, title: title, playable: false);

  Future<List<Song>> _songsIn(String parent) async {
    final songs = await library.songs();
    if (parent.startsWith(folderPrefix)) {
      final name = parent.substring(folderPrefix.length);
      return songs.where((song) => song.folder == name).toList();
    }
    return songs;
  }

  @override
  Future<List<MediaItem>> getChildren(
    String parentMediaId, [
    Map<String, dynamic>? options,
  ]) async {
    if (parentMediaId == AudioService.recentRootId) {
      final current = mediaItem.value;
      return current == null ? const [] : [current];
    }
    if (parentMediaId == AudioService.browsableRootId) {
      if (!await library.allowed) {
        // Permission can only be granted on the phone, never in the car.
        return [_folder('permission', text.musicCarPermission)];
      }
      return [
        _folder(songsId, text.musicSongs),
        _folder(foldersId, text.musicFolders),
      ];
    }
    if (parentMediaId == foldersId) {
      return [
        for (final name in await library.folders())
          _folder('$folderPrefix$name', name),
      ];
    }
    if (parentMediaId == songsId || parentMediaId.startsWith(folderPrefix)) {
      return [
        for (final song in await _songsIn(parentMediaId))
          _item(parentMediaId, song),
      ];
    }
    return const [];
  }

  @override
  Future<void> playFromMediaId(
    String mediaId, [
    Map<String, dynamic>? extras,
  ]) async {
    final split = mediaId.lastIndexOf('::');
    final parent = split < 0 ? songsId : mediaId.substring(0, split);
    final id = split < 0 ? mediaId : mediaId.substring(split + 2);
    final songs = await _songsIn(parent);
    final index = songs.indexWhere((song) => song.id == id);
    if (index >= 0) {
      await _playList(parent, songs, index);
    }
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) =>
      playFromMediaId(mediaItem.id);

  @override
  Future<List<MediaItem>> search(
    String query, [
    Map<String, dynamic>? extras,
  ]) async {
    final words = query.toLowerCase().trim();
    return [
      for (final song in await library.songs())
        if (words.isEmpty ||
            song.title.toLowerCase().contains(words) ||
            song.folder.toLowerCase().contains(words))
          _item(songsId, song),
    ];
  }

  @override
  Future<void> playFromSearch(
    String query, [
    Map<String, dynamic>? extras,
  ]) async {
    final results = await search(query, extras);
    final songs = await library.songs();
    final picked = query.trim().isEmpty
        ? songs
        : [
            for (final item in results)
              songs.firstWhere((song) => item.id == '$songsId::${song.id}'),
          ];
    if (picked.isNotEmpty) {
      await _playList(songsId, picked, 0);
    }
  }

  Future<void> _playList(String parent, List<Song> songs, int index) async {
    queue.add([for (final song in songs) _item(parent, song)]);
    mediaItem.add(queue.value[index]);
    try {
      await _player.setAudioSources([
        for (final song in songs) AudioSource.uri(Uri.parse(song.uri)),
      ], initialIndex: index);
      // play() completes only when playback stops, so it is not awaited.
      unawaited(_player.play());
    } catch (error) {
      _broadcast(error: error);
    }
  }

  @override
  Future<void> play() async {
    if (queue.value.isEmpty) {
      final songs = await library.songs();
      if (songs.isNotEmpty) await _playList(songsId, songs, 0);
      return;
    }
    unawaited(_player.play());
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() async {
    if (_player.position > const Duration(seconds: 3) || !_player.hasPrevious) {
      await _player.seek(Duration.zero);
    } else {
      await _player.seekToPrevious();
    }
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index >= 0 && index < queue.value.length) {
      await _player.seek(Duration.zero, index: index);
      unawaited(_player.play());
    }
  }

  void _broadcast({Object? error}) {
    final playing = _player.playing;
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.playFromMediaId,
          MediaAction.playFromSearch,
        },
        androidCompactActionIndices: const [0, 1, 2],
        processingState: error != null
            ? AudioProcessingState.error
            : switch (_player.processingState) {
                ProcessingState.idle => AudioProcessingState.idle,
                ProcessingState.loading => AudioProcessingState.loading,
                ProcessingState.buffering => AudioProcessingState.buffering,
                ProcessingState.ready => AudioProcessingState.ready,
                ProcessingState.completed => AudioProcessingState.completed,
              },
        errorMessage: error != null ? text.musicError : null,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: _player.currentIndex,
      ),
    );
  }
}
