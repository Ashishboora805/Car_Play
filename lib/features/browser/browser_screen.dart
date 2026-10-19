import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/app_localizations.dart';
import 'browser_downloads.dart';
import 'browser_external.dart';
import 'browser_library_screen.dart';
import 'browser_models.dart';
import 'browser_platform.dart';
import 'browser_session.dart';
import 'browser_store.dart';
import 'browser_tab_view.dart';
import 'browser_urls.dart';

class BrowserScreen extends ConsumerStatefulWidget {
  const BrowserScreen({super.key, required this.active, this.openRequest});
  final bool active;

  /// Set to a URL to open it in a new tab (consumed once handled).
  final ValueNotifier<String?>? openRequest;
  @override
  ConsumerState<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends ConsumerState<BrowserScreen> {
  BrowserSession? session;
  BrowserDownloads? downloads;
  final platform = BrowserPlatform();
  final external = BrowserExternal();
  final address = TextEditingController();
  final addressFocus = FocusNode();
  final findText = TextEditingController();
  final Map<String, BrowserRuntime> runtimes = {};
  int generation = 0;
  bool covered = false;
  bool finding = false;
  bool clearing = false;
  Future<void> closeForLogout() async {
    if (!mounted || clearing) return;
    clearing = true;
    saveTimer?.cancel();
    downloads?.dispose();
    session?.removeListener(changed);
    session?.dispose();
    setState(() {});
    await WidgetsBinding.instance.endOfFrame;
    runtimes.clear();
  }

  Timer? saveTimer;
  BrowserRuntime get runtime =>
      runtimes.putIfAbsent(session!.selected.id, BrowserRuntime.new);
  @override
  void initState() {
    super.initState();
    widget.openRequest?.addListener(consumeRequest);
    if (widget.active) {
      initialize();
    }
  }

  void consumeRequest() {
    final url = widget.openRequest?.value;
    final current = session;
    if (url == null || clearing || current == null || !current.ready) {
      return;
    }
    widget.openRequest!.value = null;
    unawaited(safe(() => current.add(url: browserAddress(url).toString())));
  }

  @override
  void didUpdateWidget(covariant BrowserScreen old) {
    super.didUpdateWidget(old);
    if (old.openRequest != widget.openRequest) {
      old.openRequest?.removeListener(consumeRequest);
      widget.openRequest?.addListener(consumeRequest);
    }
    if (widget.active && session == null) {
      initialize();
    }
  }

  void initialize() {
    final store = ref.read(browserStoreProvider);
    store.beforeClear.add(closeForLogout);
    session = BrowserSession(
      store,
      android: Platform.isAndroid,
      clearPrivateData: platform.clearPrivateData,
      afterViewsRemoved: () async {
        await WidgetsBinding.instance.endOfFrame;
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
    );
    downloads = BrowserDownloads(store, platform);
    session!.addListener(changed);
    unawaited(safe(loadData));
  }

  Future<void> loadData() async {
    await session!.initialize();
    if (session!.ready) {
      await downloads!.initialize();
      consumeRequest();
    }
  }

  void changed() {
    if (!mounted) {
      return;
    }
    final current = session;
    if (current == null) {
      return;
    }
    if (current.viewGeneration != generation) {
      generation = current.viewGeneration;
      runtimes.clear();
      finding = false;
      findText.clear();
    }
    if (current.tabs.isNotEmpty && !addressFocus.hasFocus) {
      address.text = current.selected.url == 'about:blank'
          ? ''
          : current.selected.url;
    }
    setState(() {});
  }

  void pageChanged() {
    if (clearing || !mounted) return;
    changed();
    saveTimer?.cancel();
    saveTimer = Timer(
      const Duration(milliseconds: 250),
      () => safe(() => session!.save()),
    );
  }

  Future<void> safe(Future<void> Function() operation) async {
    try {
      await operation();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.actionFailed)),
        );
      }
    }
  }

  Future<void> navigate(String input) async {
    final current = session!;
    final uri = browserAddress(input);
    if (!isWebAddress(uri) && uri.toString() != 'about:blank') {
      throw ArgumentError('Invalid URL');
    }
    final state = runtime;
    state.failed = false;
    state.sslBlocked = false;
    state.lastHistory = null;
    current.selected.url = uri.toString();
    addressFocus.unfocus();
    changed();
    await state.controller?.loadUrl(
      urlRequest: URLRequest(url: WebUri.uri(uri)),
    );
    await current.save();
  }

  Future<void> completed(BrowserTab tab, BrowserRuntime state) async {
    if (clearing || !mounted) return;
    if (state.failed ||
        state.sslBlocked ||
        !isWebAddress(Uri.tryParse(tab.url) ?? Uri())) {
      return;
    }
    if (state.lastHistory != tab.url) {
      state.lastHistory = tab.url;
      await session!.store.addHistory(tab);
    }
    await session!.save();
    if (!tab.incognito &&
        session!.selected == tab &&
        widget.active &&
        !covered &&
        state.progress >= 1) {
      await capture();
    }
  }

  Future<void> capture() async {
    if (session == null || session!.incognito || session!.transitioning) {
      return;
    }
    final tab = session!.selected;
    final controller = runtime.controller;
    if (controller == null || runtime.sslBlocked || runtime.failed) {
      return;
    }
    final image = await controller.takeScreenshot(
      screenshotConfiguration: ScreenshotConfiguration(
        snapshotWidth: 240,
        compressFormat: CompressFormat.JPEG,
        quality: 50,
      ),
    );
    if (mounted && !session!.incognito && session!.tabs.contains(tab)) {
      tab.thumbnail = image;
      await session!.save();
    }
  }

  Future<void> link(Uri uri) async {
    if (!mounted || !widget.active || covered) {
      return;
    }
    if (!await browserConfirm(
      context,
      AppLocalizations.of(context)!.openApp,
      detail: uri.toString(),
    )) {
      return;
    }
    await safe(() async {
      final fallback = await external.appLink(uri);
      if (fallback != null && mounted) {
        await navigate(fallback.toString());
      }
    });
  }

  Future<PermissionResponse> permission(
    BrowserTab tab,
    PermissionRequest request,
  ) async {
    PermissionResponse deny() => PermissionResponse(
      action: PermissionResponseAction.DENY,
      resources: [],
    );
    final origin = request.origin;
    final current = Uri.tryParse(tab.url);
    if (!mounted ||
        covered ||
        !widget.active ||
        session!.selected != tab ||
        origin.scheme != 'https' ||
        current == null ||
        !isWebAddress(current) ||
        current.origin != origin.origin) {
      return deny();
    }
    final wantsCamera = request.resources.any(
      (r) =>
          r == PermissionResourceType.CAMERA ||
          r == PermissionResourceType.CAMERA_AND_MICROPHONE,
    );
    final wantsMic = request.resources.any(
      (r) =>
          r == PermissionResourceType.MICROPHONE ||
          r == PermissionResourceType.CAMERA_AND_MICROPHONE,
    );
    if (!wantsCamera && !wantsMic ||
        request.resources.any(
          (r) => ![
            PermissionResourceType.CAMERA,
            PermissionResourceType.MICROPHONE,
            PermissionResourceType.CAMERA_AND_MICROPHONE,
          ].contains(r),
        )) {
      return deny();
    }
    final text = AppLocalizations.of(context)!;
    if (!await browserConfirm(
      context,
      text.websitePermission,
      detail:
          '${origin.host}\n${[if (wantsCamera) text.camera, if (wantsMic) text.microphone].join(', ')}',
    )) {
      return deny();
    }
    if (wantsCamera && !await Permission.camera.request().isGranted) {
      return deny();
    }
    if (wantsMic && !await Permission.microphone.request().isGranted) {
      return deny();
    }
    if (!mounted ||
        !widget.active ||
        covered ||
        session!.selected != tab ||
        Uri.tryParse(tab.url)?.origin != origin.origin) {
      return deny();
    }
    return PermissionResponse(
      action: PermissionResponseAction.GRANT,
      resources: request.resources,
    );
  }

  Future<void> download(
    BrowserTab tab,
    InAppWebViewController controller,
    DownloadStartRequest request,
  ) async {
    if (!mounted || !widget.active || covered || session!.selected != tab) {
      return;
    }
    final text = AppLocalizations.of(context)!;
    final uri = Uri.parse(request.url.toString());
    final name = safeDownloadName(
      request.suggestedFilename ??
          (uri.pathSegments.isEmpty ? 'download' : uri.pathSegments.last),
    );
    if (!await browserConfirm(context, text.downloadFile, detail: name)) {
      return;
    }
    if (Platform.isAndroid) {
      await Permission.notification.request();
    }
    await safe(() async {
      List<int>? bytes;
      String? cookie;
      if (uri.scheme == 'data') {
        final data = uri.data;
        if (data == null || uri.toString().length > 35000000) {
          throw StateError('Unsupported data URL');
        }
        bytes = data.contentAsBytes();
      } else if (uri.scheme == 'blob') {
        final result = await controller.callAsyncJavaScript(
          functionBody: "const response = await fetch(source); const blob = await response.blob(); if (blob.size > 26214400) throw new Error('File too large'); return await new Promise((resolve, reject) => { const reader = new FileReader(); reader.onload = () => resolve(reader.result); reader.onerror = reject; reader.readAsDataURL(blob); });",
          arguments: {'source': uri.toString()},
        );
        final value = result?.value;
        if (value is! String) {
          throw StateError('Blob unavailable');
        }
        bytes = Uri.parse(value).data?.contentAsBytes();
        if (bytes == null) {
          throw StateError('Blob unavailable');
        }
      } else if (!isWebAddress(uri)) {
        throw StateError('Unsupported download');
      } else {
        final cookies = await CookieManager.instance().getCookies(
          url: request.url,
        );
        cookie = cookies.map((c) => '${c.name}=${c.value}').join('; ');
      }
      if (bytes != null && bytes.length > 26214400) {
        throw StateError('Inline download too large');
      }
      final result = await downloads!.download(
        url: uri,
        name: name,
        mime: request.mimeType ?? 'application/octet-stream',
        completeTitle: text.downloadComplete,
        private: tab.incognito,
        cookie: cookie,
        userAgent: request.userAgent,
        bytes: bytes,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.status == 'complete'
                  ? text.downloadComplete
                  : text.downloadFailed,
            ),
          ),
        );
      }
    });
  }

  Future<void> library(BrowserLibrarySection section) async {
    setState(() => covered = true);
    try {
      final url = await Navigator.of(context).push<String>(
        MaterialPageRoute(
          builder: (_) => BrowserLibraryScreen(
            section: section,
            store: session!.store,
            downloads: downloads!,
          ),
        ),
      );
      if (mounted && url != null) {
        await navigate(url);
      }
    } finally {
      if (mounted) {
        setState(() => covered = false);
      }
    }
  }

  Future<void> switcher() async {
    await safe(capture);
    if (!mounted) {
      return;
    }
    setState(() => covered = true);
    try {
      final result = await showModalBottomSheet<Object>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) {
          final text = AppLocalizations.of(context)!;
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: ListenableBuilder(
              listenable: session!,
              builder: (context, child) => Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () => Navigator.pop(context, 'new'),
                        icon: const Icon(Icons.add),
                        label: Text(text.newTab),
                      ),
                      TextButton.icon(
                        onPressed: () => Navigator.pop(context, 'private'),
                        icon: const Icon(Icons.visibility_off),
                        label: Text(text.newPrivateTab),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'closeAll'),
                        child: Text(text.closeAllTabs),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            mainAxisExtent: 240,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: session!.tabs.length,
                      itemBuilder: (context, index) {
                        final tab = session!.tabs[index];
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () => Navigator.pop(context, tab),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    tab.title.isEmpty ? text.newTab : tab.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Icon(
                                    tab.incognito
                                        ? Icons.visibility_off
                                        : Icons.public,
                                  ),
                                  trailing: IconButton(
                                    tooltip: text.close,
                                    onPressed: () =>
                                        safe(() => session!.closeTab(tab)),
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
                                Expanded(
                                  child: tab.incognito || tab.thumbnail == null
                                      ? Center(
                                          child: Icon(
                                            tab.incognito
                                                ? Icons.visibility_off
                                                : Icons.public,
                                            size: 48,
                                          ),
                                        )
                                      : Image.memory(
                                          tab.thumbnail!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stack,
                                          ) => const Icon(Icons.public),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    tab.incognito ? text.incognito : tab.url,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      if (!mounted) {
        return;
      }
      await safe(() async {
        if (result is BrowserTab) {
          await session!.select(result);
        } else if (result == 'new') {
          await session!.add();
        } else if (result == 'private') {
          await session!.add(private: true);
        } else if (result == 'closeAll') {
          await session!.closeAll();
        }
      });
    } finally {
      if (mounted) {
        setState(() => covered = false);
      }
    }
  }

  Future<void> menu(String choice) async {
    final text = AppLocalizations.of(context)!;
    final tab = session!.selected;
    final uri = Uri.tryParse(tab.url) ?? Uri();
    await safe(() async {
      switch (choice) {
        case 'new':
          await session!.add();
        case 'private':
          await session!.add(private: true);
        case 'bookmarks':
          await library(BrowserLibrarySection.bookmarks);
        case 'history':
          await library(BrowserLibrarySection.history);
        case 'downloads':
          await library(BrowserLibrarySection.downloads);
        case 'bookmark':
          if (isWebAddress(uri)) {
            await editBookmark(
              context,
              session!.store,
              BrowserEntry(url: tab.url, title: tab.title, time: 0),
            );
          }
        case 'share':
          if (isWebAddress(uri)) {
            await SharePlus.instance.share(ShareParams(uri: uri));
          }
        case 'chrome':
          if (isWebAddress(uri)) {
            await external.chrome(uri);
          }
        case 'external':
          if (isWebAddress(uri) && !await external.external(uri)) {
            throw StateError('No browser');
          }
        case 'custom':
          if (isWebAddress(uri)) {
            await external.customTab(uri);
          }
        case 'find':
          setState(() => finding = !finding);
          if (!finding) {
            await runtime.find?.clearMatches();
          }
        case 'desktop':
          tab.desktop = !tab.desktop;
          await runtime.controller?.setSettings(
            settings: InAppWebViewSettings(
              preferredContentMode: tab.desktop
                  ? UserPreferredContentMode.DESKTOP
                  : UserPreferredContentMode.MOBILE,
            ),
          );
          await runtime.controller?.reload();
          await session!.save();
          changed();
        case 'zoom':
          final value = await showDialog<int>(
            context: context,
            builder: (context) => SimpleDialog(
              title: Text(text.textZoom),
              children: [
                for (final zoom in [50, 75, 100, 125, 150, 175, 200])
                  SimpleDialogOption(
                    onPressed: () => Navigator.pop(context, zoom),
                    child: Text('$zoom%'),
                  ),
              ],
            ),
          );
          if (value != null) {
            tab.zoom = value;
            await runtime.controller?.setSettings(
              settings: InAppWebViewSettings(textZoom: value),
            );
            if (Platform.isIOS) {
              await runtime.controller?.evaluateJavascript(
                source:
                    "document.documentElement.style.webkitTextSizeAdjust='$value%';document.documentElement.style.textSizeAdjust='$value%';",
              );
            }
            await session!.save();
            changed();
          }
      }
    });
  }

  @override
  void dispose() {
    widget.openRequest?.removeListener(consumeRequest);
    session?.store.beforeClear.remove(closeForLogout);
    saveTimer?.cancel();
    session?.removeListener(changed);
    if (!clearing) {
      session?.dispose();
      downloads?.dispose();
    }
    address.dispose();
    addressFocus.dispose();
    findText.dispose();
    if (Platform.isAndroid && session?.incognito == true) {
      unawaited(platform.clearPrivateData().catchError((Object _) {}));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (clearing) return const SizedBox.shrink();
    final text = AppLocalizations.of(context)!;
    final current = session;
    if (current == null) {
      return Center(child: Text(text.blankTab));
    }
    if (current.error != null && !current.ready) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text.browserError),
            TextButton(
              onPressed: () => safe(loadData),
              child: Text(text.retry),
            ),
          ],
        ),
      );
    }
    if (!current.ready || current.transitioning) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            Text(text.privateCleanup),
          ],
        ),
      );
    }
    final state = runtime;
    final tab = current.selected;
    final insecure = Uri.tryParse(tab.url)?.scheme == 'http';
    final group = current.tabs
        .where((t) => t.incognito == current.incognito)
        .toList();
    return Column(
      children: [
        if (current.incognito)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.visibility_off),
                const SizedBox(width: 8),
                Text(text.incognito),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: address,
                  focusNode: addressFocus,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.go,
                  autocorrect: false,
                  enableSuggestions: !current.incognito,
                  onSubmitted: (value) => safe(() => navigate(value)),
                  decoration: InputDecoration(
                    hintText: text.addressHint,
                    prefixIcon: Tooltip(
                      message: insecure
                          ? text.notSecure
                          : text.secureConnection,
                      child: Icon(
                        insecure
                            ? Icons.warning_amber
                            : tab.url.startsWith('https:')
                            ? Icons.lock_outline
                            : Icons.search,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                tooltip: text.tabs,
                onPressed: () => safe(switcher),
                icon: Badge(
                  label: Text('${current.tabs.length}'),
                  child: const Icon(Icons.tab),
                ),
              ),
              PopupMenuButton<String>(
                onSelected: menu,
                itemBuilder: (context) => [
                  for (final entry in [
                    ('new', text.newTab),
                    ('private', text.newPrivateTab),
                    ('bookmark', text.addBookmark),
                    ('bookmarks', text.bookmarks),
                    ('history', text.history),
                    ('downloads', text.downloads),
                    ('find', text.findInPage),
                    (
                      'desktop',
                      '${text.desktopSite}${tab.desktop ? ' ✓' : ''}',
                    ),
                    ('zoom', text.textZoom),
                    ('share', text.share),
                    ('chrome', text.openChrome),
                    (
                      'external',
                      Platform.isIOS ? text.openSafari : text.openExternal,
                    ),
                    ('custom', text.customTab),
                  ])
                    PopupMenuItem(value: entry.$1, child: Text(entry.$2)),
                ],
              ),
            ],
          ),
        ),
        if (insecure)
          Text(
            text.notSecure,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        if (state.progress < 1 && tab.url != 'about:blank')
          LinearProgressIndicator(
            value: state.progress == 0 ? null : state.progress,
          ),
        if (finding)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: findText,
                    decoration: InputDecoration(hintText: text.findHint),
                    onChanged: (value) => safe(
                      () =>
                          runtime.find?.findAll(find: value) ?? Future.value(),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: text.previousItem,
                  onPressed: () => safe(
                    () =>
                        runtime.find?.findNext(forward: false) ??
                        Future.value(),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_up),
                ),
                IconButton(
                  tooltip: text.nextItem,
                  onPressed: () =>
                      safe(() => runtime.find?.findNext() ?? Future.value()),
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
                IconButton(
                  tooltip: text.close,
                  onPressed: () {
                    setState(() => finding = false);
                    safe(() => runtime.find?.clearMatches() ?? Future.value());
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        Expanded(
          child: IndexedStack(
            index: group.indexOf(tab),
            children: [
              for (final item in group)
                if (!item.visited)
                  const SizedBox.shrink()
                else
                  ref.watch(browserViewBuilderProvider)(
                    BrowserTabView(
                      key: ValueKey('${generation}_${item.id}'),
                      tab: item,
                      runtime: runtimes.putIfAbsent(
                        item.id,
                        BrowserRuntime.new,
                      ),
                      active: widget.active && !covered && item == tab,
                      onChanged: pageChanged,
                      onPage: () =>
                          safe(() => completed(item, runtimes[item.id]!)),
                      onLink: link,
                      onPermission: (request) => permission(item, request),
                      onDownload: (controller, request) =>
                          download(item, controller, request),
                      onPopup: (action) async {
                        if (action.hasGesture != true ||
                            item != session!.selected ||
                            !widget.active ||
                            covered) {
                          return false;
                        }
                        try {
                          await session!.add(
                            private: item.incognito,
                            windowId: action.windowId,
                          );
                          return true;
                        } catch (_) {
                          return false;
                        }
                      },
                      onClose: () => safe(() => session!.closeTab(item)),
                    ),
                  ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              tooltip: text.back,
              onPressed: state.back
                  ? () => safe(
                      () => runtime.controller?.goBack() ?? Future.value(),
                    )
                  : null,
              icon: const Icon(Icons.arrow_back),
            ),
            IconButton(
              tooltip: text.forward,
              onPressed: state.forward
                  ? () => safe(
                      () => runtime.controller?.goForward() ?? Future.value(),
                    )
                  : null,
              icon: const Icon(Icons.arrow_forward),
            ),
            IconButton(
              tooltip: state.progress < 1 ? text.stop : text.reload,
              onPressed: () => safe(
                () => state.progress < 1
                    ? runtime.controller?.stopLoading() ?? Future.value()
                    : runtime.controller?.reload() ?? Future.value(),
              ),
              icon: Icon(state.progress < 1 ? Icons.close : Icons.refresh),
            ),
          ],
        ),
      ],
    );
  }
}
