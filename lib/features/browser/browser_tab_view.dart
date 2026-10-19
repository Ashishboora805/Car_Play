import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../l10n/app_localizations.dart';
import 'browser_models.dart';
import 'browser_urls.dart';

final browserViewBuilderProvider = Provider<Widget Function(BrowserTabView)>(
  (ref) =>
      (view) => view,
);

class BrowserRuntime {
  InAppWebViewController? controller;
  FindInteractionController? find;
  double progress = 1;
  bool back = false, forward = false;
  bool sslBlocked = false, failed = false;
  String? lastHistory;
}

class BrowserTabView extends StatefulWidget {
  const BrowserTabView({
    super.key,
    required this.tab,
    required this.runtime,
    required this.active,
    required this.onChanged,
    required this.onPage,
    required this.onLink,
    required this.onPermission,
    required this.onDownload,
    required this.onPopup,
    required this.onClose,
  });
  final BrowserTab tab;
  final BrowserRuntime runtime;
  final bool active;
  final VoidCallback onChanged, onPage, onClose;
  final Future<void> Function(Uri uri) onLink;
  final Future<PermissionResponse> Function(PermissionRequest request)
  onPermission;
  final Future<void> Function(
    InAppWebViewController controller,
    DownloadStartRequest request,
  )
  onDownload;
  final Future<bool> Function(CreateWindowAction action) onPopup;
  @override
  State<BrowserTabView> createState() => _BrowserTabViewState();
}

