import 'dart:async';

import 'package:drive/features/browser/browser_models.dart';
import 'package:drive/features/browser/browser_tab_view.dart';
import 'package:drive/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';

class TestWebPlatform extends InAppWebViewPlatform {
  late TestWebWidget latest;
  @override
  PlatformInAppWebViewWidget createPlatformInAppWebViewWidget(
    PlatformInAppWebViewWidgetCreationParams params,
  ) => latest = TestWebWidget(params);
  @override
  PlatformFindInteractionController createPlatformFindInteractionController(
    PlatformFindInteractionControllerCreationParams params,
  ) => TestFind(params);
}

class TestWebWidget extends PlatformInAppWebViewWidget {
  TestWebWidget(super.params) : super.implementation();
  @override
  Widget build(BuildContext context) => const SizedBox();
  @override
  T controllerFromPlatform<T>(PlatformInAppWebViewController controller) =>
      InAppWebViewController.fromPlatform(platform: controller) as T;
  @override
  void dispose() {}
}

class TestFind extends PlatformFindInteractionController {
  TestFind(super.params) : super.implementation();
}

class TestController extends PlatformInAppWebViewController {
  TestController()
    : super.implementation(
        const PlatformInAppWebViewControllerCreationParams(id: 1),
      );
  final events = <String>[];
  Completer<void>? javascript;
  @override
  Future<dynamic> evaluateJavascript({
    required String source,
    ContentWorld? contentWorld,
  }) async {
    await javascript?.future;
    return null;
  }

  @override
  Future<void> pause() async {
    events.add('pause');
  }

  @override
  Future<void> resume() async {
    events.add('resume');
  }
}

void main() {
  late TestWebPlatform platform;
  late BrowserRuntime runtime;
  late TestController controller;
  setUp(() {
    platform = TestWebPlatform();
    InAppWebViewPlatform.instance = platform;
    controller = TestController();
    runtime = BrowserRuntime()
      ..controller = InAppWebViewController.fromPlatform(platform: controller);
  });
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });
  Widget browser() => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: BrowserTabView(
        tab: BrowserTab(id: 'tab', url: 'https://example.com'),
        runtime: runtime,
        active: true,
        onChanged: () {},
        onPage: () {},
        onClose: () {},
        onLink: (_) async {},
        onPermission: (_) async =>
            PermissionResponse(action: PermissionResponseAction.DENY),
        onDownload: (_, _) async {},
        onPopup: (_) async => false,
      ),
    ),
  );
  testWidgets(
    'iOS defers valid server trust to the OS and marks rejected certificates as blocked',
    (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      await tester.pumpWidget(browser());
      final response =
          await platform.latest.params.onReceivedServerTrustAuthRequest!(
            runtime.controller!,
            ServerTrustChallenge(
              protectionSpace: URLProtectionSpace(
                host: 'example.com',
                protocol: 'https',
              ),
            ),
          );
      expect(response, isNull);
      expect(runtime.sslBlocked, false);
      platform.latest.params.onReceivedError!(
        runtime.controller!,
        WebResourceRequest(
          url: WebUri('https://example.com'),
          isForMainFrame: true,
        ),
        WebResourceError(
          type: WebResourceErrorType.SERVER_CERTIFICATE_UNTRUSTED,
          description: 'Untrusted certificate',
        ),
      );
      expect(runtime.sslBlocked, true);
      expect(runtime.failed, true);
      await tester.pumpWidget(const SizedBox());
      debugDefaultTargetPlatformOverride = null;
    },
  );
  testWidgets('Android resume waits for an unfinished background pause', (
    tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpWidget(browser());
    controller.javascript = Completer<void>();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(controller.events, isEmpty);
    controller.javascript!.complete();
    await tester.pump();
    expect(controller.events.last, 'resume');
    expect(controller.events, contains('pause'));
    await tester.pumpWidget(const SizedBox());
    debugDefaultTargetPlatformOverride = null;
  });
}
