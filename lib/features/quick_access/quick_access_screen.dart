import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class QuickSite {
  const QuickSite(this.name, this.url, this.icon, this.color);
  final String name, url;
  final IconData icon;
  final Color color;
}

const quickSites = [
  QuickSite('Google', 'https://www.google.com', Icons.search, Color(0xFF4285F4)),
  QuickSite(
    'YouTube',
    'https://m.youtube.com',
    Icons.smart_display,
    Color(0xFFFF0000),
  ),
  QuickSite('Gmail', 'https://mail.google.com', Icons.mail, Color(0xFFEA4335)),
  QuickSite('Maps', 'https://maps.google.com', Icons.map, Color(0xFF34A853)),
  QuickSite(
    'Cricbuzz',
    'https://m.cricbuzz.com',
    Icons.sports_cricket,
    Color(0xFF009270),
  ),
  QuickSite(
    'Wikipedia',
    'https://www.wikipedia.org',
    Icons.menu_book,
    Color(0xFF636466),
  ),
  QuickSite(
    'News',
    'https://news.google.com',
    Icons.newspaper,
    Color(0xFF1A73E8),
  ),
  QuickSite(
    'Translate',
    'https://translate.google.com',
    Icons.translate,
    Color(0xFF4285F4),
  ),
];

class QuickAccessScreen extends StatelessWidget {
  const QuickAccessScreen({
    super.key,
    required this.onOpenUrl,
    required this.onOpenTab,
  });

  /// Opens a website in the in-app browser.
  final ValueChanged<String> onOpenUrl;

  /// Switches the home screen to the given bottom-navigation index.
  final ValueChanged<int> onOpenTab;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final appShortcuts = [
      (text.music, Icons.library_music, scheme.error, 1),
      (text.gallery, Icons.photo_library, scheme.tertiary, 2),
      (text.browser, Icons.language, scheme.primary, 3),
      (text.settings, Icons.settings, scheme.secondary, 4),
    ];
    return CustomScrollView(
      slivers: [
        _header(context, text.quickWebsites),
        _grid([
          for (final site in quickSites)
            _QuickTile(
              label: site.name,
              icon: site.icon,
              color: site.color,
              onTap: () => onOpenUrl(site.url),
            ),
        ]),
        _header(context, text.quickApp),
        _grid([
          for (final (label, icon, color, index) in appShortcuts)
            _QuickTile(
              label: label,
              icon: icon,
              color: color,
              onTap: () => onOpenTab(index),
            ),
        ]),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }

  Widget _header(BuildContext context, String title) => SliverPadding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    sliver: SliverToBoxAdapter(
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    ),
  );

  Widget _grid(List<Widget> children) => SliverLayoutBuilder(
    builder: (context, constraints) {
      if (constraints.crossAxisExtent <= 0) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        sliver: SliverGrid.extent(
          maxCrossAxisExtent: 110,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.9,
          children: children,
        ),
      );
    },
  );
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
