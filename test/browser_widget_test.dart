import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drive/features/browser/browser_models.dart';
import 'package:drive/features/browser/browser_screen.dart';
import 'package:drive/features/browser/browser_store.dart';
import 'package:drive/features/browser/browser_tab_view.dart';
import 'package:drive/l10n/app_localizations.dart';

class MemoryBrowserStore extends BrowserStore {
  MemoryBrowserStore() : super(factory: databaseFactoryFfi);
  List<BrowserTab> saved = [];
  final values = <String, String>{};
  final visits = <String>[];
  int reads = 0;
  @override
  Future<List<BrowserTab>> tabs() async {
    reads++;
    return List.of(saved);
  }

  @override
  Future<String?> value(String key) async => values[key];
  @override
  Future<void> setValue(String key, String value) async {
    values[key] = value;
  }

  @override
  Future<void> saveTabs(List<BrowserTab> tabs, String? selected) async {
    saved = tabs.where((t) => !t.incognito).toList();
    if (selected != null) {
      values['selected'] = selected;
    }
  }

  @override
  Future<List<BrowserDownload>> downloads() async => [];
  @override
  Future<void> addHistory(BrowserTab tab) async {
    if (!tab.incognito) {
      visits.add(tab.url);
    }
  }

  @override
  Future<void> close() async {}
}

void main() {
  testWidgets(
    'browser initializes lazily, searches, blocks HTTP claims and omits private persistence',
    (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final store = MemoryBrowserStore();
      BrowserTabView? view;
      final active = ValueNotifier(false);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            browserStoreProvider.overrideWithValue(store),
            browserViewBuilderProvider.overrideWithValue((configuration) {
              view = configuration;
              return Text(
                configuration.tab.incognito
                    ? 'Private view'
                    : 'web:${configuration.tab.url}',
              );
            }),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.8)),
              child: child!,
            ),
            home: Scaffold(
              body: ValueListenableBuilder<bool>(
                valueListenable: active,
                builder: (context, value, child) =>
                    BrowserScreen(active: value),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(store.reads, 0);
      active.value = true;
      await tester.pumpAndSettle();
      expect(store.reads, 1);
      expect(find.text('web:about:blank'), findsOneWidget);
      await tester.enterText(find.byType(TextField).first, 'cricket today');
      await tester.testTextInput.receiveAction(TextInputAction.go);
      await tester.pumpAndSettle();
      expect(view!.tab.url, contains('google.com/search'));
      view!.onPage();
      await tester.pump();
      expect(store.visits.length, 1);
      await tester.enterText(
        find.byType(TextField).first,
        'http://example.com',
      );
      await tester.testTextInput.receiveAction(TextInputAction.go);
      await tester.pumpAndSettle();
      expect(find.text('Not secure'), findsOneWidget);
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('New incognito tab'));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      expect(find.text('Private view'), findsOneWidget);
      await tester.enterText(
        find.byType(TextField).first,
        'https://private.example',
      );
      await tester.testTextInput.receiveAction(TextInputAction.go);
      await tester.pumpAndSettle();
      view!.onPage();
      await tester.pump();
      expect(store.visits.length, 1);
      expect(store.saved.any((tab) => tab.incognito), false);
      await tester.tap(find.byTooltip('Tabs'));
      await tester.pumpAndSettle();
      expect(find.text('Close all tabs'), findsOneWidget);
      await tester.tap(find.text('Close all tabs'));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      expect(store.saved.length, 1);
      expect(find.text('Private view'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      active.dispose();
    },
  );
}
