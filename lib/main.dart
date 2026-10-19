import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'features/music/music_handler.dart';
import 'features/music/music_library.dart';
import 'features/settings/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsController(SharedPreferencesAsync());
  try {
    await settings.load();
  } catch (_) {
    /* Storage unavailable: retain defaults. */
  }
  // Started here so Android Auto can browse music even without the phone UI.
  final music = MusicLibrary();
  final handler = await initializeMusic(music);
  runApp(
    ProviderScope(
      overrides: [
        settingsProvider.overrideWithValue(settings),
        musicLibraryProvider.overrideWithValue(music),
        musicHandlerProvider.overrideWithValue(handler),
      ],
      child: const CPDriveApp(),
    ),
  );
}