class _BrowserTabViewState extends State<BrowserTabView>
    with WidgetsBindingObserver {
  late final FindInteractionController find;
  Future<void> _lifecycle = Future.value();
  InAppWebViewSettings settings() => InAppWebViewSettings(
    incognito: widget.tab.incognito,
    cacheEnabled: !widget.tab.incognito,
    saveFormData: !widget.tab.incognito,
    useShouldOverrideUrlLoading: true,
    useOnDownloadStart: true,
    useOnNavigationResponse: true,
    supportMultipleWindows: true,
    javaScriptCanOpenWindowsAutomatically: false,
    mediaPlaybackRequiresUserGesture: true,
    allowsInlineMediaPlayback: true,
    allowFileAccess: false,
    allowFileAccessFromFileURLs: false,
    allowUniversalAccessFromFileURLs: false,
    mixedContentMode: MixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
    preferredContentMode: widget.tab.desktop
        ? UserPreferredContentMode.DESKTOP
        : UserPreferredContentMode.MOBILE,
    textZoom: widget.tab.zoom,
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    find = FindInteractionController();
    widget.runtime.find = find;
  }

  void changed() {
    if (mounted) {
      widget.onChanged();
    }
  }

  Future<void> pause() =>
      _lifecycle = _lifecycle.catchError((Object _) {}).then((_) => _pause());
  Future<void> resume() => _lifecycle = _lifecycle
      .catchError((Object _) {})
      .then((_) async {
        if (mounted &&
            widget.active &&
            WidgetsBinding.instance.lifecycleState ==
                AppLifecycleState.resumed &&
            defaultTargetPlatform == TargetPlatform.android) {
          await widget.runtime.controller?.resume();
        }
      })
      .catchError((Object _) {});
  Future<void> _pause() async {
    if (!mounted) return;
    final controller = widget.runtime.controller;
    if (controller == null) {
      return;
    }
    try {
      await controller.evaluateJavascript(
        source: "document.querySelectorAll('audio,video').forEach(function(e){e.pause();});",
      );
      if (defaultTargetPlatform == TargetPlatform.android) {
        await controller.pause();
      } else {
        await controller.pauseAllMediaPlayback();
      }
    } catch (_) {
      /* The view may already be closing. */
    }
  }

  @override
  void didUpdateWidget(covariant BrowserTabView old) {
    super.didUpdateWidget(old);
    if (!widget.active && old.active) {
      unawaited(pause());
    } else if (!old.active && defaultTargetPlatform == TargetPlatform.android) {
      unawaited(resume());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      unawaited(pause());
    } else if (widget.active &&
        defaultTargetPlatform == TargetPlatform.android) {
      unawaited(resume());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.runtime.controller = null;
    widget.runtime.find = null;
    super.dispose();
  }

  Future<void> update(
    InAppWebViewController controller,
    WebUri? url, {
    bool record = false,
  }) async {
    if (!mounted) {
      return;
    }
    if (url != null && (isWebAddress(url) || url.toString() == 'about:blank')) {
      widget.tab.url = url.toString();
    }
    try {
      widget.runtime.back = await controller.canGoBack();
      widget.runtime.forward = await controller.canGoForward();
      final title = await controller.getTitle();
      if (title != null && title.isNotEmpty) {
        widget.tab.title = title;
      }
    } catch (_) {
      return;
    }
    if (!mounted) {
      return;
    }
    if (record &&
        widget.tab.zoom != 100 &&
        defaultTargetPlatform == TargetPlatform.iOS) {
      try {
        await controller.evaluateJavascript(
          source:
              "document.documentElement.style.webkitTextSizeAdjust='${widget.tab.zoom}%';document.documentElement.style.textSizeAdjust='${widget.tab.zoom}%';",
        );
      } catch (_) {}
    }
    changed();
    if (record && !widget.runtime.sslBlocked && !widget.runtime.failed) {
      widget.onPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: widget.tab.windowId == null
              ? URLRequest(url: WebUri(widget.tab.url))
              : null,
          windowId: widget.tab.windowId,
          initialSettings: settings(),
          findInteractionController: find,
          onWebViewCreated: (controller) {
            widget.runtime.controller = controller;
            widget.tab.windowId = null;
            if (!widget.active) {
              unawaited(pause());
            }
          },
          onLoadStart: (controller, url) {
            widget.runtime.progress = 0;
            widget.runtime.failed = false;
            unawaited(update(controller, url));
          },
          onProgressChanged: (controller, progress) {
            widget.runtime.progress = progress / 100;
            changed();
          },
          onLoadStop: (controller, url) =>
              update(controller, url, record: true),
          onUpdateVisitedHistory: (controller, url, isReload) =>
              update(controller, url, record: true),
          onTitleChanged: (controller, title) {
            widget.tab.title = title ?? '';
            changed();
          },
          onReceivedError: (controller, request, error) {
            if (request.isForMainFrame == true) {
              if (error.type == WebResourceErrorType.SECURE_CONNECTION_FAILED ||
                  error.type == WebResourceErrorType.FAILED_SSL_HANDSHAKE ||
                  error.type ==
                      WebResourceErrorType.SERVER_CERTIFICATE_UNTRUSTED ||
                  error.type ==
                      WebResourceErrorType.SERVER_CERTIFICATE_HAS_BAD_DATE ||
                  error.type ==
                      WebResourceErrorType
                          .SERVER_CERTIFICATE_HAS_UNKNOWN_ROOT ||
                  error.type ==
                      WebResourceErrorType.SERVER_CERTIFICATE_NOT_YET_VALID) {
                widget.runtime.sslBlocked = true;
              }
              widget.runtime.failed = true;
              widget.runtime.progress = 1;
              changed();
            }
          },
          onReceivedHttpError: (controller, request, response) {
            if (request.isForMainFrame == true) {
              widget.runtime.failed = true;
              widget.runtime.progress = 1;
              changed();
            }
          },
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            // WKWebView also asks about valid certificates. Let the OS evaluate
            // trust; a rejected certificate reaches onReceivedError above.
            if (defaultTargetPlatform == TargetPlatform.iOS) return null;
            widget.runtime.sslBlocked = true;
            widget.runtime.progress = 1;
            changed();
            return ServerTrustAuthResponse(
              action: ServerTrustAuthResponseAction.CANCEL,
            );
          },
          shouldOverrideUrlLoading: (controller, action) async {
            final url = action.request.url;
            if (url == null) {
              return NavigationActionPolicy.CANCEL;
            }
            if (isWebAddress(url) || url.toString() == 'about:blank') {
              return NavigationActionPolicy.ALLOW;
            }
            if (action.isForMainFrame && widget.active) {
              await widget.onLink(url);
            }
            return NavigationActionPolicy.CANCEL;
          },
          onPermissionRequest: (controller, request) =>
              widget.onPermission(request),
          onGeolocationPermissionsShowPrompt: (controller, origin) async =>
              GeolocationPermissionShowPromptResponse(
                origin: origin,
                allow: false,
                retain: false,
              ),
          onDownloadStartRequest: widget.onDownload,
          onCreateWindow: (controller, action) => widget.onPopup(action),
          onCloseWindow: (controller) => widget.onClose(),
        ),
        if (widget.tab.url == 'about:blank')
          Positioned.fill(
            child: ColoredBox(
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    widget.tab.incognito ? text.privateNote : text.blankTab,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        if (widget.runtime.sslBlocked || widget.runtime.failed)
          Positioned.fill(
            child: ColoredBox(
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.runtime.sslBlocked
                            ? Icons.gpp_bad_outlined
                            : Icons.cloud_off,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.runtime.sslBlocked
                            ? text.sslBlocked
                            : text.pageError,
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          widget.runtime.sslBlocked = false;
                          widget.runtime.failed = false;
                          changed();
                          unawaited(
                            widget.runtime.controller?.reload().catchError(
                                  (Object _) {},
                                ) ??
                                Future.value(),
                          );
                        },
                        child: Text(text.retry),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
