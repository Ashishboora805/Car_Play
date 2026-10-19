import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../gallery/gallery_screen.dart';
import '../browser/browser_screen.dart';
import '../music/music_screen.dart';
import '../quick_access/quick_access_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  final openRequest = ValueNotifier<String?>(null);

  @override
  void dispose() {
    openRequest.dispose();
    super.dispose();
  }

  void openUrl(String url) {
    openRequest.value = url;
    setState(() => selected = 3);
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final labels = [
      text.quickAccess,
      text.music,
      text.gallery,
      text.browser,
      text.settings,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(selected == 0 ? text.appTitle : labels[selected]),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: selected,
          children: [
            QuickAccessScreen(
              onOpenUrl: openUrl,
              onOpenTab: (index) => setState(() => selected = index),
            ),
            MusicScreen(active: selected == 1),
            GalleryScreen(active: selected == 2),
            BrowserScreen(active: selected == 3, openRequest: openRequest),
            const SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (value) => setState(() => selected = value),
        destinations: [
          for (final (i, icon) in [
            Icons.apps,
            Icons.library_music,
            Icons.photo_library,
            Icons.language,
            Icons.settings,
          ].indexed)
            NavigationDestination(icon: Icon(icon), label: labels[i]),
        ],
      ),
    );
  }
}
