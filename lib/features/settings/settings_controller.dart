import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider = Provider<SettingsController>(
  (ref) => throw StateError('Settings must be initialized'),
);

class SettingsController extends ChangeNotifier {
  SettingsController(this.preferences);
  final SharedPreferencesAsync preferences;
  ThemeMode theme = ThemeMode.system;
  String language = 'system';
  static const languages = ['system', 'en', 'hi'];

  static const key = 'cpdrive.settings.v1';
  Future<void> load() async {
    final raw = await preferences.getString(key);
    if (raw == null) {
      return;
    }
    try {
      final value = jsonDecode(raw);
      if (value is! Map) {
        return;
      }
      theme = ThemeMode.values.firstWhere(
        (t) => t.name == value['theme'],
        orElse: () => ThemeMode.system,
      );
      language = languages.contains(value['language'])
          ? value['language'] as String
          : 'system';
    } on FormatException {
      /* Invalid saved data uses defaults. */
    }
  }

  Future<void> update({ThemeMode? themeMode, String? locale}) async {
    if (locale != null && !languages.contains(locale)) {
      throw ArgumentError('Unsupported settings value');
    }
    final next = {
      'theme': (themeMode ?? theme).name,
      'language': locale ?? language,
    };
    await preferences.setString(key, jsonEncode(next));
    theme = themeMode ?? theme;
    language = locale ?? language;
    notifyListeners();
  }
}
