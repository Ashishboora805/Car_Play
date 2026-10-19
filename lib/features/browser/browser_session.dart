import 'package:flutter/foundation.dart';

import 'browser_models.dart';
import 'browser_store.dart';

class BrowserSession extends ChangeNotifier {
  BrowserSession(
    this.store, {
    required this.clearPrivateData,
    required this.afterViewsRemoved,
    required this.android,
  });
  final BrowserStore store;
  final Future<void> Function() clearPrivateData, afterViewsRemoved;
  final bool android;
  List<BrowserTab> tabs = [];
  String? selectedId;
  bool ready = false;
  bool transitioning = false;
  Object? error;
  int viewGeneration = 0;
  bool _disposed = false;
  final List<String> _recent = [];
  static const maxLiveViews = 4;
  void _retain(BrowserTab tab) {
    _recent.remove(tab.id);
    _recent.add(tab.id);
    while (_recent.length > maxLiveViews) {
      final evicted = _recent.removeAt(0);
      for (final item in tabs.where((item) => item.id == evicted)) {
        item.visited = false;
      }
    }
    tab.visited = true;
  }

  static int _id = 0;
  BrowserTab get selected =>
      tabs.firstWhere((tab) => tab.id == selectedId, orElse: () => tabs.first);
  bool get incognito => tabs.isNotEmpty && selected.incognito;
  BrowserTab create({
    bool private = false,
    String url = 'about:blank',
    int? windowId,
  }) => BrowserTab(
    id: '${DateTime.now().microsecondsSinceEpoch}_${_id++}',
    incognito: private,
    url: url,
    windowId: windowId,
  );
  Future<void> initialize() async {
    error = null;
    try {
      if (android && await store.value('privateDirty') == 'true') {
        await clearPrivateData();
        await store.setValue('privateDirty', 'false');
      }
      tabs = await store.tabs();
      if (tabs.isEmpty) {
        tabs.add(create());
      }
      selectedId = await store.value('selected');
      if (!tabs.any((t) => t.id == selectedId)) {
        selectedId = tabs.first.id;
      }
      _retain(selected);
      await store.saveTabs(tabs, selectedId);
      ready = true;
    } catch (failure) {
      error = failure;
    }
    if (!_disposed) {
      notifyListeners();
    }
  }

  Future<void> select(BrowserTab tab) async {
    if (transitioning || _disposed || !tabs.contains(tab)) {
      return;
    }
    error = null;
    if (tab.incognito != incognito) {
      transitioning = true;
      notifyListeners();
      try {
        await afterViewsRemoved();
        if (android) {
          await clearPrivateData();
          await store.setValue(
            'privateDirty',
            tab.incognito ? 'true' : 'false',
          );
        }
        viewGeneration++;
        _recent.clear();
        for (final t in tabs) {
          t.visited = false;
        }
      } catch (failure) {
        error = failure;
        transitioning = false;
        ready = false;
        if (!_disposed) {
          notifyListeners();
        }
        return;
      }
    }
    if (_disposed) {
      return;
    }
    selectedId = tab.id;
    _retain(tab);
    transitioning = false;
    await store.saveTabs(tabs, tab.incognito ? null : tab.id);
    if (!_disposed) {
      notifyListeners();
    }
  }

  Future<void> add({
    bool private = false,
    String url = 'about:blank',
    int? windowId,
  }) async {
    if (transitioning || _disposed) {
      throw StateError('Browser is switching modes');
    }
    if (tabs.length >= 24) {
      throw StateError('Tab limit reached');
    }
    final tab = create(private: private, url: url, windowId: windowId);
    tabs.add(tab);
    await select(tab);
  }

  Future<void> closeTab(BrowserTab tab) async {
    if (transitioning) {
      return;
    }
    if (selectedId == tab.id) {
      final choices = tabs
          .where((t) => t != tab && t.incognito == tab.incognito)
          .toList();
      if (choices.isEmpty) {
        choices.addAll(tabs.where((t) => t != tab));
      }
      if (choices.isEmpty) {
        final blank = create();
        tabs.add(blank);
        choices.add(blank);
      }
      await select(choices.first);
    }
    tabs.remove(tab);
    _recent.remove(tab.id);
    await store.saveTabs(tabs, incognito ? null : selectedId);
    if (!_disposed) {
      notifyListeners();
    }
  }

  Future<void> closeAll() async {
    final blank = create();
    tabs.add(blank);
    await select(blank);
    tabs = [blank];
    await store.saveTabs(tabs, blank.id);
    if (!_disposed) {
      notifyListeners();
    }
  }

  Future<void> save() async {
    await store.saveTabs(tabs, incognito ? null : selectedId);
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
