import 'package:drive/features/home/home_screen.dart';
import 'package:drive/features/quick_access/quick_access_screen.dart';
import 'package:drive/features/settings/settings_controller.dart';
import 'package:drive/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  testWidgets('quick access tolerates a zero-width viewport', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizedBox(
          width: 0,
          height: 600,
          child: QuickAccessScreen(
            onOpenUrl: _ignoreUrl,
            onOpenTab: _ignoreTab,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('home shows quick access shortcuts and opens settings', (
    tester,
  ) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    final settings = SettingsController(SharedPreferencesAsync());
    await tester.pumpWidget(
      ProviderScope(
        overrides: [settingsProvider.overrideWithValue(settings)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Quick access'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
    expect(find.text('YouTube'), findsOneWidget);
    expect(find.text('Gallery'), findsWidgets);
    expect(find.text('Browser'), findsWidgets);
    expect(find.text('Matches'), findsNothing);
    await tester.tap(find.byIcon(Icons.settings).last);
    await tester.pumpAndSettle();
    expect(find.text('Theme'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    settings.dispose();
  });
}

void _ignoreUrl(String _) {}

void _ignoreTab(int _) {}
