import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class GalleryPermissionScreen extends StatelessWidget {
  const GalleryPermissionScreen({
    super.key,
    required this.denied,
    required this.onAllow,
    required this.onSettings,
  });
  final bool denied;
  final VoidCallback onAllow;
  final VoidCallback onSettings;
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.photo_library_outlined, size: 64),
            const SizedBox(height: 16),
            Text(
              denied ? text.galleryDenied : text.galleryAccess,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              denied ? text.galleryDeniedHint : text.galleryReason,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: denied ? onSettings : onAllow,
              child: Text(denied ? text.openSettings : text.allowAccess),
            ),
            if (denied) TextButton(onPressed: onAllow, child: Text(text.retry)),
          ],
        ),
      ),
    );
  }
}
