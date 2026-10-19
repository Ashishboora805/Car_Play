import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool saving = false;
  Future<void> save(Future<void> Function() operation) async {
    if (saving) {
      return;
    }
    setState(() => saving = true);
    try {
      await operation();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.saveError)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final text = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, child) {
        return AbsorbPointer(
          absorbing: saving,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (saving) const LinearProgressIndicator(),
              DropdownButtonFormField<ThemeMode>(
                key: ValueKey(settings.theme),
                initialValue: settings.theme,
                isExpanded: true,
                decoration: InputDecoration(labelText: text.theme),
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(text.system),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(text.light),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(text.dark),
                  ),
                ],
                onChanged: (v) => save(() => settings.update(themeMode: v)),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                key: ValueKey(settings.language),
                initialValue: settings.language,
                isExpanded: true,
                decoration: InputDecoration(labelText: text.language),
                items: [
                  DropdownMenuItem(value: 'system', child: Text(text.system)),
                  const DropdownMenuItem(value: 'en', child: Text('English')),
                  const DropdownMenuItem(value: 'hi', child: Text('हिन्दी')),
                ],
                onChanged: (v) => save(() => settings.update(locale: v)),
              ),
            ],
          ),
        );
      },
    );
  }
}
