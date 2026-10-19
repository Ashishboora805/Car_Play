import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as tabs;
import 'package:url_launcher/url_launcher.dart';

import 'browser_urls.dart';
import 'browser_platform.dart';

class BrowserExternal {
  Future<bool> external(Uri uri) =>
      launchUrl(uri, mode: LaunchMode.externalApplication);
  Future<void> chrome(Uri uri) async {
    if (!isWebAddress(uri)) {
      throw ArgumentError('Invalid URL');
    }
    if (Platform.isAndroid) {
      try {
        await AndroidIntent(
          action: 'action_view',
          data: uri.toString(),
          package: 'com.android.chrome',
        ).launch();
        return;
      } catch (_) {
        /* Fall back to installed default browser. */
      }
    } else if (Platform.isIOS) {
      final chrome = Uri.parse(
        '${uri.scheme == 'https' ? 'googlechromes' : 'googlechrome'}://${uri.toString().split('://').skip(1).join('://')}',
      );
      if (await canLaunchUrl(chrome) && await external(chrome)) {
        return;
      }
    }
    if (!await external(uri)) {
      throw StateError('No external browser');
    }
  }

  Future<void> customTab(Uri uri) async {
    if (!isWebAddress(uri)) {
      throw ArgumentError('Invalid URL');
    }
    await tabs.launchUrl(
      uri,
      customTabsOptions: const tabs.CustomTabsOptions(showTitle: true),
      safariVCOptions: const tabs.SafariViewControllerOptions(),
    );
  }

  Future<Uri?> appLink(Uri uri) async {
    if (uri.scheme == 'intent') {
      if (Platform.isAndroid) {
        try {
          if (await BrowserPlatform.channel.invokeMethod<bool>('openIntent', {
                'url': uri.toString(),
              }) ==
              true) {
            return null;
          }
        } catch (_) {
          /* Try declared web fallback below. */
        }
      }
      return intentFallback(uri.toString());
    }
    if ([
          'file',
          'content',
          'javascript',
          'data',
          'about',
          'chrome',
        ].contains(uri.scheme) ||
        uri.scheme.isEmpty) {
      throw StateError('Unsupported application link');
    }
    if (!await external(uri)) {
      throw StateError('No application for link');
    }
    return null;
  }
}
