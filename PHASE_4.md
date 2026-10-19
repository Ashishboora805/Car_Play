# CP Drive — Phase 4 complete source

The files below are already saved in the workspace. This handoff contains full current app sources and the native browser/download additions. Existing launcher assets and native scaffolding from earlier phases remain in their platform directories. The full vendored Android WebView dependency source is also supplied in PHASE_4_DEPENDENCY_SOURCE.md.

## Validation

flutter pub get succeeds, flutter analyze reports no issues, all 36 tests pass, and Android debug APK compilation succeeds. iOS and native browser interactions still require device verification. See README for the private-mode limitation, the stable dependency choices, the local Gradle compatibility patch and platform test steps.

## Folder tree

```text
pubspec.yaml
analysis_options.yaml
l10n.yaml
README.md
lib\app.dart
lib\core\api\api_client.dart
lib\core\api\api_config.dart
lib\core\api\auth_interceptor.dart
lib\core\router\app_router.dart
lib\core\router\route_observer.dart
lib\core\theme\app_theme.dart
lib\core\utils\refresh_controller.dart
lib\features\audio\mini_player_placeholder.dart
lib\features\auth\auth_controller.dart
lib\features\auth\login_screen.dart
lib\features\browser\browser_downloads.dart
lib\features\browser\browser_external.dart
lib\features\browser\browser_library_screen.dart
lib\features\browser\browser_models.dart
lib\features\browser\browser_platform.dart
lib\features\browser\browser_screen.dart
lib\features\browser\browser_session.dart
lib\features\browser\browser_store.dart
lib\features\browser\browser_tab_view.dart
lib\features\browser\browser_urls.dart
lib\features\gallery\gallery_controller.dart
lib\features\gallery\gallery_format.dart
lib\features\gallery\gallery_library.dart
lib\features\gallery\gallery_permission_screen.dart
lib\features\gallery\gallery_screen.dart
lib\features\gallery\gallery_video.dart
lib\features\gallery\gallery_viewer.dart
lib\features\match_details\match_details_screen.dart
lib\features\matches\home_screen.dart
lib\features\matches\match_card.dart
lib\features\matches\match_repository.dart
lib\features\matches\matches_screen.dart
lib\features\matches\models\match.dart
lib\features\settings\settings_controller.dart
lib\features\settings\settings_screen.dart
lib\l10n\app_localizations.dart
lib\l10n\app_localizations_en.dart
lib\l10n\app_localizations_hi.dart
lib\main.dart
lib\l10n\app_en.arb
lib\l10n\app_hi.arb
test\browser_test.dart
test\browser_widget_test.dart
android\app\build.gradle.kts
android\app\src\main\AndroidManifest.xml
android\app\src\main\kotlin\com\cricketerspitch\drive\MainActivity.kt
android\app\src\main\res\xml\browser_file_paths.xml
ios\Runner\Info.plist
ios\Podfile
third_party\flutter_inappwebview_android\PATCHES.md
third_party\flutter_inappwebview_android\android\build.gradle
```

## C:\Users\ADITYA\Desktop\CP DRIVE\pubspec.yaml

```yaml
name: drive
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: ^3.13.4

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  flutter_localizations:
    sdk: flutter
  flutter_riverpod: ^3.4.3
  go_router: ^18.1.0
  dio: ^5.11.1
  shared_preferences: ^2.5.6
  flutter_secure_storage: ^11.2.0
  sqflite: ^2.4.4+2
  intl: ^0.20.3
  photo_manager: ^3.12.0
  photo_manager_image_provider: ^2.2.0
  photo_view: ^0.15.0
  video_player: ^2.14.1
  chewie: ^1.17.2
  share_plus: ^13.3.1
  flutter_inappwebview: ^6.1.5
  android_intent_plus: ^6.1.0
  flutter_custom_tabs: ^2.6.0
  url_launcher: ^6.3.3
  permission_handler: 12.0.3
  path_provider: ^2.1.6
  path: ^1.9.1
  open_filex: ^5.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  image: ^4.12.0
  flutter_lints: ^6.0.0
  flutter_launcher_icons: ^0.14.4
  flutter_native_splash: ^2.4.8
  shared_preferences_platform_interface: ^2.4.2
  video_player_platform_interface: ^6.9.0
  sqflite_common_ffi: ^2.4.4

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  assets:
    - assets/images/logo.png
  generate: true
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/to/resolution-aware-images

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/to/asset-from-package

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/to/font-from-package

flutter_launcher_icons:
  android: true
  ios: true
  image_path: assets/images/logo.png
  min_sdk_android: 24
  remove_alpha_ios: true
flutter_native_splash:
  color: '#0B2C54'
  image: assets/images/logo.png
  android_12:
    color: '#0B2C54'
    image: assets/images/logo.png

dependency_overrides:
  flutter_inappwebview_android:
    path: third_party/flutter_inappwebview_android
```

## C:\Users\ADITYA\Desktop\CP DRIVE\analysis_options.yaml

```yaml
# This file configures the analyzer, which statically analyzes Dart code to
# check for errors, warnings, and lints.
#
# The issues identified by the analyzer are surfaced in the UI of Dart-enabled
# IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be
# invoked from the command line by running `flutter analyze`.

# The following line activates a set of recommended lints for Flutter apps,
# packages, and plugins designed to encourage good coding practices.
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - third_party/**
    - build/**
    - android/**
    - ios/**

linter:
  # The lint rules applied to this project can be customized in the
  # section below to disable rules from the `package:flutter_lints/flutter.yaml`
  # included above or to enable additional rules. A list of all available lints
  # and their documentation is published at https://dart.dev/lints.
  #
  # Instead of disabling a lint rule for the entire project in the
  # section below, it can also be suppressed for a single line of code
  # or a specific dart file by using the `// ignore: name_of_lint` and
  # `// ignore_for_file: name_of_lint` syntax on the line or in the file
  # producing the lint.
  rules:
    # avoid_print: false  # Uncomment to disable the `avoid_print` rule
    # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule

# Additional information about this file can be found at
# https://dart.dev/guides/language/analysis-options
```

## C:\Users\ADITYA\Desktop\CP DRIVE\l10n.yaml

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

## C:\Users\ADITYA\Desktop\CP DRIVE\README.md

```markdown
# CP Drive — Phase 4

Flutter 3.47.5 stable / Dart 3.13.4. Android and iPhone app foundation, match browsing, details, and persisted settings. The phone gallery and browser are implemented; later phases implement shared commentary and car audio.

## Run

From this directory run `flutter pub get`, `flutter gen-l10n`, `flutter analyze`, and `flutter test`.
Create a local `backend.json` containing CP_API_BASE_URL (your actual HTTPS API base URL), CP_LOGIN_ENDPOINT (relative login path), and CP_COMMENTARY_ENDPOINT (relative commentary path). Run `flutter run --dart-define-from-file=backend.json`. These values are configuration, not credentials. Login stays disabled until a valid HTTPS base URL and relative login path are set. Do not put tokens or passwords in this file.

Login sends JSON username/password and expects a nonempty `token` plus `user_id`, `id`, or `user.id`. Confirm this contract with your backend. Credentials are never logged. Session token and user id share one secure-storage record; authenticated 401/403 responses clear it and redirect to login. Stale responses from a previous session cannot sign out a newer session. Storage failures show a retry screen.

Score helpers accept optional `score`, `team1_score`, `team2_score`; the supplied contract does not define actual score fields. Confirm the score schema before Phase 2. Missing or malformed fields are tolerated.

## Platforms

Android uses Kotlin DSL, minSdk 24 and compile/target SDK 36. Install Android SDK 36 through Android Studio > Tools > SDK Manager > SDK Platforms > Android 16 > Apply. INTERNET allows backend HTTPS requests; it has no runtime prompt. Release signing still requires your own keystore before store publication.

iOS deployment target is 16.0, iPhone only. On a Mac: install Flutter and CocoaPods, run `flutter config --no-enable-swift-package-manager`, `flutter pub get`, then `cd ios` and `pod install`. Open Runner.xcworkspace in Xcode > Runner project > Runner target > Signing & Capabilities > select your Team. Check General > Minimum Deployments = iOS 16.0 and Supported Destinations = iPhone, then select a simulator and Run. Windows cannot validate the iOS build. Store Xcode-version requirements must be rechecked before submission.

Info.plist contains Flutter's generated identity/version, launch storyboard and main storyboard keys; supported orientations govern phone rotation; CADisableMinimumFrameDurationOnPhone supports high refresh rates; UIApplicationSupportsIndirectInputEvents supports indirect input. Splash generation adds status bar settings. No photo, microphone, background audio, or CarPlay permissions are requested in Phase 1. Phase 7 replaces the storyboard scene setup with a shared engine.

The included 512px CP monogram is a code-generated starter logo. Replace assets/images/logo.png with your approved brand logo and run `dart run flutter_launcher_icons` and `dart run flutter_native_splash:create`.

English and Hindi follow the phone locale; light/dark themes follow the system. Theme and language can be overridden in Settings. The phone has Matches, Gallery, Browser and Settings navigation; Gallery browses photos and videos; Browser supports browsing, tabs, bookmarks, history and downloads.

## Structure

lib/main.dart and app.dart start the app. core/api holds configuration, Dio and auth interception; core/router handles startup/login/session redirects; core/theme holds Material 3 themes; features/auth holds secure sessions and login; features/matches/models holds defensive parsing; l10n contains ARB translations and generated delegates. Directories for core/utils, car, match_details, gallery, browser, settings and audio are reserved for later phases.

## Phase 2 behavior

Match lists request the first 40 matches from championships/matches/ with limit and cache_buster parameters. Live, Upcoming and Results filter that response; My Matches makes a separate request with the securely stored user id. Lists accept raw arrays or results arrays. No pagination beyond the requested 40 is implemented in this phase.

Tap a match to fetch championships/matches/{id}/. Details show teams, optional scores, result, toss, format, tournament, round, venue and scheduled date/time. These values follow the server's time representation; the contract does not supply a timezone. Unknown fields show localized Not available labels.

Pull down to refresh lists/details. Lists default to 120 seconds, details to 60. Settings offer list intervals 30/60/120/300 and detail intervals 30/60/120 seconds. Timers stop in the background, while another bottom destination is selected, or when details cover the list. Resume and returning from details refresh immediately. Requests do not overlap and are canceled on disposal. A connection failure retains the latest successful in-memory data and displays a retry banner. HTTP and malformed-response errors show a generic retry message; these are not mislabeled as offline. There is no persistent offline match cache yet.

Settings use SharedPreferencesAsync, storing one JSON record at cpdrive.settings.v1. Theme, locale, intervals, speech rate, show-in-car and ordered enabled car tabs survive restart. At least one car tab remains selected. Writes complete before UI preferences change; failed writes show a message. Car/audio settings are preparation for Phases 5–7. The only voice option in Phase 2 is the system voice for the selected app language; installed voice discovery and selection arrive with the TTS engine in Phase 5. Listen live currently explains Phase 5 availability, and the mini-player is explicitly an informational placeholder.

No Android permissions or iOS Info.plist keys are added in Phase 2. No new runtime production packages are required. shared_preferences_platform_interface is a direct development dependency for the package's in-memory test backend.

Phase 2 checks cover persisted settings, malformed settings, car tab invariants, endpoint/query behavior, malformed responses, overlapping requests, retained data on connection failure, lifecycle refresh behavior, My Matches filtering and large-font phone layout. Backend integration and device Android/iOS builds require the configured backend and platform toolchains.

Shared preferences API reference: https://pub.dev/packages/shared_preferences

## Phase 3: phone gallery

Dependencies resolved for Flutter 3.47.5: photo_manager 3.12.0, photo_manager_image_provider 2.2.0, photo_view 0.15.0, video_player 2.14.1, chewie 1.17.2, share_plus 13.3.1. pubspec.lock records exact resolutions. No gallery or video content is exposed in car screens.

Open Gallery, read the access explanation and tap Allow access. Permission requests are initiated by that gesture. Full and limited access both work. With limited access, tap Select more photos and videos to reopen the platform selection UI. After denial, Open Settings opens app settings; Retry can request access again if the OS permits it. Returning from Settings rechecks permission. Revoking access clears the displayed asset list; stale page results cannot restore it.

Albums include All, a virtual Videos collection, Favorites, and the device's actual Camera/Recents, Screenshots and other collections when present. Photos/Videos chips query the native media type. Selecting a type chip from the virtual Videos collection returns to All. Favorites uses the platform isFavorite flag and scans batches of 80; sparse favorites may require Load more. Android favorite flags are available starting with Android 11; older Android devices may show no favorites. Proprietary OEM favorite flags may not be available through MediaStore. Smart albums on iOS come from PhotoKit. The info sheet's Album field describes the current browsing collection; an item can belong to several real albums.

Items are newest first. Thumbnails use the image-provider cache and native thumbnail generation. Scrolling loads another 80 items; Load more also supports empty favorite pages and small libraries. The viewer uses PageView with pinch/double-tap photo zoom and Chewie video controls for play/pause, seek, volume and fullscreen. Videos start paused, pause when swiped away or the app leaves the foreground, and dispose their player on exit. Cloud-only media displays loading; failures display a friendly unavailable message. Share opens the system sheet with a local media file. Delete asks for app confirmation followed by native confirmation where the OS requires it; canceling leaves the media in place. Successful deletion returns to a refreshed grid. Info shows available creation date, size, dimensions, duration and browsing album.

Library-change notifications are debounced for 400 ms and refresh the grid. If a change or permission recheck occurs while the viewer is open, it returns to the refreshed grid so removed or inaccessible cached pages are not left onscreen. Gallery media never goes to the CP backend. A recipient selected in the system share sheet can receive the chosen file.

### Permission entries

AndroidManifest.xml adds READ_MEDIA_IMAGES and READ_MEDIA_VIDEO for photo/video library access on API 33+, READ_MEDIA_VISUAL_USER_SELECTED for partial selection on API 34+, READ_EXTERNAL_STORAGE capped at API 32 for older devices, and WRITE_EXTERNAL_STORAGE capped at API 28 for deletion on pre-scoped-storage Android. There is no all-files or media-location permission. Modern Android uses the platform deletion consent API. The plugin requests only common photo/video access, with mediaLocation false.

Info.plist adds NSPhotoLibraryUsageDescription to explain library browsing/sharing/deletion; NSPhotoLibraryAddUsageDescription reserves the requested add-only purpose string (this phase does not request a separate add-only authorization or implement saving new media); and PHPhotoLibraryPreventAutomaticLimitedAccessAlert=true because the app provides an explicit selection-management button. The plugin's read/write PhotoKit access level supports library management and native deletion confirmation. No camera or microphone usage keys are added.

### Google Play photo and video declaration

1. Play Console > select CP Drive > Policy and programs > App content > Photo and video permissions > Start or Manage. The declaration becomes available for the uploaded bundle that requests these permissions.
2. Declare both READ_MEDIA_IMAGES and READ_MEDIA_VIDEO. Describe the actual frequent gallery-management use: browsing albums, swipe viewing photos/videos, metadata inspection, sharing chosen files and deleting items. Explain why a one-time picker cannot provide persistent album browsing and management of the library.
3. Provide a review video showing the Gallery destination, permission request, album selection, photo/video filters, viewing, sharing and deletion confirmation. Include limited-access and denied-access recovery. Use non-sensitive test media.
4. Ensure the store listing prominently describes this gallery feature. Complete Data safety and link a privacy policy describing on-device access and user-directed sharing. Do not claim that broad permission is automatically approved merely because Gallery is a tab; Google decides whether the app's demonstrated core functionality qualifies. If it does not qualify, redesign access around a system picker before release.
5. Save and submit the declaration alongside the release for review.

Official policy: https://support.google.com/googleplay/android-developer/answer/14115180
Plugin limited-access documentation: https://pub.dev/packages/photo_manager

### Device verification

Android: Android Studio > Tools > SDK Manager > SDK Platforms > Android 16 (API 36) > Apply; accept the SDK license yourself when prompted. From the project directory, run flutter doctor --android-licenses to review any remaining licenses, then flutter build apk --debug. Use a device or emulator with sample photos/videos. Test API 28 deletion, API 32 legacy permissions, API 33 separate photo/video grants, and API 34+ selected-media access. Revoke permission in Settings while a viewer is open and return to the app. Add/delete media from the system gallery to verify changes refresh.

iOS: on a Mac, run flutter pub get and pod install in ios, open Runner.xcworkspace, select an iOS 16+ iPhone simulator or device and Run. Add sample photos/videos in Photos. Test Allow Full Access, Select Photos, Don't Allow, explicit reselection, Settings recovery, share cancellation and delete cancellation. Actual PhotoKit, system sheets and codecs require device/simulator checks; Flutter unit/widget tests use fake platform services.

### Phase 3 verification results

flutter pub get completed, flutter analyze reports no issues, and all 22 unit/widget tests pass. flutter build apk --debug succeeded on this Windows machine; the installable development APK is build/app/outputs/flutter-apk/app-debug.apk. This is not a signed production release. The photo_manager plugin produces a Flutter warning about its legacy Kotlin Gradle plugin usage and a future Flutter migration; the pinned current toolchain builds successfully. Recheck plugin support before upgrading Flutter/AGP.

No connected Android device is available, so actual permission dialogs, platform gallery behavior, sharing/deletion consent and device codecs have not been exercised here. iOS compilation and device verification have not run on this Windows machine. flutter doctor reports some SDK licenses are unaccepted even though this particular Android debug build succeeds; review remaining licenses before installing additional SDK components.

Tests specifically exercise mixed paging, sparse favorites across pages, filter reset, usable limited access, clearing assets after revocation, rejecting stale asynchronous pages, retry after errors, long video durations, denied UI with large text, user-initiated permission prompts, gallery change notifications pausing/disposal of video players, and safe navigation when the viewer returns to the refreshed gallery. Test video_player_platform_interface is a development-only dependency.

## Phase 4: phone browser

### Features and dependency choices

The Browser destination initializes only when opened. The address bar accepts HTTP/HTTPS URLs, host names or Google search text. Navigation controls provide back, forward, reload/stop, loading progress, HTTPS indication and an explicit Not secure label on HTTP pages. Server certificate challenges are always canceled; a Flutter warning page covers failed content and offers retry without a bypass. Network and HTTP failures show a retry page.

The tab switcher shows titles and regular-page snapshots, supports selecting or closing a tab, new regular/private tabs and close all. Up to 24 tabs are allowed. Native views are created lazily. Within one browsing mode, visited tabs retain native back/forward navigation; after restart or a mode boundary they reload their last URL. Regular URLs, titles, ordering, selection, desktop preference, text zoom and snapshots are persisted. Private tabs are not restored and never write URL/title/snapshot/history rows. Bookmarks can be added, edited or removed. History is searchable using literal substring matching and grouped by local day, with a clear-all confirmation. Downloads list saved files with open, share and delete; active transfers can be canceled.

Production packages: flutter_inappwebview 6.1.5, android_intent_plus 6.1.0, flutter_custom_tabs 2.6.0, url_launcher 6.3.3, permission_handler 12.0.3, open_filex 5.0.0, path_provider 2.1.6, path 1.9.1, plus previously added sqflite, Dio and share_plus. permission_handler is deliberately pinned to 12.0.3 because the newer 13.0.2 pulls an Android implementation requiring compile SDK 37; this app retains the requested compile/target SDK 36.

The stable Android WebView package references a ProGuard file removed by AGP 9.1. A reproducible path override points to third_party/flutter_inappwebview_android, copied from upstream 1.1.3 with its license. The only patch replaces proguard-android.txt with proguard-android-optimize.txt in the Android Gradle file. See third_party/flutter_inappwebview_android/PATCHES.md. This is not a shared pub-cache edit. Upstream Dart/native browser behavior is unchanged. Remove the override only after a compatible upstream stable release is verified.

### Privacy and web permissions

SQLite cpdrive_browser.db lives in Application Support, outside the Documents folder exported to Files on iOS. It stores regular tabs, bookmarks, history and download records. Browser network requests use a separate Dio client and never receive the CP API token interceptor. SQL parameters are bound; private navigation is rejected by history storage itself.

On Android, the stable WebView plugin shares process-wide cookies/storage. Regular and private modes therefore never keep live WebViews together. Switching modes disposes views and clears cookies, web storage and cache before creating the next mode; this resets regular website sign-ins as stated in the app's private-mode explanation. A non-sensitive privateDirty marker causes cleanup before any browser view is restored after an interrupted private session. Closing the last private tab returns to a regular tab and clears the private data. iOS uses WKWebView's nonpersistent incognito store. Creating a private Android WebView may also reset cookies used by another private tab because of the plugin's own initialization. Incognito is not presented as an isolated normal-cookie-preserving Android profile.

Saved bookmarks and downloads remain when explicitly chosen in private mode; download records omit the private source URL. Downloads contain only the selected file and ordinary saved-file metadata. Private tabs have no saved screenshots. External browsers and Custom Tabs use their own browser profile and are separate from the in-app private session.

Website camera/microphone requests are allowed only for the selected active tab, HTTPS, the same current origin, and known camera/microphone resources. The app first asks with the requesting host and resource names, then obtains the OS runtime permission, and rechecks that the tab/origin is still current. Unknown resources and geolocation are denied. File-upload inputs use the plugin's native system chooser, including supported OS capture flows. Automated pop-ups are blocked; user-gesture new-window links open a new tab in the originating mode. Unselected/hidden tabs pause media. HTTP(S) app links can be sent through the external-browser menu. mailto, tel, sms, custom app schemes and intent links require an explicit external-app confirmation. Android intent URIs are parsed natively with VIEW/BROWSABLE restrictions, and a safe HTTP(S) browser_fallback_url is used when an app cannot open.

Find in page uses FindInteractionController. Desktop mode uses the platform's preferred content mode. Text zoom persists per tab (Android WebView textZoom, iOS document text-size adjustment). Share page uses the system share sheet. Open in Chrome targets com.android.chrome on Android, then falls back to the default browser. iOS tries googlechrome/googlechromes schemes and falls back to an external browser. Open in Safari follows the requested url_launcher external-application approach; the OS's configured default browser may handle the HTTP URL. Custom Tabs uses flutter_custom_tabs (Safari view controller on iOS).

### Downloads and platform entries

HTTP(S) downloads stream to a temporary app-cache file. Cookie headers are scoped to the original origin and permanently stripped after crossing origins; HTTPS-to-HTTP redirects are rejected. Filenames are sanitized. On Android API 29+, a Kotlin MethodChannel copies the temporary file into MediaStore Downloads/CP Drive, uses IS_PENDING until complete, and deletes partial entries on failure. No storage permission is needed for that path. Older Android saves in app-specific external Downloads. Native content URIs are opened/shared with a temporary read grant; only the app's legacy download directory is exposed through the non-exported FileProvider. Saving and deletion run on a dedicated file thread.

On iOS, files are saved to Documents/BrowserDownloads and are visible in Files through UIFileSharingEnabled and LSSupportsOpeningDocumentsInPlace. Downloads are foreground app operations, not resumable background transfers. Process termination marks unfinished records failed on next open. HTTP transfers are streamed; data/blob downloads use a bounded 25 MiB in-memory conversion, with errors directing users to the external-browser option. Some DRM, streaming or site-specific authenticated download flows require the external browser. Actual file availability and compatible viewer apps affect Open.

Android additions: CAMERA and RECORD_AUDIO support approved website/capture requests; POST_NOTIFICATIONS is requested when the user confirms a download so completion can be announced. A denied notification grant does not prevent file saving. Camera and microphone hardware features are optional. INTERNET was already present; usesCleartextTraffic=true allows HTTP browsing. Package visibility includes Chrome and common external-link handlers. The browser_files FileProvider is non-exported and grants access only to the app-specific legacy download folder. The existing WRITE_EXTERNAL_STORAGE permission remains capped at API 28 for gallery deletion, not modern browser downloads.

iOS additions: NSCameraUsageDescription and NSMicrophoneUsageDescription explain approved website capture; NSAppTransportSecurity/NSAllowsArbitraryLoadsInWebContent permits HTTP only in web content; UIFileSharingEnabled and LSSupportsOpeningDocumentsInPlace expose user downloads; LSApplicationQueriesSchemes includes googlechrome, googlechromes, mailto, tel and sms. Podfile enables the camera, microphone and notification permission-handler compilation macros. No location permission or arbitrary-load exception is added to the CP API client.

### Device checks for Phase 4

Android: run flutter pub get, flutter analyze, flutter test and flutter build apk --debug. Install build/app/outputs/flutter-apk/app-debug.apk on a device/emulator and configure the backend for phone login. Test URL/search input, redirects, back/forward, pushState navigation, SSL-error rejection, pop-ups, file upload, camera/microphone allow/deny, HTTP pages, app links and intent fallbacks. Test Chrome installed/uninstalled and default-browser fallback. Test API 28 app-specific files, API 29+ public Downloads, API 33+ notification deny/allow, download cancellation, opening, sharing, and deletion after a file is removed externally. For private mode, switch modes, close all private tabs, force-stop while private tabs are open and relaunch; check that no private tab/history/thumbnail is restored and website cookies are cleared.

iOS on a Mac: flutter pub get > cd ios > pod install > open Runner.xcworkspace. In Xcode select Runner > Signing & Capabilities > your Team, choose an iPhone simulator/device and Run. In iOS Settings > CP Drive test camera/microphone grants; test native upload selection and partial gallery permissions remain intact. Download a PDF/image/video, open Files > Browse > On My iPhone > CP Drive > BrowserDownloads and verify open/share/delete. Test Chrome installed/not installed, external browser, desktop and zoom settings, SSL rejection and private navigation.

Phase 4 automated tests cover URL classification, intent fallback validation, filename sanitization, SQLite persistence and write ordering, private-mode exclusion/recovery, bookmark editing, literal history search, redirect cookie scoping, interrupted downloads, unsafe redirect rejection, lazy browser initialization and large-font tab UI. Native WebView rendering, website compatibility, OS permission dialogs, file chooser/capture, Custom Tabs and iOS compilation still require device checks.

References: https://inappwebview.dev/docs/webview/in-app-webview/ and https://developer.android.com/reference/android/provider/MediaStore.Downloads

### Phase 4 verification results

flutter pub get succeeds; flutter analyze reports no issues; all 36 unit/widget tests pass; Android debug APK compilation succeeds with compileSdk/targetSdk 36 and minSdk 24. The debug APK is build/app/outputs/flutter-apk/app-debug.apk. iOS has not been compiled on this Windows host, and no Android device is connected for native browser/permission/download interaction checks. The local WebView compatibility patch and permission package pin are included in the project.
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\app.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'features/settings/settings_controller.dart';

class CPDriveApp extends ConsumerWidget {
  const CPDriveApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(routerProvider);
    return ListenableBuilder(
      listenable: settings,
      builder: (context, child) => MaterialApp.router(
        themeMode: settings.theme,
        locale: settings.language == 'system'
            ? null
            : Locale(settings.language),
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        theme: AppTheme.build(Brightness.light),
        darkTheme: AppTheme.build(Brightness.dark),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\api\api_client.dart

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/auth_controller.dart';
import 'auth_interceptor.dart';
import 'api_config.dart';

final authProvider = Provider<AuthController>((ref) {
  final auth = AuthController(const FlutterSecureStorage());
  ref.onDispose(auth.dispose);
  return auth;
});
final apiProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );
  dio.interceptors.add(AuthInterceptor(ref.watch(authProvider)));
  ref.onDispose(() => dio.close(force: true));
  return dio;
});
final loginProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(ref.watch(apiProvider), ref.watch(authProvider)),
);

class LoginRepository {
  LoginRepository(this.dio, this.auth);
  final Dio dio;
  final AuthController auth;
  Future<void> login(String username, String password) async {
    if (!ApiConfig.configured) {
      throw StateError('Backend configuration missing');
    }
    final response = await dio.post<Object?>(
      ApiConfig.endpoint(ApiConfig.loginEndpoint),
      data: {'username': username, 'password': password},
      options: Options(extra: {'public': true}),
    );
    final data = response.data;
    if (data is! Map) {
      throw const FormatException('Invalid login response');
    }
    final token = data['token'];
    final user = data['user'];
    final id =
        data['user_id'] ?? data['id'] ?? (user is Map ? user['id'] : user);
    if (token is! String ||
        token.trim().isEmpty ||
        (id is! String && id is! int) ||
        id.toString().isEmpty) {
      throw const FormatException('Login requires token and user id');
    }
    await auth.save(token, id.toString());
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\api\api_config.dart

```dart
class ApiConfig {
  static const baseUrl = String.fromEnvironment('CP_API_BASE_URL');
  static const loginEndpoint = String.fromEnvironment('CP_LOGIN_ENDPOINT');
  static const commentaryEndpoint = String.fromEnvironment(
    'CP_COMMENTARY_ENDPOINT',
  );
  static bool get configured {
    final uri = Uri.tryParse(baseUrl);
    return uri != null &&
        uri.scheme == 'https' &&
        uri.host.isNotEmpty &&
        loginEndpoint.isNotEmpty &&
        !loginEndpoint.contains('://') &&
        !loginEndpoint.startsWith('//');
  }

  static String endpoint(String path) =>
      '${baseUrl.replaceAll(RegExp(r'/+$'), '')}/${path.replaceFirst(RegExp(r'^/+'), '')}';
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\api\auth_interceptor.dart

```dart
import 'package:dio/dio.dart';

import '../../features/auth/auth_controller.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.auth);
  final AuthController auth;
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['authGeneration'] = auth.generation;
    if (options.extra['public'] != true && auth.token != null) {
      options.headers['Authorization'] = 'Token ${auth.token}';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if ((err.response?.statusCode == 401 || err.response?.statusCode == 403) &&
        err.requestOptions.extra['public'] != true &&
        err.requestOptions.extra['authGeneration'] == auth.generation) {
      await auth.signOut();
    }
    handler.next(err);
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\router\app_router.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../api/api_client.dart';
import 'route_observer.dart';
import '../../features/auth/login_screen.dart';
import '../../features/matches/home_screen.dart';
import '../../features/match_details/match_details_screen.dart';
import '../../l10n/app_localizations.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  final router = GoRouter(
    initialLocation: '/startup',
    observers: [routeObserver],
    refreshListenable: auth,
    redirect: (context, state) {
      final path = state.uri.path;
      if (!auth.ready || auth.storageFailed) {
        return path == '/startup' ? null : '/startup';
      }
      if (!auth.signedIn) {
        return path == '/login' ? null : '/login';
      }
      return path == '/login' || path == '/startup' ? '/' : null;
    },
    routes: [
      GoRoute(
        path: '/startup',
        builder: (context, state) => const StartupScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/matches/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          return id == null ? const HomeScreen() : MatchDetailsScreen(id: id);
        },
      ),
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

class StartupScreen extends ConsumerStatefulWidget {
  const StartupScreen({super.key});
  @override
  ConsumerState<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends ConsumerState<StartupScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(authProvider).restore());
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final text = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: auth,
      builder: (context, child) => Scaffold(
        body: SafeArea(
          child: Center(
            child: auth.storageFailed
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(text.sessionError),
                      FilledButton(
                        onPressed: auth.restore,
                        child: Text(text.retry),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\router\route_observer.dart

```dart
import 'package:flutter/widgets.dart';

final routeObserver = RouteObserver<ModalRoute<void>>();
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\theme\app_theme.dart

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData build(Brightness brightness) => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0B2C54),
      brightness: brightness,
      secondary: const Color(0xFFFF8B2D),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(minimumSize: const Size(48, 52)),
    ),
  );
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\utils\refresh_controller.dart

```dart
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class RefreshController<T> extends ChangeNotifier with WidgetsBindingObserver {
  RefreshController({required this.fetch, required this.seconds}) {
    WidgetsBinding.instance.addObserver(this);
  }
  final Future<T> Function(CancelToken token) fetch;
  int seconds;
  T? data;
  Object? error;
  bool loading = false;
  bool active = false;
  bool _disposed = false;
  Timer? _timer;
  CancelToken? _token;
  bool get offline =>
      error is DioException &&
      [
        DioExceptionType.connectionError,
        DioExceptionType.connectionTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.sendTimeout,
      ].contains((error as DioException).type);
  void configure({required int interval, required bool enabled}) {
    final changed = seconds != interval || active != enabled;
    seconds = interval;
    active = enabled;
    if (changed) {
      _schedule();
    }
  }

  void _schedule() {
    _timer?.cancel();
    final state = WidgetsBinding.instance.lifecycleState;
    if (active && (state == null || state == AppLifecycleState.resumed)) {
      _timer = Timer.periodic(Duration(seconds: seconds), (_) => refresh());
    }
  }

  Future<void> refresh() async {
    if (_disposed || loading) {
      return;
    }
    loading = true;
    error = null;
    notifyListeners();
    final token = CancelToken();
    _token = token;
    try {
      final result = await fetch(token);
      if (!_disposed) {
        data = result;
      }
    } catch (failure) {
      if (!_disposed &&
          !(failure is DioException && CancelToken.isCancel(failure))) {
        error = failure;
      }
    } finally {
      if (!_disposed) {
        loading = false;
        notifyListeners();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _schedule();
    if (state == AppLifecycleState.resumed && active) {
      refresh();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _token?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\mini_player_placeholder.dart

```dart
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class MiniPlayerPlaceholder extends StatelessWidget {
  const MiniPlayerPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: ListTile(
        leading: const Icon(Icons.headphones),
        title: Text(text.miniPlayer),
        subtitle: Text(text.audioPhase),
      ),
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\auth\auth_controller.dart

```dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController extends ChangeNotifier {
  AuthController(this.storage);
  final FlutterSecureStorage storage;
  String? token;
  String? userId;
  bool ready = false;
  bool storageFailed = false;
  int generation = 0;
  bool get signedIn => token != null && userId != null;
  Future<void> restore() async {
    storageFailed = false;
    try {
      final raw = await storage.read(key: 'session');
      if (raw != null) {
        final value = jsonDecode(raw);
        if (value is Map &&
            value['token'] is String &&
            value['userId'] is String &&
            (value['token'] as String).isNotEmpty &&
            (value['userId'] as String).isNotEmpty) {
          token = value['token'] as String;
          userId = value['userId'] as String;
        } else {
          await storage.delete(key: 'session');
        }
      }
    } catch (_) {
      storageFailed = true;
    }
    ready = true;
    notifyListeners();
  }

  Future<void> save(String newToken, String id) async {
    await storage.write(
      key: 'session',
      value: jsonEncode({'token': newToken, 'userId': id}),
    );
    generation++;
    token = newToken;
    userId = id;
    notifyListeners();
  }

  Future<void> signOut() async {
    generation++;
    token = null;
    userId = null;
    notifyListeners();
    try {
      await storage.delete(key: 'session');
    } catch (_) {
      storageFailed = true;
      notifyListeners();
    }
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\auth\login_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_config.dart';
import '../../l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final form = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  bool hidden = true;
  bool loading = false;
  bool failed = false;
  Future<void> submit() async {
    if (loading || !form.currentState!.validate()) {
      return;
    }
    setState(() {
      loading = true;
      failed = false;
    });
    try {
      await ref.read(loginProvider).login(username.text.trim(), password.text);
    } catch (_) {
      if (mounted) {
        setState(() => failed = true);
      }
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: AutofillGroup(
                child: Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.sports_cricket, size: 72),
                      const SizedBox(height: 24),
                      Text(
                        text.appTitle,
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(text.welcome, textAlign: TextAlign.center),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: username,
                        enabled: !loading,
                        autofillHints: const [AutofillHints.username],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: text.username),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? text.requiredField
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: password,
                        enabled: !loading,
                        obscureText: hidden,
                        autofillHints: const [AutofillHints.password],
                        enableSuggestions: false,
                        autocorrect: false,
                        onFieldSubmitted: (_) => submit(),
                        decoration: InputDecoration(
                          labelText: text.password,
                          suffixIcon: IconButton(
                            tooltip: hidden
                                ? text.showPassword
                                : text.hidePassword,
                            onPressed: () => setState(() => hidden = !hidden),
                            icon: Icon(
                              hidden ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? text.requiredField
                            : null,
                      ),
                      if (!ApiConfig.configured)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(text.configurationError),
                        ),
                      if (failed)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Semantics(
                            liveRegion: true,
                            child: Text(
                              text.loginError,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: loading || !ApiConfig.configured
                            ? null
                            : submit,
                        child: loading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(text.signIn),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_downloads.dart

```dart
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'browser_models.dart';
import 'browser_platform.dart';
import 'browser_store.dart';
import 'browser_urls.dart';

class BrowserDownloads extends ChangeNotifier {
  BrowserDownloads(
    this.store,
    this.platform, {
    Dio? client,
    Future<Directory> Function()? temporaryDirectory,
  }) : temporaryDirectory = temporaryDirectory ?? getTemporaryDirectory,
       client =
           client ??
           Dio(
             BaseOptions(
               connectTimeout: const Duration(seconds: 20),
               receiveTimeout: const Duration(seconds: 60),
             ),
           );
  final Future<Directory> Function() temporaryDirectory;
  final BrowserStore store;
  final BrowserPlatform platform;
  // Browser traffic never uses the CP API authentication interceptor.
  final Dio client;
  List<BrowserDownload> items = [];
  final Map<String, CancelToken> _tokens = {};
  bool _disposed = false;
  Future<void> initialize() async {
    items = await store.downloads();
    for (final item in items.where((d) => d.status == 'downloading')) {
      item.status = 'failed';
      await store.saveDownload(item);
    }
    if (!_disposed) {
      notifyListeners();
    }
  }

  Future<BrowserDownload> download({
    required Uri url,
    required String name,
    required String mime,
    required String completeTitle,
    bool private = false,
    String? cookie,
    String? userAgent,
    List<int>? bytes,
  }) async {
    if (bytes == null && !isWebAddress(url)) {
      throw ArgumentError('Unsupported download scheme');
    }
    final record = BrowserDownload(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: safeDownloadName(name),
      created: DateTime.now().millisecondsSinceEpoch,
      url: private ? '' : url.toString(),
      mime: mime,
    );
    items.insert(0, record);
    await store.saveDownload(record);
    if (!_disposed) {
      notifyListeners();
    }
    final token = CancelToken();
    _tokens[record.id] = token;
    File? temporary;
    IOSink? sink;
    try {
      temporary = File(
        path.join(
          (await temporaryDirectory()).path,
          'cpdrive_download_${record.id}',
        ),
      );
      if (bytes != null) {
        await temporary.writeAsBytes(bytes);
        record.bytes = bytes.length;
      } else {
        var current = url;
        Response<ResponseBody>? response;
        var crossedOrigin = false;
        for (var redirects = 0; redirects <= 5; redirects++) {
          response = await client.get<ResponseBody>(
            current.toString(),
            cancelToken: token,
            options: Options(
              responseType: ResponseType.stream,
              followRedirects: false,
              validateStatus: (s) => s != null && s >= 200 && s < 400,
              headers: {
                if (cookie != null &&
                    !crossedOrigin &&
                    current.origin == url.origin)
                  'Cookie': cookie,
                'User-Agent': ?userAgent,
              },
            ),
          );
          if (response.statusCode! < 300) {
            break;
          }
          final location = response.headers.value('location');
          await response.data?.stream.drain<void>();
          if (location == null || redirects == 5) {
            throw StateError('Invalid redirect');
          }
          final next = current.resolve(location);
          if (!isWebAddress(next) ||
              current.scheme == 'https' && next.scheme != 'https') {
            throw StateError('Unsafe redirect');
          }
          crossedOrigin = crossedOrigin || next.origin != url.origin;
          current = next;
          response = null;
        }
        if (response?.data == null) {
          throw StateError('Empty download response');
        }
        record.mime =
            response!.headers.value('content-type')?.split(';').first ?? mime;
        record.total = int.tryParse(
          response.headers.value('content-length') ?? '',
        );
        sink = temporary.openWrite();
        var last = DateTime.now();
        await for (final chunk in response.data!.stream) {
          if (token.isCancelled) {
            throw StateError('Download canceled');
          }
          sink.add(chunk);
          record.bytes += chunk.length;
          if (DateTime.now().difference(last).inMilliseconds > 200) {
            last = DateTime.now();
            if (!_disposed) {
              notifyListeners();
            }
          }
        }
        await sink.flush();
        await sink.close();
        sink = null;
      }
      if (token.isCancelled) {
        throw StateError('Download canceled');
      }
      final saved = await platform.publish(
        temporary.path,
        record.name,
        record.mime,
        completeTitle,
      );
      record.location = saved['location']!;
      record.name = saved['name']!;
      record.mime = saved['mime']!;
      record.status = 'complete';
    } catch (_) {
      record.status = 'failed';
    } finally {
      await sink?.close();
      if (temporary != null && await temporary.exists()) {
        await temporary.delete();
      }
      _tokens.remove(record.id);
      await store.saveDownload(record);
      if (!_disposed) {
        notifyListeners();
      }
    }
    return record;
  }

  Future<void> remove(BrowserDownload record) async {
    if (record.status == 'downloading') {
      _tokens[record.id]?.cancel();
      return;
    }
    if (record.location.isNotEmpty) {
      await platform.delete(record.location);
    }
    await store.removeDownload(record.id);
    items.remove(record);
    if (!_disposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    for (final token in _tokens.values) {
      token.cancel();
    }
    client.close(force: true);
    super.dispose();
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_external.dart

```dart
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_library_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import 'browser_downloads.dart';
import 'browser_models.dart';
import 'browser_store.dart';
import 'browser_urls.dart';

enum BrowserLibrarySection { bookmarks, history, downloads }

Future<bool> browserConfirm(
  BuildContext context,
  String title, {
  String? detail,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) {
        final text = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(title),
          content: detail == null ? null : Text(detail),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(text.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(text.allow),
            ),
          ],
        );
      },
    ) ??
    false;
Future<void> editBookmark(
  BuildContext context,
  BrowserStore store,
  BrowserEntry entry,
) async {
  final title = TextEditingController(text: entry.title);
  final url = TextEditingController(text: entry.url);
  final form = GlobalKey<FormState>();
  final text = AppLocalizations.of(context)!;
  final result = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text.addBookmark),
      content: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: title,
                decoration: InputDecoration(labelText: text.title),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: url,
                decoration: InputDecoration(labelText: text.url),
                validator: (value) =>
                    isWebAddress(Uri.tryParse(value ?? '') ?? Uri())
                    ? null
                    : text.invalidUrl,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'delete'),
          child: Text(text.delete),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(text.cancel),
        ),
        FilledButton(
          onPressed: () {
            if (form.currentState!.validate()) {
              Navigator.pop(context, 'save');
            }
          },
          child: Text(text.save),
        ),
      ],
    ),
  );
  try {
    if (result == 'save') {
      await store.bookmark(
        url.text.trim(),
        title.text.trim(),
        previousUrl: entry.url,
      );
    } else if (result == 'delete') {
      await store.removeBookmark(entry.url);
    }
  } finally {
    title.dispose();
    url.dispose();
  }
}

class BrowserLibraryScreen extends StatefulWidget {
  const BrowserLibraryScreen({
    super.key,
    required this.section,
    required this.store,
    required this.downloads,
  });
  final BrowserLibrarySection section;
  final BrowserStore store;
  final BrowserDownloads downloads;
  @override
  State<BrowserLibraryScreen> createState() => _BrowserLibraryScreenState();
}

class _BrowserLibraryScreenState extends State<BrowserLibraryScreen> {
  String search = '';
  late Future<List<BrowserEntry>> entries;
  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    entries = widget.section == BrowserLibrarySection.bookmarks
        ? widget.store.bookmarks()
        : widget.store.history(search);
  }

  Future<void> run(Future<void> Function() operation) async {
    try {
      await operation();
      if (mounted) {
        setState(reload);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.actionFailed)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final section = widget.section;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          [text.bookmarks, text.history, text.downloads][section.index],
        ),
        actions: [
          if (section == BrowserLibrarySection.history)
            IconButton(
              tooltip: text.clearHistory,
              icon: const Icon(Icons.delete_sweep),
              onPressed: () => run(() async {
                if (await browserConfirm(context, text.clearConfirm)) {
                  await widget.store.clearHistory();
                }
              }),
            ),
        ],
      ),
      body: SafeArea(
        child: section == BrowserLibrarySection.downloads
            ? ListenableBuilder(
                listenable: widget.downloads,
                builder: (context, child) {
                  final data = widget.downloads.items;
                  if (data.isEmpty) {
                    return Center(child: Text(text.noDownloads));
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                item.status == 'complete'
                                    ? text.downloadComplete
                                    : item.status == 'failed'
                                    ? text.downloadFailed
                                    : text.downloading,
                              ),
                              Text(
                                '${(item.bytes / 1048576).toStringAsFixed(2)} MB',
                              ),
                              if (item.status == 'downloading')
                                LinearProgressIndicator(
                                  value: item.total == null || item.total == 0
                                      ? null
                                      : (item.bytes / item.total!).clamp(0, 1),
                                ),
                              Wrap(
                                children: [
                                  if (item.status == 'complete')
                                    TextButton(
                                      onPressed: () => run(
                                        () => widget.downloads.platform.open(
                                          item.location,
                                          item.mime,
                                        ),
                                      ),
                                      child: Text(text.open),
                                    ),
                                  if (item.status == 'complete')
                                    TextButton(
                                      onPressed: () => run(
                                        () => widget.downloads.platform.share(
                                          item.location,
                                          item.mime,
                                        ),
                                      ),
                                      child: Text(text.share),
                                    ),
                                  TextButton(
                                    onPressed: () => run(() async {
                                      if (item.status == 'downloading' ||
                                          await browserConfirm(
                                            context,
                                            text.deleteDownload,
                                            detail: text.downloadHint,
                                          )) {
                                        await widget.downloads.remove(item);
                                      }
                                    }),
                                    child: Text(
                                      item.status == 'downloading'
                                          ? text.stop
                                          : text.delete,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : Column(
                children: [
                  if (section == BrowserLibrarySection.history)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: text.searchHistory,
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: (value) => setState(() {
                          search = value;
                          reload();
                        }),
                      ),
                    ),
                  Expanded(
                    child: FutureBuilder<List<BrowserEntry>>(
                      future: entries,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: TextButton(
                              onPressed: () => setState(reload),
                              child: Text(text.retry),
                            ),
                          );
                        }
                        final data = snapshot.data;
                        if (data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (data.isEmpty) {
                          return Center(
                            child: Text(
                              section == BrowserLibrarySection.bookmarks
                                  ? text.noBookmarks
                                  : text.noHistory,
                            ),
                          );
                        }
                        String? previousDay;
                        return ListView(
                          children: [
                            for (final entry in data) ...[
                              if (section == BrowserLibrarySection.history &&
                                  previousDay !=
                                      DateFormat.yMMMd(
                                        Localizations.localeOf(context)
                                            .toLanguageTag(),
                                      ).format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          entry.time,
                                        ),
                                      ))
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    previousDay =
                                        DateFormat.yMMMd(
                                          Localizations.localeOf(context)
                                              .toLanguageTag(),
                                        ).format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            entry.time,
                                          ),
                                        ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                ),
                              ListTile(
                                title: Text(
                                  entry.title.isEmpty ? entry.url : entry.title,
                                ),
                                subtitle: Text(
                                  entry.url,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () => Navigator.pop(context, entry.url),
                                trailing:
                                    section == BrowserLibrarySection.bookmarks
                                    ? PopupMenuButton<String>(
                                        onSelected: (value) => run(
                                          () => value == 'edit'
                                              ? editBookmark(
                                                  context,
                                                  widget.store,
                                                  entry,
                                                )
                                              : widget.store.removeBookmark(
                                                  entry.url,
                                                ),
                                        ),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Text(text.edit),
                                          ),
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: Text(text.delete),
                                          ),
                                        ],
                                      )
                                    : null,
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_models.dart

```dart
import 'dart:typed_data';

class BrowserTab {
  BrowserTab({
    required this.id,
    this.url = 'about:blank',
    this.title = '',
    this.incognito = false,
    this.desktop = false,
    this.zoom = 100,
    this.thumbnail,
    this.windowId,
  });
  final String id;
  String url;
  String title;
  final bool incognito;
  bool desktop;
  int zoom;
  Uint8List? thumbnail;
  int? windowId;
  bool visited = false;
  Map<String, Object?> toMap(int position) => {
    'id': id,
    'url': url,
    'title': title,
    'position': position,
    'desktop': desktop ? 1 : 0,
    'zoom': zoom,
    'thumbnail': thumbnail,
  };
  factory BrowserTab.fromMap(Map<String, Object?> value) => BrowserTab(
    id: value['id'] as String,
    url: value['url'] as String,
    title: value['title'] as String,
    desktop: value['desktop'] == 1,
    zoom: (value['zoom'] as int).clamp(50, 200),
    thumbnail: value['thumbnail'] as Uint8List?,
  );
}

class BrowserEntry {
  BrowserEntry({required this.url, required this.title, required this.time});
  final String url, title;
  final int time;
}

class BrowserDownload {
  BrowserDownload({
    required this.id,
    required this.name,
    required this.created,
    this.url = '',
    this.location = '',
    this.mime = 'application/octet-stream',
    this.status = 'downloading',
    this.bytes = 0,
  });
  final String id;
  String name, url, location, mime, status;
  final int created;
  int bytes;
  int? total;
  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'created': created,
    'url': url,
    'location': location,
    'mime': mime,
    'status': status,
    'bytes': bytes,
  };
  factory BrowserDownload.fromMap(Map<String, Object?> m) => BrowserDownload(
    id: m['id'] as String,
    name: m['name'] as String,
    created: m['created'] as int,
    url: m['url'] as String,
    location: m['location'] as String,
    mime: m['mime'] as String,
    status: m['status'] as String,
    bytes: m['bytes'] as int,
  );
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_platform.dart

```dart
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BrowserPlatform {
  static const channel = MethodChannel('cpdrive/browser_files');
  Future<void> clearPrivateData() async {
    if (!Platform.isAndroid) {
      return;
    }
    await CookieManager.instance().deleteAllCookies();
    await WebStorageManager.instance().deleteAllData();
    await InAppWebViewController.clearAllCache();
  }

  Future<Map<String, String>> publish(
    String source,
    String name,
    String mime,
    String notificationTitle,
  ) async {
    if (Platform.isAndroid) {
      final result = await channel.invokeMapMethod<String, dynamic>('publish', {
        'path': source,
        'name': name,
        'mime': mime,
        'title': notificationTitle,
      });
      if (result == null) {
        throw StateError('No saved download');
      }
      return {
        'location': result['location'] as String,
        'name': result['name'] as String,
        'mime': result['mime'] as String,
      };
    }
    final directory = Directory(
      path.join(
        (await getApplicationDocumentsDirectory()).path,
        'BrowserDownloads',
      ),
    );
    await directory.create(recursive: true);
    final destination = File(
      path.join(
        directory.path,
        '${DateTime.now().microsecondsSinceEpoch}_$name',
      ),
    );
    await File(source).copy(destination.path);
    await File(source).delete();
    return {'location': destination.path, 'name': name, 'mime': mime};
  }

  Future<void> open(String location, String mime) async {
    if (Platform.isAndroid) {
      await channel.invokeMethod<void>('open', {
        'location': location,
        'mime': mime,
      });
    } else {
      final result = await OpenFilex.open(location, type: mime);
      if (result.type != ResultType.done) {
        throw StateError(result.message);
      }
    }
  }

  Future<void> share(String location, String mime) async {
    if (Platform.isAndroid) {
      await channel.invokeMethod<void>('share', {
        'location': location,
        'mime': mime,
      });
    } else {
      await SharePlus.instance.share(
        ShareParams(files: [XFile(location, mimeType: mime)]),
      );
    }
  }

  Future<void> delete(String location) async {
    if (Platform.isAndroid) {
      final removed = await channel.invokeMethod<bool>('delete', {
        'location': location,
      });
      if (removed != true) {
        throw StateError('File not removed');
      }
    } else {
      final root = path.join(
        (await getApplicationDocumentsDirectory()).path,
        'BrowserDownloads',
      );
      if (!path.isWithin(root, location)) {
        throw StateError('Invalid download location');
      }
      final file = File(location);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_screen.dart

```dart
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
  const BrowserScreen({super.key, required this.active});
  final bool active;
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
  Timer? saveTimer;
  BrowserRuntime get runtime =>
      runtimes.putIfAbsent(session!.selected.id, BrowserRuntime.new);
  @override
  void initState() {
    super.initState();
    if (widget.active) {
      initialize();
    }
  }

  @override
  void didUpdateWidget(covariant BrowserScreen old) {
    super.didUpdateWidget(old);
    if (widget.active && session == null) {
      initialize();
    }
  }

  void initialize() {
    final store = ref.read(browserStoreProvider);
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
    saveTimer?.cancel();
    session?.removeListener(changed);
    session?.dispose();
    downloads?.dispose();
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_session.dart

```dart
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
      selected.visited = true;
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
    tab.visited = true;
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_store.dart

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'browser_models.dart';

final browserStoreProvider = Provider<BrowserStore>((ref) {
  final store = BrowserStore();
  ref.onDispose(() => store.close());
  return store;
});

class BrowserStore {
  BrowserStore({DatabaseFactory? factory, String? databasePath})
    : _factory = factory ?? databaseFactory,
      _path = databasePath;
  final DatabaseFactory _factory;
  final String? _path;
  Database? _database;
  Future<Database>? _opening;
  Future<void> _writes = Future.value();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    try {
      return _database ??= await (_opening ??= _open());
    } catch (_) {
      _opening = null;
      rethrow;
    }
  }

  Future<Database> _open() async => _factory.openDatabase(
    _path ??
        path.join(
          (await getApplicationSupportDirectory()).path,
          'cpdrive_browser.db',
        ),
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE tabs(id TEXT PRIMARY KEY,url TEXT NOT NULL,title TEXT NOT NULL,position INTEGER NOT NULL,desktop INTEGER NOT NULL,zoom INTEGER NOT NULL,thumbnail BLOB)',
        );
        await db.execute(
          'CREATE TABLE bookmarks(url TEXT PRIMARY KEY,title TEXT NOT NULL,created INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT,url TEXT NOT NULL,title TEXT NOT NULL,visited INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE INDEX history_visited ON history(visited DESC)',
        );
        await db.execute(
          'CREATE TABLE downloads(id TEXT PRIMARY KEY,name TEXT NOT NULL,url TEXT NOT NULL,location TEXT NOT NULL,mime TEXT NOT NULL,status TEXT NOT NULL,bytes INTEGER NOT NULL,created INTEGER NOT NULL)',
        );
        await db.execute(
          'CREATE TABLE metadata(key TEXT PRIMARY KEY,value TEXT NOT NULL)',
        );
      },
    ),
  );
  Future<List<BrowserTab>> tabs() async => (await (await database).query(
    'tabs',
    orderBy: 'position',
  )).map(BrowserTab.fromMap).toList();
  Future<void> saveTabs(List<BrowserTab> tabs, String? selected) {
    final rows = [
      for (final (i, tab) in tabs.where((t) => !t.incognito).indexed)
        tab.toMap(i),
    ];
    final write = _writes.catchError((Object _) {}).then((_) async {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('tabs');
        for (final row in rows) {
          await txn.insert('tabs', row);
        }
        if (selected != null) {
          await txn.insert('metadata', {
            'key': 'selected',
            'value': selected,
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        }
      });
    });
    _writes = write;
    return write;
  }

  Future<String?> value(String key) async =>
      (await (await database).query(
            'metadata',
            where: 'key=?',
            whereArgs: [key],
          )).firstOrNull?['value']
          as String?;
  Future<void> setValue(String key, String value) async => (await database)
      .insert('metadata', {
        'key': key,
        'value': value,
      }, conflictAlgorithm: ConflictAlgorithm.replace)
      .then((_) {});
  Future<void> addHistory(BrowserTab tab) async {
    if (tab.incognito ||
        !['https', 'http'].contains(Uri.tryParse(tab.url)?.scheme)) {
      return;
    }
    final entry = {
      'url': tab.url,
      'title': tab.title,
      'visited': DateTime.now().millisecondsSinceEpoch,
    };
    final db = await database;
    await db.insert('history', entry);
  }

  Future<List<BrowserEntry>> history([String search = '']) async {
    final rows = await (await database).query(
      'history',
      where: search.isEmpty ? null : 'instr(lower(url), lower(?)) > 0 OR instr(lower(title), lower(?)) > 0',
      whereArgs: search.isEmpty ? null : [search, search],
      orderBy: 'visited DESC',
    );
    return rows
        .map(
          (r) => BrowserEntry(
            url: r['url'] as String,
            title: r['title'] as String,
            time: r['visited'] as int,
          ),
        )
        .toList();
  }

  Future<void> clearHistory() async {
    await (await database).delete('history');
  }

  Future<List<BrowserEntry>> bookmarks() async =>
      (await (await database).query('bookmarks', orderBy: 'created DESC'))
          .map(
            (r) => BrowserEntry(
              url: r['url'] as String,
              title: r['title'] as String,
              time: r['created'] as int,
            ),
          )
          .toList();
  Future<void> bookmark(String url, String title, {String? previousUrl}) async {
    final db = await database;
    await db.transaction((txn) async {
      if (previousUrl != null) {
        await txn.delete('bookmarks', where: 'url=?', whereArgs: [previousUrl]);
      }
      await txn.insert('bookmarks', {
        'url': url,
        'title': title,
        'created': DateTime.now().millisecondsSinceEpoch,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<void> removeBookmark(String url) async {
    await (await database).delete(
      'bookmarks',
      where: 'url=?',
      whereArgs: [url],
    );
  }

  Future<List<BrowserDownload>> downloads() async =>
      (await (await database).query(
        'downloads',
        orderBy: 'created DESC',
      )).map(BrowserDownload.fromMap).toList();
  Future<void> saveDownload(BrowserDownload record) async {
    await (await database).insert(
      'downloads',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeDownload(String id) async {
    await (await database).delete('downloads', where: 'id=?', whereArgs: [id]);
  }

  Future<void> close() async {
    await _writes.catchError((Object _) {});
    await _database?.close();
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_tab_view.dart

```dart
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

  Future<void> pause() async {
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
    if (!widget.active) {
      unawaited(pause());
    } else if (!old.active && defaultTargetPlatform == TargetPlatform.android) {
      unawaited(
        widget.runtime.controller?.resume().catchError((Object _) {}) ??
            Future.value(),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      unawaited(pause());
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_urls.dart

```dart
Uri browserAddress(String input) {
  final text = input.trim();
  if (text.isEmpty) {
    return Uri.parse('about:blank');
  }
  final explicit = Uri.tryParse(text);
  if (explicit != null &&
      ['https', 'http'].contains(explicit.scheme.toLowerCase()) &&
      explicit.host.isNotEmpty &&
      !text.contains(RegExp(r'\s'))) {
    return explicit;
  }
  if (!text.contains(RegExp(r'\s')) &&
      !text.contains('://') &&
      (text.contains('.') || text.startsWith('localhost'))) {
    final candidate = Uri.tryParse('https://$text');
    if (candidate != null &&
        candidate.host.isNotEmpty &&
        !candidate.host.contains('@')) {
      return candidate;
    }
  }
  return Uri.https('www.google.com', '/search', {'q': text});
}

bool isWebAddress(Uri url) =>
    ['http', 'https'].contains(url.scheme.toLowerCase()) &&
    url.host.isNotEmpty &&
    url.userInfo.isEmpty;
Uri? intentFallback(String input) {
  final match = RegExp(r'(?:#Intent;|;)S\.browser_fallback_url=([^;]+)')
      .firstMatch(input);
  if (match == null) {
    return null;
  }
  try {
    final uri = Uri.parse(Uri.decodeComponent(match.group(1)!));
    return isWebAddress(uri) ? uri : null;
  } catch (_) {
    return null;
  }
}

String safeDownloadName(String value) {
  var name = value
      .split(RegExp(r'[/\\]'))
      .last
      .replaceAll(RegExp(r'[\x00-\x1f<>:"|?*]'), '_')
      .trim();
  name = name.replaceAll(RegExp(r'^\.+|[. ]+$'), '');
  if (name.isEmpty) {
    name = 'download';
  }
  return name.length > 160 ? name.substring(name.length - 160) : name;
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_controller.dart

```dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

import 'gallery_library.dart';

class GalleryController extends ChangeNotifier {
  GalleryController(this.library);
  final GalleryLibrary library;
  PermissionState? permission;
  GalleryFilter filter = GalleryFilter.all;
  String selectedAlbum = 'all';
  List<AssetPathEntity> albums = [];
  List<AssetEntity> items = [];
  bool requested = false;
  bool busy = false;
  bool loadingMore = false;
  bool hasMore = false;
  Object? error;
  int _generation = 0;
  int _page = 0;
  AssetPathEntity? _path;
  bool _disposed = false;
  bool _watching = false;
  Timer? _debounce;
  bool get accessible => permission?.hasAccess ?? false;
  bool get limited => permission == PermissionState.limited;
  Future<void> refresh({bool request = false}) async {
    if (_disposed) {
      return;
    }
    if (request) {
      requested = true;
    }
    final generation = ++_generation;
    busy = true;
    error = null;
    loadingMore = false;
    notifyListeners();
    try {
      final state = await library.permission(request: request);
      if (_disposed || generation != _generation) {
        return;
      }
      permission = state;
      // Do not retain assets after access is revoked or reduced.
      items = [];
      albums = [];
      _path = null;
      _page = 0;
      hasMore = false;
      if (!accessible) {
        return;
      }
      final paths = await library.albums(
        selectedAlbum == 'videos' ? GalleryFilter.videos : filter,
      );
      if (_disposed || generation != _generation) {
        return;
      }
      albums = paths;
      if (selectedAlbum != 'all' &&
          selectedAlbum != 'favorites' &&
          selectedAlbum != 'videos' &&
          !paths.any((p) => p.id == selectedAlbum)) {
        selectedAlbum = 'all';
      }
      if (paths.isNotEmpty) {
        _path =
            selectedAlbum == 'all' ||
                selectedAlbum == 'favorites' ||
                selectedAlbum == 'videos'
            ? paths.firstWhere((path) => path.isAll, orElse: () => paths.first)
            : paths.firstWhere((path) => path.id == selectedAlbum);
        hasMore = true;
        await _fetchPage(generation);
      }
      if (!_watching && !_disposed && generation == _generation && accessible) {
        _watching = true;
        try {
          await library.watch(() {
            _debounce?.cancel();
            _debounce = Timer(
              const Duration(milliseconds: 400),
              () => refresh(),
            );
          });
        } catch (_) {
          _watching = false;
        }
        if (_disposed) {
          await library.unwatch();
        }
      }
    } catch (failure) {
      if (!_disposed && generation == _generation) {
        error = failure;
      }
    } finally {
      if (!_disposed && generation == _generation) {
        busy = false;
        notifyListeners();
      }
    }
  }

  Future<void> _fetchPage(int generation) async {
    final path = _path;
    if (path == null) {
      return;
    }
    final page = await library.page(path, _page);
    if (_disposed || generation != _generation) {
      return;
    }
    _page++;
    hasMore = page.length == 80;
    final ids = items.map((a) => a.id).toSet();
    items = [
      ...items,
      ...page.where(
        (asset) =>
            (asset.type == AssetType.image || asset.type == AssetType.video) &&
            (selectedAlbum != 'favorites' || asset.isFavorite) &&
            ids.add(asset.id),
      ),
    ];
  }

  Future<void> loadMore() async {
    if (_disposed || busy || loadingMore || !hasMore) {
      return;
    }
    final generation = _generation;
    loadingMore = true;
    error = null;
    notifyListeners();
    try {
      await _fetchPage(generation);
    } catch (failure) {
      if (!_disposed && generation == _generation) {
        error = failure;
      }
    } finally {
      if (!_disposed && generation == _generation) {
        loadingMore = false;
        notifyListeners();
      }
    }
  }

  Future<void> choose({GalleryFilter? type, String? album}) async {
    if (type != null && selectedAlbum == 'videos') {
      selectedAlbum = 'all';
    }
    filter = album == 'videos' ? GalleryFilter.videos : type ?? filter;
    selectedAlbum = album ?? selectedAlbum;
    await refresh();
  }

  Future<void> selectMore() async {
    if (_disposed || busy) {
      return;
    }
    busy = true;
    notifyListeners();
    try {
      await library.selectMore();
      await refresh();
    } catch (failure) {
      if (!_disposed) {
        error = failure;
        busy = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _generation++;
    _debounce?.cancel();
    unawaited(library.unwatch().catchError((Object _) {}));
    super.dispose();
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_format.dart

```dart
String mediaDuration(int seconds) {
  final duration = Duration(seconds: seconds);
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return duration.inHours > 0
      ? '${duration.inHours}:$minutes:$secs'
      : '$minutes:$secs';
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_library.dart

```dart
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

final galleryLibraryProvider = Provider<GalleryLibrary>(
  (ref) => DeviceGalleryLibrary(),
);

enum GalleryFilter { all, photos, videos }

abstract class GalleryLibrary {
  Future<PermissionState> permission({bool request = false});
  Future<List<AssetPathEntity>> albums(GalleryFilter filter);
  Future<List<AssetEntity>> page(AssetPathEntity album, int index);
  Future<void> selectMore();
  Future<void> openSettings();
  Future<void> watch(VoidCallback callback);
  Future<void> unwatch();
  Future<bool> delete(AssetEntity asset);
}

class DeviceGalleryLibrary implements GalleryLibrary {
  static const permissionOption = PermissionRequestOption(
    androidPermission: AndroidPermission(
      type: RequestType.common,
      mediaLocation: false,
    ),
  );
  void Function(MethodCall)? _change;
  @override
  Future<PermissionState> permission({bool request = false}) => request
      ? PhotoManager.requestPermissionExtend(requestOption: permissionOption)
      : PhotoManager.getPermissionState(requestOption: permissionOption);
  @override
  Future<List<AssetPathEntity>> albums(GalleryFilter filter) =>
      PhotoManager.getAssetPathList(
        type: switch (filter) {
          GalleryFilter.all => RequestType.common,
          GalleryFilter.photos => RequestType.image,
          GalleryFilter.videos => RequestType.video,
        },
        filterOption: FilterOptionGroup(
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
  @override
  Future<List<AssetEntity>> page(AssetPathEntity album, int index) =>
      album.getAssetListPaged(page: index, size: 80);
  @override
  Future<void> selectMore() =>
      PhotoManager.presentLimited(type: RequestType.common);
  @override
  Future<void> openSettings() => PhotoManager.openSetting();
  @override
  Future<void> watch(VoidCallback callback) async {
    if (_change != null) {
      return;
    }
    _change = (_) => callback();
    PhotoManager.addChangeCallback(_change!);
    try {
      await PhotoManager.startChangeNotify();
    } catch (_) {
      PhotoManager.removeChangeCallback(_change!);
      _change = null;
      rethrow;
    }
  }

  @override
  Future<void> unwatch() async {
    final change = _change;
    _change = null;
    if (change != null) {
      PhotoManager.removeChangeCallback(change);
      await PhotoManager.stopChangeNotify();
    }
  }

  @override
  Future<bool> delete(AssetEntity asset) async =>
      (await PhotoManager.editor.deleteWithIds([asset.id])).contains(asset.id);
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_permission_screen.dart

```dart
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../l10n/app_localizations.dart';
import 'gallery_controller.dart';
import 'gallery_format.dart';
import 'gallery_library.dart';
import 'gallery_permission_screen.dart';
import 'gallery_viewer.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key, required this.active});
  final bool active;
  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen>
    with WidgetsBindingObserver {
  late final GalleryController controller;
  final scroll = ScrollController();
  bool started = false;
  @override
  void initState() {
    super.initState();
    controller = GalleryController(ref.read(galleryLibraryProvider));
    WidgetsBinding.instance.addObserver(this);
    scroll.addListener(more);
    if (widget.active) {
      started = true;
      controller.refresh();
    }
  }

  void more() {
    if (scroll.hasClients && scroll.position.extentAfter < 600) {
      controller.loadMore();
    }
  }

  @override
  void didUpdateWidget(covariant GalleryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      started = true;
      controller.refresh();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && widget.active && started) {
      controller.refresh();
    }
  }

  Future<void> openSettings() async {
    try {
      await controller.library.openSettings();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.actionFailed)),
        );
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scroll.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> viewer(int index) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) =>
            GalleryViewer(controller: controller, initialIndex: index),
      ),
    );
    if (mounted) {
      controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (controller.busy && !controller.accessible) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!controller.accessible) {
          if (controller.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(text.galleryError),
                  TextButton(
                    onPressed: controller.refresh,
                    child: Text(text.retry),
                  ),
                ],
              ),
            );
          }
          return GalleryPermissionScreen(
            denied:
                controller.requested &&
                controller.permission != null &&
                controller.permission != PermissionState.notDetermined,
            onAllow: () => controller.refresh(request: true),
            onSettings: openSettings,
          );
        }
        return Column(
          children: [
            if (controller.limited)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(text.limitedAccess),
                    TextButton(
                      onPressed: controller.busy ? null : controller.selectMore,
                      child: Text(text.selectMore),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                value:
                    [
                      'all',
                      'videos',
                      'favorites',
                      ...controller.albums.map((a) => a.id),
                    ].contains(controller.selectedAlbum)
                    ? controller.selectedAlbum
                    : 'all',
                isExpanded: true,
                hint: Text(text.albums),
                items: [
                  DropdownMenuItem(value: 'all', child: Text(text.allMedia)),
                  DropdownMenuItem(value: 'videos', child: Text(text.videos)),
                  DropdownMenuItem(
                    value: 'favorites',
                    child: Text(text.favorites),
                  ),
                  for (final album in controller.albums.where(
                    (album) => !album.isAll,
                  ))
                    DropdownMenuItem(
                      value: album.id,
                      child: Text(album.name, overflow: TextOverflow.ellipsis),
                    ),
                ],
                onChanged: controller.busy
                    ? null
                    : (value) => controller.choose(album: value),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  for (final (index, label) in [
                    text.allMedia,
                    text.photos,
                    text.videos,
                  ].indexed)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(label),
                        selected: controller.filter.index == index,
                        onSelected: controller.busy
                            ? null
                            : (_) => controller.choose(
                                type: GalleryFilter.values[index],
                              ),
                      ),
                    ),
                ],
              ),
            ),
            if (controller.busy) const LinearProgressIndicator(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refresh,
                child: CustomScrollView(
                  controller: scroll,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (controller.error != null)
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Text(text.galleryError),
                            TextButton(
                              onPressed: controller.busy
                                  ? null
                                  : controller.refresh,
                              child: Text(text.retry),
                            ),
                          ],
                        ),
                      ),
                    if (controller.items.isEmpty &&
                        !controller.busy &&
                        !controller.hasMore &&
                        controller.error == null)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: Text(text.emptyGallery)),
                      ),
                    SliverPadding(
                      padding: const EdgeInsets.all(4),
                      sliver: SliverLayoutBuilder(
                        builder: (context, constraints) {
                          final columns = (constraints.crossAxisExtent / 120)
                              .floor()
                              .clamp(2, 6);
                          return SliverGrid.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                ),
                            itemCount: controller.items.length,
                            itemBuilder: (context, index) {
                              final item = controller.items[index];
                              return Semantics(
                                button: true,
                                label:
                                    '${item.type == AssetType.video ? text.videos : text.photos} ${index + 1}',
                                child: InkWell(
                                  onTap: () => viewer(index),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      AssetEntityImage(
                                        item,
                                        isOriginal: false,
                                        thumbnailSize:
                                            const ThumbnailSize.square(240),
                                        fit: BoxFit.cover,
                                        excludeFromSemantics: true,
                                        errorBuilder: (context, error, stack) =>
                                            const Center(
                                              child: Icon(
                                                Icons.broken_image_outlined,
                                              ),
                                            ),
                                      ),
                                      if (item.type == AssetType.video)
                                        Positioned(
                                          right: 4,
                                          bottom: 4,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            color: Colors.black87,
                                            child: Text(
                                              mediaDuration(item.duration),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    if (controller.loadingMore)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    if (controller.hasMore &&
                        !controller.busy &&
                        !controller.loadingMore)
                      SliverToBoxAdapter(
                        child: TextButton(
                          onPressed: controller.loadMore,
                          child: Text(text.loadMore),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_video.dart

```dart
import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

import '../../l10n/app_localizations.dart';

class GalleryVideo extends StatefulWidget {
  const GalleryVideo({super.key, required this.asset, required this.active});
  final AssetEntity asset;
  final bool active;
  @override
  State<GalleryVideo> createState() => _GalleryVideoState();
}

class _GalleryVideoState extends State<GalleryVideo>
    with WidgetsBindingObserver {
  VideoPlayerController? video;
  ChewieController? chewie;
  bool failed = false;
  bool loading = false;
  int generation = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.active && video == null && !loading && !failed) {
      initialize();
    }
  }

  @override
  void didUpdateWidget(covariant GalleryVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.active) {
      pause();
    } else if (video == null && !loading && !failed) {
      initialize();
    }
  }

  Future<void> initialize() async {
    if (loading) {
      return;
    }
    final current = ++generation;
    loading = true;
    failed = false;
    VideoPlayerController? candidate;
    try {
      final file = await widget.asset.file;
      if (!mounted || current != generation) {
        return;
      }
      if (file == null) {
        throw StateError('Media unavailable');
      }
      candidate = VideoPlayerController.file(file);
      await candidate.initialize();
      if (!mounted || current != generation) {
        await candidate.dispose();
        return;
      }
      final text = AppLocalizations.of(context)!;
      final player = ChewieController(
        videoPlayerController: candidate,
        autoPlay: false,
        allowMuting: true,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: false,
        showOptions: false,
        errorBuilder: (context, error) => Center(child: Text(text.videoError)),
      );
      video = candidate;
      chewie = player;
      setState(() => loading = false);
    } catch (_) {
      await candidate?.dispose();
      if (mounted && current == generation) {
        setState(() {
          loading = false;
          failed = true;
        });
      }
    }
  }

  void pause() {
    final controller = video;
    if (controller != null) {
      unawaited(controller.pause().catchError((Object _) {}));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      pause();
    }
  }

  @override
  void dispose() {
    generation++;
    WidgetsBinding.instance.removeObserver(this);
    chewie?.dispose();
    final controller = video;
    if (controller != null) {
      unawaited(controller.dispose().catchError((Object _) {}));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    if (failed) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text.videoError),
            TextButton(
              onPressed: () {
                setState(() => failed = false);
                initialize();
              },
              child: Text(text.retry),
            ),
          ],
        ),
      );
    }
    if (chewie == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Center(child: Chewie(controller: chewie!));
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_viewer.dart

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/app_localizations.dart';
import 'gallery_controller.dart';
import 'gallery_format.dart';
import 'gallery_video.dart';

class GalleryViewer extends StatefulWidget {
  const GalleryViewer({
    super.key,
    required this.controller,
    required this.initialIndex,
  });
  final GalleryController controller;
  final int initialIndex;
  @override
  State<GalleryViewer> createState() => _GalleryViewerState();
}

class _GalleryViewerState extends State<GalleryViewer> {
  late final PageController pages;
  late List<AssetEntity> items;
  late int index;
  bool acting = false;
  bool extending = false;
  bool closing = false;
  void libraryChanged() {
    if (!mounted || !widget.controller.busy || closing) {
      return;
    }
    final route = ModalRoute.of(context);
    if (route == null || !route.isActive) {
      return;
    }
    closing = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // A popped route stays mounted during its exit animation.
      if (!mounted || !route.isActive) {
        return;
      }
      final navigator = Navigator.of(context);
      navigator.popUntil((candidate) => candidate == route);
      if (route.isCurrent) {
        navigator.pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(libraryChanged);
    items = List.of(widget.controller.items);
    index = widget.initialIndex;
    pages = PageController(initialPage: index);
    if (index >= items.length - 4) {
      extend();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(libraryChanged);
    pages.dispose();
    super.dispose();
  }

  Future<void> extend() async {
    if (extending ||
        widget.controller.busy ||
        widget.controller.loadingMore ||
        !widget.controller.hasMore) {
      return;
    }
    extending = true;
    final oldLength = items.length;
    // Favorites may be sparse; keep reading bounded native pages until a new item is found.
    do {
      await widget.controller.loadMore();
      if (!mounted) {
        return;
      }
      final ids = items.map((asset) => asset.id).toSet();
      items.addAll(widget.controller.items.where((asset) => ids.add(asset.id)));
    } while (items.length == oldLength &&
        widget.controller.hasMore &&
        widget.controller.error == null &&
        !widget.controller.busy);
    if (mounted) {
      setState(() => extending = false);
    }
  }

  void message(String value) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }
  }

  Future<void> action(
    Future<void> Function(AssetEntity asset) operation,
  ) async {
    if (acting || items.isEmpty) {
      return;
    }
    setState(() => acting = true);
    try {
      await operation(items[index]);
    } catch (_) {
      if (mounted) {
        message(AppLocalizations.of(context)!.actionFailed);
      }
    } finally {
      if (mounted) {
        setState(() => acting = false);
      }
    }
  }

  Future<void> share(AssetEntity asset) async {
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null
        ? null
        : box.localToGlobal(Offset.zero) & box.size;
    final file = await asset.file;
    if (!mounted) {
      return;
    }
    if (file == null) {
      message(AppLocalizations.of(context)!.mediaUnavailable);
      return;
    }
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], sharePositionOrigin: origin),
    );
  }

  Future<void> delete(AssetEntity asset) async {
    final text = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(text.deleteMedia),
        content: Text(text.deleteHint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(text.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(text.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }
    final deleted = await widget.controller.library.delete(asset);
    if (!mounted) {
      return;
    }
    if (!deleted) {
      message(text.deleteCancelled);
      return;
    }
    // Return to a refreshed grid, avoiding stale PageView indices after deletion.
    Navigator.of(context).pop();
  }

  Future<void> info(AssetEntity asset) async {
    final text = AppLocalizations.of(context)!;
    int? size;
    try {
      final file = await asset.file;
      size = await file?.length();
    } catch (_) {
      /* Metadata remains available for cloud-only assets. */
    }
    if (!mounted) {
      return;
    }
    final album = widget.controller.selectedAlbum == 'favorites'
        ? text.favorites
        : widget.controller.selectedAlbum == 'videos'
        ? text.videos
        : widget.controller.selectedAlbum == 'all'
        ? text.allMedia
        : widget.controller.albums
                  .where((a) => a.id == widget.controller.selectedAlbum)
                  .map((a) => a.name)
                  .firstOrNull ??
              text.notAvailable;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final created = asset.createDateSecond == null
        ? text.notAvailable
        : DateFormat.yMMMd(locale).add_jm().format(asset.createDateTime);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.75,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(text.info, style: Theme.of(context).textTheme.headlineSmall),
            for (final field in [
              (text.filename, asset.title ?? text.notAvailable),
              (text.created, created),
              (
                text.fileSize,
                size == null
                    ? text.notAvailable
                    : '${(size / 1048576).toStringAsFixed(2)} MB',
              ),
              (text.resolution, '${asset.width} × ${asset.height}'),
              if (asset.type == AssetType.video)
                (text.duration, mediaDuration(asset.duration)),
              (text.album, album),
            ])
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(field.$1),
                subtitle: Text(field.$2),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(text.close),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('${index + 1} / ${items.length}'),
        actions: [
          IconButton(
            tooltip: text.share,
            onPressed: acting ? null : () => action(share),
            icon: const Icon(Icons.share),
          ),
          IconButton(
            tooltip: text.info,
            onPressed: acting ? null : () => action(info),
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(
            tooltip: text.delete,
            onPressed: acting ? null : () => action(delete),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (acting || extending) const LinearProgressIndicator(),
            Expanded(
              child: AbsorbPointer(
                absorbing: acting,
                child: PageView.builder(
                  controller: pages,
                  itemCount: items.length,
                  onPageChanged: (value) {
                    setState(() => index = value);
                    if (value >= items.length - 4) {
                      extend();
                    }
                  },
                  itemBuilder: (context, page) {
                    final item = items[page];
                    return item.type == AssetType.video
                        ? GalleryVideo(
                            key: ValueKey(item.id),
                            asset: item,
                            active: page == index && !acting,
                          )
                        : PhotoViewGestureDetectorScope(
                            axis: Axis.horizontal,
                            child: PhotoView(
                              imageProvider: AssetEntityImageProvider(
                                item,
                                isOriginal: true,
                              ),
                              minScale: PhotoViewComputedScale.contained,
                              maxScale: PhotoViewComputedScale.covered * 4,
                              initialScale: PhotoViewComputedScale.contained,
                              backgroundDecoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              loadingBuilder: (context, event) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorBuilder: (context, error, stack) => Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Text(text.mediaUnavailable),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  tooltip: text.previousItem,
                  onPressed: index == 0 || acting
                      ? null
                      : () => pages.previousPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        ),
                  icon: const Icon(Icons.chevron_left),
                ),
                if (index == items.length - 1 && widget.controller.hasMore)
                  TextButton(
                    onPressed: extending ? null : extend,
                    child: Text(text.loadMore),
                  ),
                IconButton(
                  tooltip: text.nextItem,
                  onPressed: index >= items.length - 1 || acting
                      ? null
                      : () => pages.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        ),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\match_details\match_details_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/refresh_controller.dart';
import '../../l10n/app_localizations.dart';
import '../matches/match_repository.dart';
import '../matches/models/match.dart';
import '../settings/settings_controller.dart';

class MatchDetailsScreen extends ConsumerStatefulWidget {
  const MatchDetailsScreen({super.key, required this.id});
  final int id;
  @override
  ConsumerState<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends ConsumerState<MatchDetailsScreen> {
  late final RefreshController<Match> controller;
  late final SettingsController settings;
  @override
  void initState() {
    super.initState();
    settings = ref.read(settingsProvider);
    controller = RefreshController(
      fetch: (token) => ref
          .read(matchRepositoryProvider)
          .details(widget.id, cancelToken: token),
      seconds: settings.detailSeconds,
    );
    settings.addListener(configure);
    configure();
    controller.refresh();
  }

  void configure() =>
      controller.configure(interval: settings.detailSeconds, enabled: true);
  @override
  void dispose() {
    settings.removeListener(configure);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(text.details),
        actions: [
          IconButton(
            tooltip: text.refresh,
            onPressed: controller.refresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, child) {
            final match = controller.data;
            return RefreshIndicator(
              onRefresh: controller.refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                children: [
                  if (controller.loading) const LinearProgressIndicator(),
                  if (controller.error != null) ...[
                    Text(
                      controller.offline && match != null
                          ? text.offline
                          : text.unavailableMatch,
                    ),
                    TextButton(
                      onPressed: controller.loading ? null : controller.refresh,
                      child: Text(text.retry),
                    ),
                  ],
                  if (match != null) ...[
                    Text(
                      match.title(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (match.score.isNotEmpty)
                      Text(
                        match.score,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    const SizedBox(height: 20),
                    for (final team in [
                      (match.team1Name, match.team1Score),
                      (match.team2Name, match.team2Score),
                    ])
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                team.$1,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                team.$2.isEmpty ? text.notAvailable : team.$2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    for (final field in [
                      (
                        text.status,
                        [
                          text.live,
                          text.upcoming,
                          text.results,
                        ][match.status.index],
                      ),
                      (text.result, match.result),
                      (text.toss, match.tossText()),
                      (text.format, match.format),
                      (text.tournament, match.tournament),
                      (text.round, match.round),
                      (text.venue, match.venue()),
                      (
                        text.dateTime,
                        [
                          match.date,
                          match.start,
                        ].where((s) => s.isNotEmpty).join(' · '),
                      ),
                    ])
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(field.$1),
                        subtitle: Text(
                          field.$2.isEmpty ? text.notAvailable : field.$2,
                        ),
                      ),
                    if (match.status == MatchStatus.live)
                      FilledButton.icon(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(content: Text(text.audioPhase)),
                            ),
                        icon: const Icon(Icons.headphones),
                        label: Text(text.listenLive),
                      ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\home_screen.dart

```dart
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../audio/mini_player_placeholder.dart';
import '../gallery/gallery_screen.dart';
import '../browser/browser_screen.dart';
import '../settings/settings_screen.dart';
import 'matches_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final labels = [text.matches, text.gallery, text.browser, text.settings];
    return Scaffold(
      appBar: AppBar(
        title: Text(selected == 0 ? text.appTitle : labels[selected]),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: selected,
                children: [
                  MatchesScreen(active: selected == 0),
                  GalleryScreen(active: selected == 1),
                  BrowserScreen(active: selected == 2),
                  const SettingsScreen(),
                ],
              ),
            ),
            const MiniPlayerPlaceholder(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (value) => setState(() => selected = value),
        destinations: [
          for (final (i, icon) in [
            Icons.sports_cricket,
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\match_card.dart

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import 'models/match.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key, required this.match});
  final Match match;
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: match.id == null
            ? null
            : () => context.push('/matches/${match.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 48,
                height: 48,
                excludeFromSemantics: true,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.title(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      match.statusLine().isEmpty
                          ? text.live
                          : match.statusLine(),
                    ),
                    if (match.tournament.isNotEmpty)
                      Text(
                        match.tournament,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    if (match.status == MatchStatus.live)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          text.live.toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\match_repository.dart

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_config.dart';
import 'models/match.dart';

final matchRepositoryProvider = Provider<MatchRepository>(
  (ref) => MatchRepository(ref.watch(apiProvider)),
);

class MatchRepository {
  MatchRepository(this.dio);
  final Dio dio;
  Future<List<Match>> list({String? userId, CancelToken? cancelToken}) async {
    final response = await dio.get<Object?>(
      ApiConfig.endpoint('championships/matches/'),
      queryParameters: {
        'limit': 40,
        'cache_buster': DateTime.now().millisecondsSinceEpoch,
        'user': ?userId,
      },
      cancelToken: cancelToken,
    );
    final data = response.data;
    if (data is! List && (data is! Map || data['results'] is! List)) {
      throw const FormatException('Invalid match list');
    }
    return Match.parseList(data);
  }

  Future<Match> details(int id, {CancelToken? cancelToken}) async {
    final response = await dio.get<Object?>(
      ApiConfig.endpoint('championships/matches/$id/'),
      cancelToken: cancelToken,
    );
    if (response.data is! Map) {
      throw const FormatException('Invalid match details');
    }
    final match = Match.fromJson(response.data);
    if (match.id != id) {
      throw const FormatException('Mismatched match id');
    }
    return match;
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\matches_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../core/router/route_observer.dart';
import '../../core/utils/refresh_controller.dart';
import '../../l10n/app_localizations.dart';
import '../settings/settings_controller.dart';
import 'match_card.dart';
import 'match_repository.dart';
import 'models/match.dart';

class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({super.key, required this.active});
  final bool active;
  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen> with RouteAware {
  bool routeVisible = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void didPushNext() {
    routeVisible = false;
    configure();
  }

  @override
  void didPopNext() {
    routeVisible = true;
    configure();
    (tab == 3 ? mine : all).refresh();
  }

  late final RefreshController<List<Match>> all;
  late final RefreshController<List<Match>> mine;
  late final SettingsController settings;
  int tab = 0;
  @override
  void initState() {
    super.initState();
    settings = ref.read(settingsProvider);
    final repository = ref.read(matchRepositoryProvider);
    all = RefreshController(
      fetch: (token) => repository.list(cancelToken: token),
      seconds: settings.listSeconds,
    );
    mine = RefreshController(
      fetch: (token) {
        final id = ref.read(authProvider).userId;
        if (id == null) {
          throw StateError('Signed out');
        }
        return repository.list(userId: id, cancelToken: token);
      },
      seconds: settings.listSeconds,
    );
    settings.addListener(configure);
    configure();
    all.refresh();
  }

  void configure() {
    all.configure(
      interval: settings.listSeconds,
      enabled: widget.active && routeVisible && tab != 3,
    );
    mine.configure(
      interval: settings.listSeconds,
      enabled: widget.active && routeVisible && tab == 3,
    );
  }

  @override
  void didUpdateWidget(covariant MatchesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    configure();
    if (widget.active && !oldWidget.active) {
      (tab == 3 ? mine : all).refresh();
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    settings.removeListener(configure);
    all.dispose();
    mine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final current = tab == 3 ? mine : all;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              for (final (i, label) in [
                text.live,
                text.upcoming,
                text.results,
                text.myMatches,
              ].indexed)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(label),
                    selected: tab == i,
                    onSelected: (_) {
                      setState(() => tab = i);
                      configure();
                      if ((i == 3 ? mine : all).data == null) {
                        (i == 3 ? mine : all).refresh();
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListenableBuilder(
            listenable: current,
            builder: (context, child) {
              final data = current.data;
              final filtered =
                  data
                      ?.where(
                        (match) =>
                            tab == 3 || match.status == MatchStatus.values[tab],
                      )
                      .toList() ??
                  [];
              return RefreshIndicator(
                onRefresh: current.refresh,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (current.loading)
                      const SliverToBoxAdapter(
                        child: LinearProgressIndicator(),
                      ),
                    if (current.error != null)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Semantics(
                                liveRegion: true,
                                child: Text(
                                  current.offline && data != null
                                      ? text.offline
                                      : text.loadError,
                                ),
                              ),
                              TextButton(
                                onPressed: current.loading
                                    ? null
                                    : current.refresh,
                                child: Text(text.retry),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (filtered.isEmpty &&
                        !current.loading &&
                        current.error == null)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              [
                                text.noLive,
                                text.noUpcoming,
                                text.noResults,
                                text.noMine,
                              ][tab],
                            ),
                          ),
                        ),
                      ),
                    SliverPadding(
                      padding: const EdgeInsets.all(12),
                      sliver: SliverList.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) =>
                            MatchCard(match: filtered[index]),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\models\match.dart

```dart
typedef Json = Map<String, dynamic>;
Json object(Object? value) => value is Map
    ? value.map((key, value) => MapEntry(key.toString(), value))
    : {};
String string(Object? value) =>
    value is String || value is num ? value.toString() : '';
int? integer(Object? value) =>
    value is int ? value : int.tryParse(string(value));

enum MatchStatus { live, upcoming, result }

class Match {
  Match.fromJson(Object? value) {
    final json = object(value);
    final raw = object(json['rawdata']);
    id = integer(json['id']);
    status = switch (json['match_status']) {
      'Live' => MatchStatus.live,
      'Upcoming' => MatchStatus.upcoming,
      _ => MatchStatus.result,
    };
    team1 = integer(json['team1']);
    team2 = integer(json['team2']);
    toss = integer(json['toss']);
    team1Name = string(object(raw['team1'])['name']);
    team2Name = string(object(raw['team2'])['name']);
    if (team1Name.trim().isEmpty) {
      team1Name = 'Team A';
    }
    if (team2Name.trim().isEmpty) {
      team2Name = 'Team B';
    }
    tournament = string(object(raw['tournament'])['title']);
    round = string(object(raw['rounds'])['title']);
    final ground = object(raw['ground']);
    groundName = string(ground['title']);
    city = string(ground['city']);
    result = string(json['result']);
    date = string(json['date']);
    start = string(json['start']);
    choose = string(json['choose']);
    format = string(json['format']);
    score = string(json['score']);
    team1Score = string(json['team1_score']);
    team2Score = string(json['team2_score']);
    final url = Uri.tryParse(string(json['stream_url']));
    streamUrl =
        url != null &&
            (url.scheme == 'https' || url.scheme == 'http') &&
            url.host.isNotEmpty
        ? url
        : null;
  }
  late final int? id, team1, team2, toss;
  late final MatchStatus status;
  late String team1Name, team2Name;
  late final String tournament,
      round,
      groundName,
      city,
      result,
      date,
      start,
      choose,
      format,
      score,
      team1Score,
      team2Score;
  late final Uri? streamUrl;
  String title() => '$team1Name vs $team2Name';
  String statusLine() {
    if (status == MatchStatus.result) {
      return result.isEmpty ? 'Result' : result;
    }
    if (status == MatchStatus.live) {
      return score.isNotEmpty
          ? score
          : [team1Score, team2Score].where((s) => s.isNotEmpty).join(' · ');
    }
    return [date, start, tournament].where((s) => s.isNotEmpty).join(' · ');
  }

  String tossText() {
    final name = toss != null && toss == team1
        ? team1Name
        : toss != null && toss == team2
        ? team2Name
        : '';
    final action = switch (choose) {
      'Batting' => 'bat',
      'Bowling' => 'bowl',
      _ => '',
    };
    return name.isEmpty
        ? ''
        : action.isEmpty
        ? '$name won the toss'
        : '$name won the toss and chose to $action';
  }

  String venue() => [groundName, city].where((s) => s.isNotEmpty).join(', ');
  static List<Match> parseList(Object? value) {
    final items = value is List ? value : object(value)['results'];
    return items is List
        ? items.whereType<Map>().map(Match.fromJson).toList()
        : [];
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\settings\settings_controller.dart

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider = Provider<SettingsController>(
  (ref) => throw StateError('Settings must be initialized'),
);

class SettingsController extends ChangeNotifier {
  SettingsController(this.preferences);
  final SharedPreferencesAsync preferences;
  ThemeMode theme = ThemeMode.system;
  String language = 'system';
  int listSeconds = 120;
  int detailSeconds = 60;
  double speechRate = 0.5;
  bool showInCar = true;
  List<String> carTabs = ['live', 'upcoming', 'results', 'mine'];
  static const allTabs = ['live', 'upcoming', 'results', 'mine'];
  static const key = 'cpdrive.settings.v1';
  Future<void> load() async {
    final raw = await preferences.getString(key);
    if (raw == null) {
      return;
    }
    try {
      final value = jsonDecode(raw);
      if (value is! Map) {
        return;
      }
      theme = ThemeMode.values.firstWhere(
        (t) => t.name == value['theme'],
        orElse: () => ThemeMode.system,
      );
      language = ['system', 'en', 'hi'].contains(value['language'])
          ? value['language'] as String
          : 'system';
      listSeconds =
          value['listSeconds'] is int &&
              [30, 60, 120, 300].contains(value['listSeconds'])
          ? value['listSeconds'] as int
          : 120;
      detailSeconds =
          value['detailSeconds'] is int &&
              [30, 60, 120].contains(value['detailSeconds'])
          ? value['detailSeconds'] as int
          : 60;
      final rate = value['speechRate'];
      speechRate = rate is num && rate.isFinite
          ? rate.toDouble().clamp(0.2, 1.0)
          : 0.5;
      showInCar = value['showInCar'] is bool
          ? value['showInCar'] as bool
          : true;
      final tabs = value['carTabs'];
      if (tabs is List) {
        final valid = tabs
            .whereType<String>()
            .where(allTabs.contains)
            .toSet()
            .toList();
        if (valid.isNotEmpty) {
          carTabs = valid;
        }
      }
    } on FormatException {
      /* Invalid saved data uses defaults. */
    }
  }

  Future<void> update({
    ThemeMode? themeMode,
    String? locale,
    int? listInterval,
    int? detailInterval,
    double? rate,
    bool? car,
    List<String>? tabs,
  }) async {
    if (locale != null && !['system', 'en', 'hi'].contains(locale) ||
        listInterval != null && ![30, 60, 120, 300].contains(listInterval) ||
        detailInterval != null && ![30, 60, 120].contains(detailInterval) ||
        rate != null && (!rate.isFinite || rate < 0.2 || rate > 1)) {
      throw ArgumentError('Unsupported settings value');
    }
    final nextTabs = tabs ?? carTabs;
    if (nextTabs.isEmpty ||
        nextTabs.toSet().length != nextTabs.length ||
        !nextTabs.every(allTabs.contains)) {
      throw ArgumentError('Select at least one unique car tab');
    }
    final next = {
      'theme': (themeMode ?? theme).name,
      'language': locale ?? language,
      'listSeconds': listInterval ?? listSeconds,
      'detailSeconds': detailInterval ?? detailSeconds,
      'speechRate': rate ?? speechRate,
      'showInCar': car ?? showInCar,
      'carTabs': nextTabs,
    };
    await preferences.setString(key, jsonEncode(next));
    theme = themeMode ?? theme;
    language = locale ?? language;
    listSeconds = listInterval ?? listSeconds;
    detailSeconds = detailInterval ?? detailSeconds;
    speechRate = rate ?? speechRate;
    showInCar = car ?? showInCar;
    carTabs = List.of(nextTabs);
    notifyListeners();
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\settings\settings_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../l10n/app_localizations.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool saving = false;
  Future<void> save(Future<void> Function() operation) async {
    if (saving) {
      return;
    }
    setState(() => saving = true);
    try {
      await operation();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.saveError)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final text = AppLocalizations.of(context)!;
    final names = {
      'live': text.live,
      'upcoming': text.upcoming,
      'results': text.results,
      'mine': text.myMatches,
    };
    final intervals = {
      30: text.seconds30,
      60: text.minute1,
      120: text.minutes2,
      300: text.minutes5,
    };
    return ListenableBuilder(
      listenable: settings,
      builder: (context, child) => AbsorbPointer(
        absorbing: saving,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (saving) const LinearProgressIndicator(),
            DropdownButtonFormField<ThemeMode>(
              key: ValueKey(settings.theme),
              initialValue: settings.theme,
              isExpanded: true,
              decoration: InputDecoration(labelText: text.theme),
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(text.system),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(text.light),
                ),
                DropdownMenuItem(value: ThemeMode.dark, child: Text(text.dark)),
              ],
              onChanged: (v) => save(() => settings.update(themeMode: v)),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              key: ValueKey(settings.language),
              initialValue: settings.language,
              isExpanded: true,
              decoration: InputDecoration(labelText: text.language),
              items: [
                DropdownMenuItem(value: 'system', child: Text(text.system)),
                const DropdownMenuItem(value: 'en', child: Text('English')),
                const DropdownMenuItem(value: 'hi', child: Text('हिन्दी')),
              ],
              onChanged: (v) => save(() => settings.update(locale: v)),
            ),
            const SizedBox(height: 16),
            for (final list in [true, false])
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DropdownButtonFormField<int>(
                  key: ValueKey(
                    '${list}_${list ? settings.listSeconds : settings.detailSeconds}',
                  ),
                  initialValue: list
                      ? settings.listSeconds
                      : settings.detailSeconds,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: list ? text.listRefresh : text.detailRefresh,
                  ),
                  items: [
                    for (final seconds
                        in list ? [30, 60, 120, 300] : [30, 60, 120])
                      DropdownMenuItem(
                        value: seconds,
                        child: Text(intervals[seconds]!),
                      ),
                  ],
                  onChanged: (v) => save(
                    () => list
                        ? settings.update(listInterval: v)
                        : settings.update(detailInterval: v),
                  ),
                ),
              ),
            Text(
              text.speechRate,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: settings.speechRate,
              min: 0.2,
              max: 1,
              divisions: 8,
              label: settings.speechRate.toStringAsFixed(1),
              onChanged: (v) => save(() => settings.update(rate: v)),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(text.voice),
              subtitle: Text('${text.systemVoice}\n${text.voiceNote}'),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(text.showInCar),
              value: settings.showInCar,
              onChanged: (v) => save(() => settings.update(car: v)),
            ),
            Text(text.carTabs, style: Theme.of(context).textTheme.titleMedium),
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: settings.carTabs.length,
              onReorderItem: (oldIndex, newIndex) {
                final tabs = List<String>.of(settings.carTabs);
                tabs.insert(newIndex, tabs.removeAt(oldIndex));
                save(() => settings.update(tabs: tabs));
              },
              itemBuilder: (context, index) => ListTile(
                key: ValueKey(settings.carTabs[index]),
                title: Text(names[settings.carTabs[index]]!),
                leading: IconButton(
                  tooltip: text.carTabs,
                  icon: const Icon(Icons.check_box),
                  onPressed: () {
                    if (settings.carTabs.length == 1) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(text.atLeastOne)));
                      return;
                    }
                    save(
                      () => settings.update(
                        tabs: List.of(settings.carTabs)..removeAt(index),
                      ),
                    );
                  },
                ),
              ),
            ),
            for (final id in SettingsController.allTabs.where(
              (id) => !settings.carTabs.contains(id),
            ))
              CheckboxListTile(
                title: Text(names[id]!),
                value: false,
                onChanged: (_) => save(
                  () => settings.update(tabs: [...settings.carTabs, id]),
                ),
              ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: ref.read(authProvider).signOut,
              icon: const Icon(Icons.logout),
              label: Text(text.signOut),
            ),
          ],
        ),
      ),
    );
  }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_localizations.dart

```dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'CP Drive'**
  String get appTitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Your cricket, wherever you go.'**
  String get welcome;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Unable to sign in. Check your credentials and connection.'**
  String get loginError;

  /// No description provided for @configurationError.
  ///
  /// In en, this message translates to:
  /// **'Set CP_API_BASE_URL and CP_LOGIN_ENDPOINT before signing in.'**
  String get configurationError;

  /// No description provided for @sessionError.
  ///
  /// In en, this message translates to:
  /// **'Secure storage is unavailable. Please restart the app.'**
  String get sessionError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @homeMessage.
  ///
  /// In en, this message translates to:
  /// **'Signed in. Match browsing arrives in Phase 2.'**
  String get homeMessage;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @browser.
  ///
  /// In en, this message translates to:
  /// **'Browser'**
  String get browser;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @myMatches.
  ///
  /// In en, this message translates to:
  /// **'My Matches'**
  String get myMatches;

  /// No description provided for @noLive.
  ///
  /// In en, this message translates to:
  /// **'No live matches right now'**
  String get noLive;

  /// No description provided for @noUpcoming.
  ///
  /// In en, this message translates to:
  /// **'No upcoming matches'**
  String get noUpcoming;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results yet'**
  String get noResults;

  /// No description provided for @noMine.
  ///
  /// In en, this message translates to:
  /// **'No matches found for your account'**
  String get noMine;

  /// No description provided for @loadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load matches. Try again.'**
  String get loadError;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Connection unavailable. Showing the last successful update.'**
  String get offline;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @listRefresh.
  ///
  /// In en, this message translates to:
  /// **'Match list refresh'**
  String get listRefresh;

  /// No description provided for @detailRefresh.
  ///
  /// In en, this message translates to:
  /// **'Match details refresh'**
  String get detailRefresh;

  /// No description provided for @seconds30.
  ///
  /// In en, this message translates to:
  /// **'30 seconds'**
  String get seconds30;

  /// No description provided for @minute1.
  ///
  /// In en, this message translates to:
  /// **'1 minute'**
  String get minute1;

  /// No description provided for @minutes2.
  ///
  /// In en, this message translates to:
  /// **'2 minutes'**
  String get minutes2;

  /// No description provided for @minutes5.
  ///
  /// In en, this message translates to:
  /// **'5 minutes'**
  String get minutes5;

  /// No description provided for @speechRate.
  ///
  /// In en, this message translates to:
  /// **'Commentary speech rate'**
  String get speechRate;

  /// No description provided for @voice.
  ///
  /// In en, this message translates to:
  /// **'Commentary voice'**
  String get voice;

  /// No description provided for @systemVoice.
  ///
  /// In en, this message translates to:
  /// **'System voice for app language'**
  String get systemVoice;

  /// No description provided for @voiceNote.
  ///
  /// In en, this message translates to:
  /// **'Installed voices will be available when audio is added in Phase 5.'**
  String get voiceNote;

  /// No description provided for @showInCar.
  ///
  /// In en, this message translates to:
  /// **'Show in car'**
  String get showInCar;

  /// No description provided for @carTabs.
  ///
  /// In en, this message translates to:
  /// **'Car tabs — drag to reorder'**
  String get carTabs;

  /// No description provided for @atLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Keep at least one car tab enabled.'**
  String get atLeastOne;

  /// No description provided for @saveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save settings. Please try again.'**
  String get saveError;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Match details'**
  String get details;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @toss.
  ///
  /// In en, this message translates to:
  /// **'Toss'**
  String get toss;

  /// No description provided for @format.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get format;

  /// No description provided for @tournament.
  ///
  /// In en, this message translates to:
  /// **'Tournament'**
  String get tournament;

  /// No description provided for @round.
  ///
  /// In en, this message translates to:
  /// **'Round'**
  String get round;

  /// No description provided for @venue.
  ///
  /// In en, this message translates to:
  /// **'Venue'**
  String get venue;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date and time'**
  String get dateTime;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailable;

  /// No description provided for @listenLive.
  ///
  /// In en, this message translates to:
  /// **'Listen live'**
  String get listenLive;

  /// No description provided for @audioPhase.
  ///
  /// In en, this message translates to:
  /// **'Live audio will be available in Phase 5.'**
  String get audioPhase;

  /// No description provided for @miniPlayer.
  ///
  /// In en, this message translates to:
  /// **'Live commentary'**
  String get miniPlayer;

  /// No description provided for @galleryPhase.
  ///
  /// In en, this message translates to:
  /// **'Your photos and videos arrive in Phase 3.'**
  String get galleryPhase;

  /// No description provided for @browserPhase.
  ///
  /// In en, this message translates to:
  /// **'Browser tabs and bookmarks arrive in Phase 4.'**
  String get browserPhase;

  /// No description provided for @unavailableMatch.
  ///
  /// In en, this message translates to:
  /// **'Match details are unavailable.'**
  String get unavailableMatch;

  /// No description provided for @allMedia.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allMedia;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @albums.
  ///
  /// In en, this message translates to:
  /// **'Albums'**
  String get albums;

  /// No description provided for @galleryAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow photo and video access'**
  String get galleryAccess;

  /// No description provided for @galleryReason.
  ///
  /// In en, this message translates to:
  /// **'Browse, view, share and manage your photos and videos on this phone.'**
  String get galleryReason;

  /// No description provided for @allowAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow access'**
  String get allowAccess;

  /// No description provided for @galleryDenied.
  ///
  /// In en, this message translates to:
  /// **'Photo and video access is turned off.'**
  String get galleryDenied;

  /// No description provided for @galleryDeniedHint.
  ///
  /// In en, this message translates to:
  /// **'Open Settings to allow access to all or selected photos and videos.'**
  String get galleryDeniedHint;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @selectMore.
  ///
  /// In en, this message translates to:
  /// **'Select more photos and videos'**
  String get selectMore;

  /// No description provided for @limitedAccess.
  ///
  /// In en, this message translates to:
  /// **'Only your selected photos and videos are visible.'**
  String get limitedAccess;

  /// No description provided for @emptyGallery.
  ///
  /// In en, this message translates to:
  /// **'No photos or videos in this selection.'**
  String get emptyGallery;

  /// No description provided for @galleryError.
  ///
  /// In en, this message translates to:
  /// **'Could not load your gallery. Please try again.'**
  String get galleryError;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;

  /// No description provided for @mediaUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This item is unavailable. It may have been removed, or may need to download from the cloud.'**
  String get mediaUnavailable;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @deleteMedia.
  ///
  /// In en, this message translates to:
  /// **'Delete this item from your photo library?'**
  String get deleteMedia;

  /// No description provided for @deleteHint.
  ///
  /// In en, this message translates to:
  /// **'The system may ask you to confirm. This removes the item from the library, not just this album.'**
  String get deleteHint;

  /// No description provided for @actionFailed.
  ///
  /// In en, this message translates to:
  /// **'The action could not be completed.'**
  String get actionFailed;

  /// No description provided for @deleteCancelled.
  ///
  /// In en, this message translates to:
  /// **'No item was deleted.'**
  String get deleteCancelled;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @fileSize.
  ///
  /// In en, this message translates to:
  /// **'File size'**
  String get fileSize;

  /// No description provided for @resolution.
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get resolution;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @album.
  ///
  /// In en, this message translates to:
  /// **'Album'**
  String get album;

  /// No description provided for @filename.
  ///
  /// In en, this message translates to:
  /// **'File name'**
  String get filename;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @videoError.
  ///
  /// In en, this message translates to:
  /// **'Could not play this video.'**
  String get videoError;

  /// No description provided for @muted.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get muted;

  /// No description provided for @unmuted.
  ///
  /// In en, this message translates to:
  /// **'Unmute'**
  String get unmuted;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @fullscreen.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen'**
  String get fullscreen;

  /// No description provided for @previousItem.
  ///
  /// In en, this message translates to:
  /// **'Previous item'**
  String get previousItem;

  /// No description provided for @nextItem.
  ///
  /// In en, this message translates to:
  /// **'Next item'**
  String get nextItem;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Search or enter address'**
  String get addressHint;

  /// No description provided for @newTab.
  ///
  /// In en, this message translates to:
  /// **'New tab'**
  String get newTab;

  /// No description provided for @newPrivateTab.
  ///
  /// In en, this message translates to:
  /// **'New incognito tab'**
  String get newPrivateTab;

  /// No description provided for @tabs.
  ///
  /// In en, this message translates to:
  /// **'Tabs'**
  String get tabs;

  /// No description provided for @closeAllTabs.
  ///
  /// In en, this message translates to:
  /// **'Close all tabs'**
  String get closeAllTabs;

  /// No description provided for @incognito.
  ///
  /// In en, this message translates to:
  /// **'Incognito'**
  String get incognito;

  /// No description provided for @privateNote.
  ///
  /// In en, this message translates to:
  /// **'Private tabs leave no saved history or cookies. Downloads and bookmarks you choose to save remain. On Android, switching modes clears website sign-ins.'**
  String get privateNote;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloads;

  /// No description provided for @addBookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark this page'**
  String get addBookmark;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear all history'**
  String get clearHistory;

  /// No description provided for @clearConfirm.
  ///
  /// In en, this message translates to:
  /// **'Clear all browsing history?'**
  String get clearConfirm;

  /// No description provided for @noBookmarks.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get noBookmarks;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No browsing history'**
  String get noHistory;

  /// No description provided for @noDownloads.
  ///
  /// In en, this message translates to:
  /// **'No downloads yet'**
  String get noDownloads;

  /// No description provided for @findInPage.
  ///
  /// In en, this message translates to:
  /// **'Find in page'**
  String get findInPage;

  /// No description provided for @findHint.
  ///
  /// In en, this message translates to:
  /// **'Find text'**
  String get findHint;

  /// No description provided for @desktopSite.
  ///
  /// In en, this message translates to:
  /// **'Desktop site'**
  String get desktopSite;

  /// No description provided for @textZoom.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textZoom;

  /// No description provided for @openChrome.
  ///
  /// In en, this message translates to:
  /// **'Open in Chrome'**
  String get openChrome;

  /// No description provided for @openSafari.
  ///
  /// In en, this message translates to:
  /// **'Open in Safari'**
  String get openSafari;

  /// No description provided for @openExternal.
  ///
  /// In en, this message translates to:
  /// **'Open in default browser'**
  String get openExternal;

  /// No description provided for @customTab.
  ///
  /// In en, this message translates to:
  /// **'Open in Custom Tab'**
  String get customTab;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @forward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get forward;

  /// No description provided for @reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @notSecure.
  ///
  /// In en, this message translates to:
  /// **'Not secure'**
  String get notSecure;

  /// No description provided for @secureConnection.
  ///
  /// In en, this message translates to:
  /// **'HTTPS connection'**
  String get secureConnection;

  /// No description provided for @sslBlocked.
  ///
  /// In en, this message translates to:
  /// **'This page was blocked because its security certificate could not be verified.'**
  String get sslBlocked;

  /// No description provided for @pageError.
  ///
  /// In en, this message translates to:
  /// **'This page could not be loaded. Check your connection and try again.'**
  String get pageError;

  /// No description provided for @browserError.
  ///
  /// In en, this message translates to:
  /// **'Browser data could not be opened. Please try again.'**
  String get browserError;

  /// No description provided for @websitePermission.
  ///
  /// In en, this message translates to:
  /// **'Website permission'**
  String get websitePermission;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @microphone.
  ///
  /// In en, this message translates to:
  /// **'Microphone'**
  String get microphone;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @deny.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get deny;

  /// No description provided for @openApp.
  ///
  /// In en, this message translates to:
  /// **'Open this link in another app?'**
  String get openApp;

  /// No description provided for @downloadFile.
  ///
  /// In en, this message translates to:
  /// **'Download this file?'**
  String get downloadFile;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @downloadComplete.
  ///
  /// In en, this message translates to:
  /// **'Download complete'**
  String get downloadComplete;

  /// No description provided for @downloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Download failed or was interrupted'**
  String get downloadFailed;

  /// No description provided for @downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get downloading;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @deleteDownload.
  ///
  /// In en, this message translates to:
  /// **'Delete this downloaded file?'**
  String get deleteDownload;

  /// No description provided for @downloadHint.
  ///
  /// In en, this message translates to:
  /// **'This deletes the saved file and removes its entry.'**
  String get downloadHint;

  /// No description provided for @privateCleanup.
  ///
  /// In en, this message translates to:
  /// **'Clearing private browsing data'**
  String get privateCleanup;

  /// No description provided for @blankTab.
  ///
  /// In en, this message translates to:
  /// **'Search the web or enter a website address.'**
  String get blankTab;

  /// No description provided for @tabLimit.
  ///
  /// In en, this message translates to:
  /// **'Close a tab before opening another.'**
  String get tabLimit;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid HTTP or HTTPS address.'**
  String get invalidUrl;

  /// No description provided for @downloadUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This download cannot be saved. Try opening the page in your external browser.'**
  String get downloadUnsupported;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search history'**
  String get searchHistory;

  /// No description provided for @regularTabs.
  ///
  /// In en, this message translates to:
  /// **'Regular tabs'**
  String get regularTabs;

  /// No description provided for @privateTabs.
  ///
  /// In en, this message translates to:
  /// **'Private tabs'**
  String get privateTabs;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_localizations_en.dart

```dart
// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CP Drive';

  @override
  String get signIn => 'Sign in';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get requiredField => 'This field is required';

  @override
  String get welcome => 'Your cricket, wherever you go.';

  @override
  String get loginError =>
      'Unable to sign in. Check your credentials and connection.';

  @override
  String get configurationError =>
      'Set CP_API_BASE_URL and CP_LOGIN_ENDPOINT before signing in.';

  @override
  String get sessionError =>
      'Secure storage is unavailable. Please restart the app.';

  @override
  String get retry => 'Retry';

  @override
  String get signOut => 'Sign out';

  @override
  String get homeMessage => 'Signed in. Match browsing arrives in Phase 2.';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get matches => 'Matches';

  @override
  String get gallery => 'Gallery';

  @override
  String get browser => 'Browser';

  @override
  String get settings => 'Settings';

  @override
  String get live => 'Live';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get results => 'Results';

  @override
  String get myMatches => 'My Matches';

  @override
  String get noLive => 'No live matches right now';

  @override
  String get noUpcoming => 'No upcoming matches';

  @override
  String get noResults => 'No results yet';

  @override
  String get noMine => 'No matches found for your account';

  @override
  String get loadError => 'Could not load matches. Try again.';

  @override
  String get offline =>
      'Connection unavailable. Showing the last successful update.';

  @override
  String get refresh => 'Refresh';

  @override
  String get theme => 'Theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get listRefresh => 'Match list refresh';

  @override
  String get detailRefresh => 'Match details refresh';

  @override
  String get seconds30 => '30 seconds';

  @override
  String get minute1 => '1 minute';

  @override
  String get minutes2 => '2 minutes';

  @override
  String get minutes5 => '5 minutes';

  @override
  String get speechRate => 'Commentary speech rate';

  @override
  String get voice => 'Commentary voice';

  @override
  String get systemVoice => 'System voice for app language';

  @override
  String get voiceNote =>
      'Installed voices will be available when audio is added in Phase 5.';

  @override
  String get showInCar => 'Show in car';

  @override
  String get carTabs => 'Car tabs — drag to reorder';

  @override
  String get atLeastOne => 'Keep at least one car tab enabled.';

  @override
  String get saveError => 'Could not save settings. Please try again.';

  @override
  String get details => 'Match details';

  @override
  String get status => 'Status';

  @override
  String get result => 'Result';

  @override
  String get toss => 'Toss';

  @override
  String get format => 'Format';

  @override
  String get tournament => 'Tournament';

  @override
  String get round => 'Round';

  @override
  String get venue => 'Venue';

  @override
  String get dateTime => 'Date and time';

  @override
  String get notAvailable => 'Not available';

  @override
  String get listenLive => 'Listen live';

  @override
  String get audioPhase => 'Live audio will be available in Phase 5.';

  @override
  String get miniPlayer => 'Live commentary';

  @override
  String get galleryPhase => 'Your photos and videos arrive in Phase 3.';

  @override
  String get browserPhase => 'Browser tabs and bookmarks arrive in Phase 4.';

  @override
  String get unavailableMatch => 'Match details are unavailable.';

  @override
  String get allMedia => 'All';

  @override
  String get photos => 'Photos';

  @override
  String get videos => 'Videos';

  @override
  String get favorites => 'Favorites';

  @override
  String get albums => 'Albums';

  @override
  String get galleryAccess => 'Allow photo and video access';

  @override
  String get galleryReason =>
      'Browse, view, share and manage your photos and videos on this phone.';

  @override
  String get allowAccess => 'Allow access';

  @override
  String get galleryDenied => 'Photo and video access is turned off.';

  @override
  String get galleryDeniedHint =>
      'Open Settings to allow access to all or selected photos and videos.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get selectMore => 'Select more photos and videos';

  @override
  String get limitedAccess =>
      'Only your selected photos and videos are visible.';

  @override
  String get emptyGallery => 'No photos or videos in this selection.';

  @override
  String get galleryError => 'Could not load your gallery. Please try again.';

  @override
  String get loadMore => 'Load more';

  @override
  String get mediaUnavailable =>
      'This item is unavailable. It may have been removed, or may need to download from the cloud.';

  @override
  String get share => 'Share';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get info => 'Info';

  @override
  String get deleteMedia => 'Delete this item from your photo library?';

  @override
  String get deleteHint =>
      'The system may ask you to confirm. This removes the item from the library, not just this album.';

  @override
  String get actionFailed => 'The action could not be completed.';

  @override
  String get deleteCancelled => 'No item was deleted.';

  @override
  String get created => 'Created';

  @override
  String get fileSize => 'File size';

  @override
  String get resolution => 'Resolution';

  @override
  String get duration => 'Duration';

  @override
  String get album => 'Album';

  @override
  String get filename => 'File name';

  @override
  String get close => 'Close';

  @override
  String get videoError => 'Could not play this video.';

  @override
  String get muted => 'Mute';

  @override
  String get unmuted => 'Unmute';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get fullscreen => 'Fullscreen';

  @override
  String get previousItem => 'Previous item';

  @override
  String get nextItem => 'Next item';

  @override
  String get addressHint => 'Search or enter address';

  @override
  String get newTab => 'New tab';

  @override
  String get newPrivateTab => 'New incognito tab';

  @override
  String get tabs => 'Tabs';

  @override
  String get closeAllTabs => 'Close all tabs';

  @override
  String get incognito => 'Incognito';

  @override
  String get privateNote =>
      'Private tabs leave no saved history or cookies. Downloads and bookmarks you choose to save remain. On Android, switching modes clears website sign-ins.';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get history => 'History';

  @override
  String get downloads => 'Downloads';

  @override
  String get addBookmark => 'Bookmark this page';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get title => 'Title';

  @override
  String get url => 'URL';

  @override
  String get clearHistory => 'Clear all history';

  @override
  String get clearConfirm => 'Clear all browsing history?';

  @override
  String get noBookmarks => 'No bookmarks yet';

  @override
  String get noHistory => 'No browsing history';

  @override
  String get noDownloads => 'No downloads yet';

  @override
  String get findInPage => 'Find in page';

  @override
  String get findHint => 'Find text';

  @override
  String get desktopSite => 'Desktop site';

  @override
  String get textZoom => 'Text size';

  @override
  String get openChrome => 'Open in Chrome';

  @override
  String get openSafari => 'Open in Safari';

  @override
  String get openExternal => 'Open in default browser';

  @override
  String get customTab => 'Open in Custom Tab';

  @override
  String get back => 'Back';

  @override
  String get forward => 'Forward';

  @override
  String get reload => 'Reload';

  @override
  String get stop => 'Stop';

  @override
  String get notSecure => 'Not secure';

  @override
  String get secureConnection => 'HTTPS connection';

  @override
  String get sslBlocked =>
      'This page was blocked because its security certificate could not be verified.';

  @override
  String get pageError =>
      'This page could not be loaded. Check your connection and try again.';

  @override
  String get browserError =>
      'Browser data could not be opened. Please try again.';

  @override
  String get websitePermission => 'Website permission';

  @override
  String get camera => 'Camera';

  @override
  String get microphone => 'Microphone';

  @override
  String get allow => 'Allow';

  @override
  String get deny => 'Deny';

  @override
  String get openApp => 'Open this link in another app?';

  @override
  String get downloadFile => 'Download this file?';

  @override
  String get download => 'Download';

  @override
  String get downloadComplete => 'Download complete';

  @override
  String get downloadFailed => 'Download failed or was interrupted';

  @override
  String get downloading => 'Downloading';

  @override
  String get open => 'Open';

  @override
  String get deleteDownload => 'Delete this downloaded file?';

  @override
  String get downloadHint =>
      'This deletes the saved file and removes its entry.';

  @override
  String get privateCleanup => 'Clearing private browsing data';

  @override
  String get blankTab => 'Search the web or enter a website address.';

  @override
  String get tabLimit => 'Close a tab before opening another.';

  @override
  String get invalidUrl => 'Enter a valid HTTP or HTTPS address.';

  @override
  String get downloadUnsupported =>
      'This download cannot be saved. Try opening the page in your external browser.';

  @override
  String get searchHistory => 'Search history';

  @override
  String get regularTabs => 'Regular tabs';

  @override
  String get privateTabs => 'Private tabs';
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_localizations_hi.dart

```dart
// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'CP Drive';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get username => 'उपयोगकर्ता नाम';

  @override
  String get password => 'पासवर्ड';

  @override
  String get requiredField => 'यह फ़ील्ड आवश्यक है';

  @override
  String get welcome => 'आपका क्रिकेट, हर सफ़र में।';

  @override
  String get loginError => 'साइन इन नहीं हुआ। जानकारी और कनेक्शन जाँचें।';

  @override
  String get configurationError =>
      'साइन इन से पहले CP_API_BASE_URL और CP_LOGIN_ENDPOINT सेट करें।';

  @override
  String get sessionError =>
      'सुरक्षित स्टोरेज उपलब्ध नहीं है। ऐप पुनः शुरू करें।';

  @override
  String get retry => 'फिर प्रयास करें';

  @override
  String get signOut => 'साइन आउट';

  @override
  String get homeMessage => 'साइन इन हो गया। मैच ब्राउज़िंग चरण 2 में आएगी।';

  @override
  String get showPassword => 'पासवर्ड दिखाएँ';

  @override
  String get hidePassword => 'पासवर्ड छिपाएँ';

  @override
  String get matches => 'मैच';

  @override
  String get gallery => 'गैलरी';

  @override
  String get browser => 'ब्राउज़र';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get live => 'लाइव';

  @override
  String get upcoming => 'आगामी';

  @override
  String get results => 'परिणाम';

  @override
  String get myMatches => 'मेरे मैच';

  @override
  String get noLive => 'अभी कोई लाइव मैच नहीं है';

  @override
  String get noUpcoming => 'कोई आगामी मैच नहीं है';

  @override
  String get noResults => 'अभी कोई परिणाम नहीं है';

  @override
  String get noMine => 'आपके खाते के लिए कोई मैच नहीं मिला';

  @override
  String get loadError => 'मैच लोड नहीं हुए। फिर प्रयास करें।';

  @override
  String get offline =>
      'कनेक्शन उपलब्ध नहीं है। अंतिम सफल अपडेट दिखाया जा रहा है।';

  @override
  String get refresh => 'रीफ़्रेश';

  @override
  String get theme => 'थीम';

  @override
  String get system => 'सिस्टम';

  @override
  String get light => 'हल्की';

  @override
  String get dark => 'गहरी';

  @override
  String get language => 'भाषा';

  @override
  String get listRefresh => 'मैच सूची रीफ़्रेश';

  @override
  String get detailRefresh => 'मैच विवरण रीफ़्रेश';

  @override
  String get seconds30 => '30 सेकंड';

  @override
  String get minute1 => '1 मिनट';

  @override
  String get minutes2 => '2 मिनट';

  @override
  String get minutes5 => '5 मिनट';

  @override
  String get speechRate => 'कमेंट्री बोलने की गति';

  @override
  String get voice => 'कमेंट्री की आवाज़';

  @override
  String get systemVoice => 'ऐप की भाषा की सिस्टम आवाज़';

  @override
  String get voiceNote =>
      'चरण 5 में ऑडियो जुड़ने पर स्थापित आवाज़ें उपलब्ध होंगी।';

  @override
  String get showInCar => 'कार में दिखाएँ';

  @override
  String get carTabs => 'कार टैब — क्रम बदलने के लिए खींचें';

  @override
  String get atLeastOne => 'कम से कम एक कार टैब चालू रखें।';

  @override
  String get saveError => 'सेटिंग्स सेव नहीं हुईं। फिर प्रयास करें।';

  @override
  String get details => 'मैच विवरण';

  @override
  String get status => 'स्थिति';

  @override
  String get result => 'परिणाम';

  @override
  String get toss => 'टॉस';

  @override
  String get format => 'प्रारूप';

  @override
  String get tournament => 'टूर्नामेंट';

  @override
  String get round => 'राउंड';

  @override
  String get venue => 'मैदान';

  @override
  String get dateTime => 'तारीख और समय';

  @override
  String get notAvailable => 'उपलब्ध नहीं';

  @override
  String get listenLive => 'लाइव सुनें';

  @override
  String get audioPhase => 'लाइव ऑडियो चरण 5 में उपलब्ध होगा।';

  @override
  String get miniPlayer => 'लाइव कमेंट्री';

  @override
  String get galleryPhase => 'आपकी फ़ोटो और वीडियो चरण 3 में आएँगे।';

  @override
  String get browserPhase => 'ब्राउज़र टैब और बुकमार्क चरण 4 में आएँगे।';

  @override
  String get unavailableMatch => 'मैच विवरण उपलब्ध नहीं है।';

  @override
  String get allMedia => 'सभी';

  @override
  String get photos => 'फ़ोटो';

  @override
  String get videos => 'वीडियो';

  @override
  String get favorites => 'पसंदीदा';

  @override
  String get albums => 'एल्बम';

  @override
  String get galleryAccess => 'फ़ोटो और वीडियो की अनुमति दें';

  @override
  String get galleryReason =>
      'इस फ़ोन की फ़ोटो और वीडियो देखें, साझा करें और प्रबंधित करें।';

  @override
  String get allowAccess => 'अनुमति दें';

  @override
  String get galleryDenied => 'फ़ोटो और वीडियो की अनुमति बंद है।';

  @override
  String get galleryDeniedHint =>
      'सभी या चुनी हुई फ़ोटो और वीडियो की अनुमति देने के लिए सेटिंग्स खोलें।';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get selectMore => 'और फ़ोटो और वीडियो चुनें';

  @override
  String get limitedAccess => 'केवल आपकी चुनी हुई फ़ोटो और वीडियो दिख रही हैं।';

  @override
  String get emptyGallery => 'इस चयन में कोई फ़ोटो या वीडियो नहीं है।';

  @override
  String get galleryError => 'गैलरी लोड नहीं हुई। फिर प्रयास करें।';

  @override
  String get loadMore => 'और लोड करें';

  @override
  String get mediaUnavailable =>
      'यह आइटम उपलब्ध नहीं है। इसे हटाया गया हो सकता है या क्लाउड से डाउनलोड आवश्यक हो सकता है।';

  @override
  String get share => 'साझा करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get info => 'जानकारी';

  @override
  String get deleteMedia => 'इस आइटम को फ़ोटो लाइब्रेरी से हटाएँ?';

  @override
  String get deleteHint =>
      'सिस्टम पुष्टि माँग सकता है। यह आइटम केवल इस एल्बम से नहीं, पूरी लाइब्रेरी से हटेगा।';

  @override
  String get actionFailed => 'कार्रवाई पूरी नहीं हुई।';

  @override
  String get deleteCancelled => 'कोई आइटम नहीं हटाया गया।';

  @override
  String get created => 'बनाया गया';

  @override
  String get fileSize => 'फ़ाइल का आकार';

  @override
  String get resolution => 'रिज़ॉल्यूशन';

  @override
  String get duration => 'अवधि';

  @override
  String get album => 'एल्बम';

  @override
  String get filename => 'फ़ाइल का नाम';

  @override
  String get close => 'बंद करें';

  @override
  String get videoError => 'यह वीडियो नहीं चला।';

  @override
  String get muted => 'आवाज़ बंद करें';

  @override
  String get unmuted => 'आवाज़ चालू करें';

  @override
  String get play => 'चलाएँ';

  @override
  String get pause => 'रोकें';

  @override
  String get fullscreen => 'पूरी स्क्रीन';

  @override
  String get previousItem => 'पिछला आइटम';

  @override
  String get nextItem => 'अगला आइटम';

  @override
  String get addressHint => 'खोजें या पता दर्ज करें';

  @override
  String get newTab => 'नया टैब';

  @override
  String get newPrivateTab => 'नया निजी टैब';

  @override
  String get tabs => 'टैब';

  @override
  String get closeAllTabs => 'सभी टैब बंद करें';

  @override
  String get incognito => 'निजी मोड';

  @override
  String get privateNote =>
      'निजी टैब का इतिहास या कुकी सेव नहीं होता। चुने हुए डाउनलोड और बुकमार्क रहते हैं। Android पर मोड बदलने से वेबसाइट साइन-इन साफ़ हो जाते हैं।';

  @override
  String get bookmarks => 'बुकमार्क';

  @override
  String get history => 'इतिहास';

  @override
  String get downloads => 'डाउनलोड';

  @override
  String get addBookmark => 'पेज बुकमार्क करें';

  @override
  String get edit => 'बदलें';

  @override
  String get save => 'सेव करें';

  @override
  String get title => 'शीर्षक';

  @override
  String get url => 'यूआरएल';

  @override
  String get clearHistory => 'पूरा इतिहास साफ़ करें';

  @override
  String get clearConfirm => 'पूरा ब्राउज़िंग इतिहास साफ़ करें?';

  @override
  String get noBookmarks => 'अभी कोई बुकमार्क नहीं है';

  @override
  String get noHistory => 'कोई ब्राउज़िंग इतिहास नहीं है';

  @override
  String get noDownloads => 'अभी कोई डाउनलोड नहीं है';

  @override
  String get findInPage => 'पेज में खोजें';

  @override
  String get findHint => 'टेक्स्ट खोजें';

  @override
  String get desktopSite => 'डेस्कटॉप साइट';

  @override
  String get textZoom => 'टेक्स्ट का आकार';

  @override
  String get openChrome => 'Chrome में खोलें';

  @override
  String get openSafari => 'Safari में खोलें';

  @override
  String get openExternal => 'डिफ़ॉल्ट ब्राउज़र में खोलें';

  @override
  String get customTab => 'कस्टम टैब में खोलें';

  @override
  String get back => 'पीछे';

  @override
  String get forward => 'आगे';

  @override
  String get reload => 'फिर लोड करें';

  @override
  String get stop => 'रोकें';

  @override
  String get notSecure => 'सुरक्षित नहीं';

  @override
  String get secureConnection => 'HTTPS कनेक्शन';

  @override
  String get sslBlocked =>
      'सुरक्षा प्रमाणपत्र सत्यापित न होने के कारण पेज ब्लॉक किया गया।';

  @override
  String get pageError =>
      'पेज लोड नहीं हुआ। कनेक्शन जाँचें और फिर प्रयास करें।';

  @override
  String get browserError => 'ब्राउज़र डेटा नहीं खुला। फिर प्रयास करें।';

  @override
  String get websitePermission => 'वेबसाइट की अनुमति';

  @override
  String get camera => 'कैमरा';

  @override
  String get microphone => 'माइक्रोफ़ोन';

  @override
  String get allow => 'अनुमति दें';

  @override
  String get deny => 'मना करें';

  @override
  String get openApp => 'लिंक दूसरे ऐप में खोलें?';

  @override
  String get downloadFile => 'यह फ़ाइल डाउनलोड करें?';

  @override
  String get download => 'डाउनलोड करें';

  @override
  String get downloadComplete => 'डाउनलोड पूरा हुआ';

  @override
  String get downloadFailed => 'डाउनलोड विफल हुआ या बाधित हुआ';

  @override
  String get downloading => 'डाउनलोड हो रहा है';

  @override
  String get open => 'खोलें';

  @override
  String get deleteDownload => 'डाउनलोड की हुई फ़ाइल हटाएँ?';

  @override
  String get downloadHint => 'यह सेव की हुई फ़ाइल और उसकी प्रविष्टि हटाता है।';

  @override
  String get privateCleanup => 'निजी ब्राउज़िंग डेटा साफ़ हो रहा है';

  @override
  String get blankTab => 'वेब पर खोजें या वेबसाइट का पता दर्ज करें।';

  @override
  String get tabLimit => 'नया टैब खोलने से पहले एक टैब बंद करें।';

  @override
  String get invalidUrl => 'सही HTTP या HTTPS पता दर्ज करें।';

  @override
  String get downloadUnsupported =>
      'यह डाउनलोड सेव नहीं हो सकता। पेज बाहरी ब्राउज़र में खोलकर देखें।';

  @override
  String get searchHistory => 'इतिहास खोजें';

  @override
  String get regularTabs => 'सामान्य टैब';

  @override
  String get privateTabs => 'निजी टैब';
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'features/settings/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsController(SharedPreferencesAsync());
  try {
    await settings.load();
  } catch (_) {
    /* Storage unavailable: retain defaults. */
  }
  runApp(
    ProviderScope(
      overrides: [settingsProvider.overrideWithValue(settings)],
      child: const CPDriveApp(),
    ),
  );
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_en.arb

```json
{
  "@@locale": "en",
  "appTitle": "CP Drive",
  "signIn": "Sign in",
  "username": "Username",
  "password": "Password",
  "requiredField": "This field is required",
  "welcome": "Your cricket, wherever you go.",
  "loginError": "Unable to sign in. Check your credentials and connection.",
  "configurationError": "Set CP_API_BASE_URL and CP_LOGIN_ENDPOINT before signing in.",
  "sessionError": "Secure storage is unavailable. Please restart the app.",
  "retry": "Retry",
  "signOut": "Sign out",
  "homeMessage": "Signed in. Match browsing arrives in Phase 2.",
  "showPassword": "Show password",
  "hidePassword": "Hide password",
  "matches": "Matches",
  "gallery": "Gallery",
  "browser": "Browser",
  "settings": "Settings",
  "live": "Live",
  "upcoming": "Upcoming",
  "results": "Results",
  "myMatches": "My Matches",
  "noLive": "No live matches right now",
  "noUpcoming": "No upcoming matches",
  "noResults": "No results yet",
  "noMine": "No matches found for your account",
  "loadError": "Could not load matches. Try again.",
  "offline": "Connection unavailable. Showing the last successful update.",
  "refresh": "Refresh",
  "theme": "Theme",
  "system": "System",
  "light": "Light",
  "dark": "Dark",
  "language": "Language",
  "listRefresh": "Match list refresh",
  "detailRefresh": "Match details refresh",
  "seconds30": "30 seconds",
  "minute1": "1 minute",
  "minutes2": "2 minutes",
  "minutes5": "5 minutes",
  "speechRate": "Commentary speech rate",
  "voice": "Commentary voice",
  "systemVoice": "System voice for app language",
  "voiceNote": "Installed voices will be available when audio is added in Phase 5.",
  "showInCar": "Show in car",
  "carTabs": "Car tabs — drag to reorder",
  "atLeastOne": "Keep at least one car tab enabled.",
  "saveError": "Could not save settings. Please try again.",
  "details": "Match details",
  "status": "Status",
  "result": "Result",
  "toss": "Toss",
  "format": "Format",
  "tournament": "Tournament",
  "round": "Round",
  "venue": "Venue",
  "dateTime": "Date and time",
  "notAvailable": "Not available",
  "listenLive": "Listen live",
  "audioPhase": "Live audio will be available in Phase 5.",
  "miniPlayer": "Live commentary",
  "galleryPhase": "Your photos and videos arrive in Phase 3.",
  "browserPhase": "Browser tabs and bookmarks arrive in Phase 4.",
  "unavailableMatch": "Match details are unavailable.",
  "allMedia": "All",
  "photos": "Photos",
  "videos": "Videos",
  "favorites": "Favorites",
  "albums": "Albums",
  "galleryAccess": "Allow photo and video access",
  "galleryReason": "Browse, view, share and manage your photos and videos on this phone.",
  "allowAccess": "Allow access",
  "galleryDenied": "Photo and video access is turned off.",
  "galleryDeniedHint": "Open Settings to allow access to all or selected photos and videos.",
  "openSettings": "Open Settings",
  "selectMore": "Select more photos and videos",
  "limitedAccess": "Only your selected photos and videos are visible.",
  "emptyGallery": "No photos or videos in this selection.",
  "galleryError": "Could not load your gallery. Please try again.",
  "loadMore": "Load more",
  "mediaUnavailable": "This item is unavailable. It may have been removed, or may need to download from the cloud.",
  "share": "Share",
  "delete": "Delete",
  "cancel": "Cancel",
  "info": "Info",
  "deleteMedia": "Delete this item from your photo library?",
  "deleteHint": "The system may ask you to confirm. This removes the item from the library, not just this album.",
  "actionFailed": "The action could not be completed.",
  "deleteCancelled": "No item was deleted.",
  "created": "Created",
  "fileSize": "File size",
  "resolution": "Resolution",
  "duration": "Duration",
  "album": "Album",
  "filename": "File name",
  "close": "Close",
  "videoError": "Could not play this video.",
  "muted": "Mute",
  "unmuted": "Unmute",
  "play": "Play",
  "pause": "Pause",
  "fullscreen": "Fullscreen",
  "previousItem": "Previous item",
  "nextItem": "Next item",
  "addressHint": "Search or enter address",
  "newTab": "New tab",
  "newPrivateTab": "New incognito tab",
  "tabs": "Tabs",
  "closeAllTabs": "Close all tabs",
  "incognito": "Incognito",
  "privateNote": "Private tabs leave no saved history or cookies. Downloads and bookmarks you choose to save remain. On Android, switching modes clears website sign-ins.",
  "bookmarks": "Bookmarks",
  "history": "History",
  "downloads": "Downloads",
  "addBookmark": "Bookmark this page",
  "edit": "Edit",
  "save": "Save",
  "title": "Title",
  "url": "URL",
  "clearHistory": "Clear all history",
  "clearConfirm": "Clear all browsing history?",
  "noBookmarks": "No bookmarks yet",
  "noHistory": "No browsing history",
  "noDownloads": "No downloads yet",
  "findInPage": "Find in page",
  "findHint": "Find text",
  "desktopSite": "Desktop site",
  "textZoom": "Text size",
  "openChrome": "Open in Chrome",
  "openSafari": "Open in Safari",
  "openExternal": "Open in default browser",
  "customTab": "Open in Custom Tab",
  "back": "Back",
  "forward": "Forward",
  "reload": "Reload",
  "stop": "Stop",
  "notSecure": "Not secure",
  "secureConnection": "HTTPS connection",
  "sslBlocked": "This page was blocked because its security certificate could not be verified.",
  "pageError": "This page could not be loaded. Check your connection and try again.",
  "browserError": "Browser data could not be opened. Please try again.",
  "websitePermission": "Website permission",
  "camera": "Camera",
  "microphone": "Microphone",
  "allow": "Allow",
  "deny": "Deny",
  "openApp": "Open this link in another app?",
  "downloadFile": "Download this file?",
  "download": "Download",
  "downloadComplete": "Download complete",
  "downloadFailed": "Download failed or was interrupted",
  "downloading": "Downloading",
  "open": "Open",
  "deleteDownload": "Delete this downloaded file?",
  "downloadHint": "This deletes the saved file and removes its entry.",
  "privateCleanup": "Clearing private browsing data",
  "blankTab": "Search the web or enter a website address.",
  "tabLimit": "Close a tab before opening another.",
  "invalidUrl": "Enter a valid HTTP or HTTPS address.",
  "downloadUnsupported": "This download cannot be saved. Try opening the page in your external browser.",
  "searchHistory": "Search history",
  "regularTabs": "Regular tabs",
  "privateTabs": "Private tabs"
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_hi.arb

```json
{
  "@@locale": "hi",
  "appTitle": "CP Drive",
  "signIn": "साइन इन करें",
  "username": "उपयोगकर्ता नाम",
  "password": "पासवर्ड",
  "requiredField": "यह फ़ील्ड आवश्यक है",
  "welcome": "आपका क्रिकेट, हर सफ़र में।",
  "loginError": "साइन इन नहीं हुआ। जानकारी और कनेक्शन जाँचें।",
  "configurationError": "साइन इन से पहले CP_API_BASE_URL और CP_LOGIN_ENDPOINT सेट करें।",
  "sessionError": "सुरक्षित स्टोरेज उपलब्ध नहीं है। ऐप पुनः शुरू करें।",
  "retry": "फिर प्रयास करें",
  "signOut": "साइन आउट",
  "homeMessage": "साइन इन हो गया। मैच ब्राउज़िंग चरण 2 में आएगी।",
  "showPassword": "पासवर्ड दिखाएँ",
  "hidePassword": "पासवर्ड छिपाएँ",
  "matches": "मैच",
  "gallery": "गैलरी",
  "browser": "ब्राउज़र",
  "settings": "सेटिंग्स",
  "live": "लाइव",
  "upcoming": "आगामी",
  "results": "परिणाम",
  "myMatches": "मेरे मैच",
  "noLive": "अभी कोई लाइव मैच नहीं है",
  "noUpcoming": "कोई आगामी मैच नहीं है",
  "noResults": "अभी कोई परिणाम नहीं है",
  "noMine": "आपके खाते के लिए कोई मैच नहीं मिला",
  "loadError": "मैच लोड नहीं हुए। फिर प्रयास करें।",
  "offline": "कनेक्शन उपलब्ध नहीं है। अंतिम सफल अपडेट दिखाया जा रहा है।",
  "refresh": "रीफ़्रेश",
  "theme": "थीम",
  "system": "सिस्टम",
  "light": "हल्की",
  "dark": "गहरी",
  "language": "भाषा",
  "listRefresh": "मैच सूची रीफ़्रेश",
  "detailRefresh": "मैच विवरण रीफ़्रेश",
  "seconds30": "30 सेकंड",
  "minute1": "1 मिनट",
  "minutes2": "2 मिनट",
  "minutes5": "5 मिनट",
  "speechRate": "कमेंट्री बोलने की गति",
  "voice": "कमेंट्री की आवाज़",
  "systemVoice": "ऐप की भाषा की सिस्टम आवाज़",
  "voiceNote": "चरण 5 में ऑडियो जुड़ने पर स्थापित आवाज़ें उपलब्ध होंगी।",
  "showInCar": "कार में दिखाएँ",
  "carTabs": "कार टैब — क्रम बदलने के लिए खींचें",
  "atLeastOne": "कम से कम एक कार टैब चालू रखें।",
  "saveError": "सेटिंग्स सेव नहीं हुईं। फिर प्रयास करें।",
  "details": "मैच विवरण",
  "status": "स्थिति",
  "result": "परिणाम",
  "toss": "टॉस",
  "format": "प्रारूप",
  "tournament": "टूर्नामेंट",
  "round": "राउंड",
  "venue": "मैदान",
  "dateTime": "तारीख और समय",
  "notAvailable": "उपलब्ध नहीं",
  "listenLive": "लाइव सुनें",
  "audioPhase": "लाइव ऑडियो चरण 5 में उपलब्ध होगा।",
  "miniPlayer": "लाइव कमेंट्री",
  "galleryPhase": "आपकी फ़ोटो और वीडियो चरण 3 में आएँगे।",
  "browserPhase": "ब्राउज़र टैब और बुकमार्क चरण 4 में आएँगे।",
  "unavailableMatch": "मैच विवरण उपलब्ध नहीं है।",
  "allMedia": "सभी",
  "photos": "फ़ोटो",
  "videos": "वीडियो",
  "favorites": "पसंदीदा",
  "albums": "एल्बम",
  "galleryAccess": "फ़ोटो और वीडियो की अनुमति दें",
  "galleryReason": "इस फ़ोन की फ़ोटो और वीडियो देखें, साझा करें और प्रबंधित करें।",
  "allowAccess": "अनुमति दें",
  "galleryDenied": "फ़ोटो और वीडियो की अनुमति बंद है।",
  "galleryDeniedHint": "सभी या चुनी हुई फ़ोटो और वीडियो की अनुमति देने के लिए सेटिंग्स खोलें।",
  "openSettings": "सेटिंग्स खोलें",
  "selectMore": "और फ़ोटो और वीडियो चुनें",
  "limitedAccess": "केवल आपकी चुनी हुई फ़ोटो और वीडियो दिख रही हैं।",
  "emptyGallery": "इस चयन में कोई फ़ोटो या वीडियो नहीं है।",
  "galleryError": "गैलरी लोड नहीं हुई। फिर प्रयास करें।",
  "loadMore": "और लोड करें",
  "mediaUnavailable": "यह आइटम उपलब्ध नहीं है। इसे हटाया गया हो सकता है या क्लाउड से डाउनलोड आवश्यक हो सकता है।",
  "share": "साझा करें",
  "delete": "हटाएँ",
  "cancel": "रद्द करें",
  "info": "जानकारी",
  "deleteMedia": "इस आइटम को फ़ोटो लाइब्रेरी से हटाएँ?",
  "deleteHint": "सिस्टम पुष्टि माँग सकता है। यह आइटम केवल इस एल्बम से नहीं, पूरी लाइब्रेरी से हटेगा।",
  "actionFailed": "कार्रवाई पूरी नहीं हुई।",
  "deleteCancelled": "कोई आइटम नहीं हटाया गया।",
  "created": "बनाया गया",
  "fileSize": "फ़ाइल का आकार",
  "resolution": "रिज़ॉल्यूशन",
  "duration": "अवधि",
  "album": "एल्बम",
  "filename": "फ़ाइल का नाम",
  "close": "बंद करें",
  "videoError": "यह वीडियो नहीं चला।",
  "muted": "आवाज़ बंद करें",
  "unmuted": "आवाज़ चालू करें",
  "play": "चलाएँ",
  "pause": "रोकें",
  "fullscreen": "पूरी स्क्रीन",
  "previousItem": "पिछला आइटम",
  "nextItem": "अगला आइटम",
  "addressHint": "खोजें या पता दर्ज करें",
  "newTab": "नया टैब",
  "newPrivateTab": "नया निजी टैब",
  "tabs": "टैब",
  "closeAllTabs": "सभी टैब बंद करें",
  "incognito": "निजी मोड",
  "privateNote": "निजी टैब का इतिहास या कुकी सेव नहीं होता। चुने हुए डाउनलोड और बुकमार्क रहते हैं। Android पर मोड बदलने से वेबसाइट साइन-इन साफ़ हो जाते हैं।",
  "bookmarks": "बुकमार्क",
  "history": "इतिहास",
  "downloads": "डाउनलोड",
  "addBookmark": "पेज बुकमार्क करें",
  "edit": "बदलें",
  "save": "सेव करें",
  "title": "शीर्षक",
  "url": "यूआरएल",
  "clearHistory": "पूरा इतिहास साफ़ करें",
  "clearConfirm": "पूरा ब्राउज़िंग इतिहास साफ़ करें?",
  "noBookmarks": "अभी कोई बुकमार्क नहीं है",
  "noHistory": "कोई ब्राउज़िंग इतिहास नहीं है",
  "noDownloads": "अभी कोई डाउनलोड नहीं है",
  "findInPage": "पेज में खोजें",
  "findHint": "टेक्स्ट खोजें",
  "desktopSite": "डेस्कटॉप साइट",
  "textZoom": "टेक्स्ट का आकार",
  "openChrome": "Chrome में खोलें",
  "openSafari": "Safari में खोलें",
  "openExternal": "डिफ़ॉल्ट ब्राउज़र में खोलें",
  "customTab": "कस्टम टैब में खोलें",
  "back": "पीछे",
  "forward": "आगे",
  "reload": "फिर लोड करें",
  "stop": "रोकें",
  "notSecure": "सुरक्षित नहीं",
  "secureConnection": "HTTPS कनेक्शन",
  "sslBlocked": "सुरक्षा प्रमाणपत्र सत्यापित न होने के कारण पेज ब्लॉक किया गया।",
  "pageError": "पेज लोड नहीं हुआ। कनेक्शन जाँचें और फिर प्रयास करें।",
  "browserError": "ब्राउज़र डेटा नहीं खुला। फिर प्रयास करें।",
  "websitePermission": "वेबसाइट की अनुमति",
  "camera": "कैमरा",
  "microphone": "माइक्रोफ़ोन",
  "allow": "अनुमति दें",
  "deny": "मना करें",
  "openApp": "लिंक दूसरे ऐप में खोलें?",
  "downloadFile": "यह फ़ाइल डाउनलोड करें?",
  "download": "डाउनलोड करें",
  "downloadComplete": "डाउनलोड पूरा हुआ",
  "downloadFailed": "डाउनलोड विफल हुआ या बाधित हुआ",
  "downloading": "डाउनलोड हो रहा है",
  "open": "खोलें",
  "deleteDownload": "डाउनलोड की हुई फ़ाइल हटाएँ?",
  "downloadHint": "यह सेव की हुई फ़ाइल और उसकी प्रविष्टि हटाता है।",
  "privateCleanup": "निजी ब्राउज़िंग डेटा साफ़ हो रहा है",
  "blankTab": "वेब पर खोजें या वेबसाइट का पता दर्ज करें।",
  "tabLimit": "नया टैब खोलने से पहले एक टैब बंद करें।",
  "invalidUrl": "सही HTTP या HTTPS पता दर्ज करें।",
  "downloadUnsupported": "यह डाउनलोड सेव नहीं हो सकता। पेज बाहरी ब्राउज़र में खोलकर देखें।",
  "searchHistory": "इतिहास खोजें",
  "regularTabs": "सामान्य टैब",
  "privateTabs": "निजी टैब"
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\test\browser_test.dart

```dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:drive/features/browser/browser_downloads.dart';
import 'package:drive/features/browser/browser_models.dart';
import 'package:drive/features/browser/browser_platform.dart';
import 'package:drive/features/browser/browser_session.dart';
import 'package:drive/features/browser/browser_store.dart';
import 'package:drive/features/browser/browser_urls.dart';

class FakeFiles extends BrowserPlatform {
  List<int>? saved;
  bool deleted = false;
  @override
  Future<Map<String, String>> publish(
    String source,
    String name,
    String mime,
    String notificationTitle,
  ) async {
    saved = await File(source).readAsBytes();
    return {
      'location': 'content://media/external/downloads/42',
      'name': name,
      'mime': mime,
    };
  }

  @override
  Future<void> delete(String location) async {
    deleted = true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  late BrowserStore store;
  setUp(() {
    store = BrowserStore(
      factory: databaseFactoryFfi,
      databasePath: inMemoryDatabasePath,
    );
  });
  tearDown(() async {
    await store.close();
  });
  test(
    'address input distinguishes websites, searches and explicit schemes',
    () {
      expect(
        browserAddress('example.com/path').toString(),
        'https://example.com/path',
      );
      expect(browserAddress('http://localhost:8080').scheme, 'http');
      expect(
        browserAddress('cricket scores today').queryParameters['q'],
        'cricket scores today',
      );
      expect(browserAddress('javascript:alert(1)').host, 'www.google.com');
      expect(browserAddress('file:///secret').host, 'www.google.com');
      expect(browserAddress(' ').toString(), 'about:blank');
      expect(isWebAddress(Uri.parse('https://user:pass@example.com')), false);
    },
  );
  test('intent fallback accepts encoded web URLs and refuses unsafe schemes', () {
    expect(
      intentFallback(
        'intent://play#Intent;S.browser_fallback_url=https%3A%2F%2Fexample.com%2Fwatch;end',
      )?.host,
      'example.com',
    );
    expect(
      intentFallback(
        'intent://play#Intent;S.browser_fallback_url=javascript%3Aalert(1);end',
      ),
      isNull,
    );
    expect(
      intentFallback('intent://play#Intent;S.browser_fallback_url=%ZZ;end'),
      isNull,
    );
  });
  test(
    'download names cannot traverse directories or retain control characters',
    () {
      expect(safeDownloadName('../../photo.jpg'), 'photo.jpg');
      expect(safeDownloadName('..\\photo.jpg'), 'photo.jpg');
      expect(safeDownloadName('..'), 'download');
      expect(safeDownloadName('a:b?.pdf'), 'a_b_.pdf');
      expect(safeDownloadName('x' * 300).length, 160);
    },
  );
  test('SQLite stores normal tabs, selection and thumbnails but excludes private tabs', () async {
    final normal = BrowserTab(
      id: 'normal',
      url: 'https://example.com',
      title: 'Example',
      desktop: true,
      zoom: 125,
    );
    final private = BrowserTab(
      id: 'private',
      url: 'https://secret.example',
      title: 'Secret',
      incognito: true,
    );
    await store.saveTabs([normal, private], normal.id);
    final restored = await store.tabs();
    expect(restored.length, 1);
    expect(restored.single.url, normal.url);
    expect(restored.single.desktop, true);
    expect(restored.single.zoom, 125);
    expect(await store.value('selected'), 'normal');
    final db = await store.database;
    expect(
      (await db.rawQuery(
        "SELECT count(*) AS total FROM tabs WHERE url LIKE '%secret%'",
      )).single['total'],
      0,
    );
  });
  test('serialized tab writes keep the newest snapshot', () async {
    final a = BrowserTab(id: 'a');
    final b = BrowserTab(id: 'b');
    final first = store.saveTabs([a], 'a');
    final second = store.saveTabs([b], 'b');
    await Future.wait([first, second]);
    expect((await store.tabs()).single.id, 'b');
  });
  test(
    'history ignores private navigation and treats wildcard searches literally',
    () async {
      await store.addHistory(
        BrowserTab(
          id: 'a',
          url: 'https://example.com/a_b',
          title: 'Cricket Highlights',
        ),
      );
      await store.addHistory(
        BrowserTab(
          id: 'b',
          url: 'https://secret.example',
          title: 'secret',
          incognito: true,
        ),
      );
      expect((await store.history()).length, 1);
      expect(
        (await store.history('CRICKET')).single.title,
        'Cricket Highlights',
      );
      expect((await store.history('_')).length, 1);
      expect(await store.history('%'), isEmpty);
      await store.clearHistory();
      expect(await store.history(), isEmpty);
    },
  );
  test('bookmarks can be edited by URL and removed', () async {
    await store.bookmark('https://example.com', 'First');
    await store.bookmark(
      'https://new.example',
      'Second',
      previousUrl: 'https://example.com',
    );
    expect((await store.bookmarks()).single.url, 'https://new.example');
    await store.removeBookmark('https://new.example');
    expect(await store.bookmarks(), isEmpty);
  });
  test('private mode transition removes views before clearing and leaves no restored private tab', () async {
    final events = <String>[];
    final session = BrowserSession(
      store,
      android: true,
      afterViewsRemoved: () async {
        events.add('removed');
      },
      clearPrivateData: () async {
        events.add('cleared');
      },
    );
    await session.initialize();
    final normal = session.selected;
    await session.add(private: true, url: 'https://private.example');
    expect(events, ['removed', 'cleared']);
    expect(await store.value('privateDirty'), 'true');
    expect((await store.tabs()).every((tab) => !tab.incognito), true);
    await session.select(normal);
    expect(events, ['removed', 'cleared', 'removed', 'cleared']);
    expect(await store.value('privateDirty'), 'false');
    await session.closeAll();
    expect(session.tabs.length, 1);
    expect(session.selected.incognito, false);
    session.dispose();
  });
  test(
    'private cleanup is recovered before a cold-start browser becomes ready',
    () async {
      await store.setValue('privateDirty', 'true');
      var cleaned = false;
      final session = BrowserSession(
        store,
        android: true,
        afterViewsRemoved: () async {},
        clearPrivateData: () async {
          cleaned = true;
        },
      );
      expect(session.ready, false);
      await session.initialize();
      expect(cleaned, true);
      expect(session.ready, true);
      expect(await store.value('privateDirty'), 'false');
      session.dispose();
    },
  );
  test('failed privacy cleanup blocks rendering and can be retried', () async {
    await store.setValue('privateDirty', 'true');
    var fail = true;
    final session = BrowserSession(
      store,
      android: true,
      afterViewsRemoved: () async {},
      clearPrivateData: () async {
        if (fail) {
          throw StateError('failed');
        }
      },
    );
    await session.initialize();
    expect(session.ready, false);
    expect(session.error, isNotNull);
    expect(await store.value('privateDirty'), 'true');
    fail = false;
    await session.initialize();
    expect(session.ready, true);
    session.dispose();
  });
  test('downloads strip cookies across redirects, do not send CP authentication, and persist completed files', () async {
    final directory = await Directory.systemTemp.createTemp(
      'cpdrive-browser-test-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final client = Dio();
    final headers = <Map<String, dynamic>>[];
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          headers.add(Map.of(options.headers));
          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: headers.length == 1 ? 302 : 200,
              headers: Headers.fromMap(
                headers.length == 1
                    ? {
                        'location': ['https://cdn.example/file'],
                      }
                    : {
                        'content-type': ['text/plain'],
                        'content-length': ['3'],
                      },
              ),
              data: ResponseBody.fromBytes(
                headers.length == 1 ? [] : [1, 2, 3],
                headers.length == 1 ? 302 : 200,
                headers: headers.length == 1
                    ? {
                        'location': ['https://cdn.example/file'],
                      }
                    : {
                        'content-type': ['text/plain'],
                        'content-length': ['3'],
                      },
              ),
            ),
          );
        },
      ),
    );
    final platform = FakeFiles();
    final downloads = BrowserDownloads(
      store,
      platform,
      client: client,
      temporaryDirectory: () async => directory,
    );
    await downloads.download(
      url: Uri.parse('https://example.com/file'),
      name: '../file.txt',
      mime: 'text/plain',
      completeTitle: 'Done',
      private: true,
      cookie: 'session=private',
    );
    expect(headers.first['Cookie'], 'session=private');
    expect(headers.length, 2, reason: '$headers');
    expect(headers.last.containsKey('Cookie'), false, reason: '$headers');
    expect(headers.every((h) => !h.containsKey('Authorization')), true);
    expect(platform.saved, [1, 2, 3]);
    expect(downloads.items.single.status, 'complete');
    expect(downloads.items.single.name, 'file.txt');
    expect((await store.downloads()).single.url, '');
    expect(await directory.list().toList(), isEmpty);
    await downloads.remove(downloads.items.single);
    expect(platform.deleted, true);
    expect(await store.downloads(), isEmpty);
    downloads.dispose();
  });
  test('interrupted downloads are marked failed on restoration', () async {
    await store.saveDownload(
      BrowserDownload(id: '1', name: 'file', created: 1),
    );
    final downloads = BrowserDownloads(store, FakeFiles());
    await downloads.initialize();
    expect(downloads.items.single.status, 'failed');
    expect((await store.downloads()).single.status, 'failed');
    downloads.dispose();
  });
  test('unsafe redirect fails instead of sending cookies over HTTP', () async {
    final directory = await Directory.systemTemp.createTemp(
      'cpdrive-browser-test-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final client = Dio();
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 302,
            headers: Headers.fromMap({
              'location': ['http://example.com/file'],
            }),
            data: ResponseBody.fromBytes(
              [],
              302,
              headers: {
                'location': ['http://example.com/file'],
              },
            ),
          ),
        ),
      ),
    );
    final downloads = BrowserDownloads(
      store,
      FakeFiles(),
      client: client,
      temporaryDirectory: () async => directory,
    );
    await downloads.download(
      url: Uri.parse('https://example.com/file'),
      name: 'file',
      mime: 'text/plain',
      completeTitle: 'Done',
      cookie: 'secret',
    );
    expect(downloads.items.single.status, 'failed');
    expect(downloads.items.single.location, '');
    downloads.dispose();
  });
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\test\browser_widget_test.dart

```dart
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\build.gradle.kts

```kotlin
plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.cricketerspitch.drive"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.cricketerspitch.drive"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = 36
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.core:core-ktx:1.17.0")
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\src\main\AndroidManifest.xml

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
    <uses-permission android:name="android.permission.READ_MEDIA_VISUAL_USER_SELECTED"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="28"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-feature android:name="android.hardware.camera" android:required="false"/>
    <uses-feature android:name="android.hardware.microphone" android:required="false"/>
    <application
        android:label="CP Drive"
        android:usesCleartextTraffic="true"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <provider android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.browser_files" android:exported="false" android:grantUriPermissions="true">
            <meta-data android:name="android.support.FILE_PROVIDER_PATHS" android:resource="@xml/browser_file_paths"/>
        </provider>
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <!-- Required to query activities that can process text, see:
         https://developer.android.com/training/package-visibility and
         https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT.

         In particular, this is used by the Flutter engine in io.flutter.plugin.text.ProcessTextPlugin. -->
    <queries>
        <package android:name="com.android.chrome"/>
        <intent><action android:name="android.intent.action.VIEW"/><data android:scheme="https"/></intent>
        <intent><action android:name="android.intent.action.VIEW"/><data android:scheme="mailto"/></intent>
        <intent><action android:name="android.intent.action.VIEW"/><data android:scheme="tel"/></intent>
        <intent><action android:name="android.intent.action.VIEW"/><data android:scheme="sms"/></intent>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
```

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\src\main\kotlin\com\cricketerspitch\drive\MainActivity.kt

```kotlin
package com.cricketerspitch.drive

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.ClipData
import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import androidx.core.app.NotificationCompat
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    private val filesExecutor = Executors.newSingleThreadExecutor()
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "cpdrive/browser_files").setMethodCallHandler { call, result ->
            when (call.method) {
                "openIntent" -> try {
                    val intent = Intent.parseUri(requireNotNull(call.argument<String>("url")), Intent.URI_INTENT_SCHEME)
                    require(intent.data?.scheme !in listOf("file", "content", "javascript", "data", "about"))
                    intent.action = Intent.ACTION_VIEW
                    intent.component = null
                    intent.selector = null
                    intent.addCategory(Intent.CATEGORY_BROWSABLE)
                    intent.flags = 0
                    startActivity(intent)
                    result.success(true)
                } catch (_: Exception) { result.success(false) }
                "publish" -> filesExecutor.execute {
                    try {
                        val source = File(requireNotNull(call.argument<String>("path"))).canonicalFile
                        require(source.path.startsWith(cacheDir.canonicalPath + File.separator) && source.isFile)
                        val name = requireNotNull(call.argument<String>("name"))
                        require(name.isNotBlank() && name.length <= 160 && !name.contains('/') && !name.contains('\\'))
                        val mime = call.argument<String>("mime") ?: "application/octet-stream"
                        val location: String
                        if (Build.VERSION.SDK_INT >= 29) {
                            val values = ContentValues().apply {
                                put(MediaStore.Downloads.DISPLAY_NAME, name)
                                put(MediaStore.Downloads.MIME_TYPE, mime)
                                put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS + "/CP Drive")
                                put(MediaStore.Downloads.IS_PENDING, 1)
                            }
                            val uri = requireNotNull(contentResolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values))
                            try {
                                requireNotNull(contentResolver.openOutputStream(uri)).use { output -> source.inputStream().use { it.copyTo(output) } }
                                contentResolver.update(uri, ContentValues().apply { put(MediaStore.Downloads.IS_PENDING, 0) }, null, null)
                                location = uri.toString()
                            } catch (failure: Exception) { contentResolver.delete(uri, null, null); throw failure }
                        } else {
                            val directory = requireNotNull(getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS))
                            val target = File(directory, "${System.currentTimeMillis()}_$name")
                            source.copyTo(target, overwrite = false)
                            location = target.absolutePath
                        }
                        source.delete()
                        runOnUiThread {
                            try { notifyComplete(location, mime, call.argument<String>("title") ?: name, name) } catch (_: Exception) { }
                            result.success(mapOf("location" to location, "name" to name, "mime" to mime))
                        }
                    } catch (failure: Exception) { runOnUiThread { result.error("DOWNLOAD_SAVE", failure.message, null) } }
                }
                "open", "share" -> try {
                    val location = requireNotNull(call.argument<String>("location"))
                    val uri = downloadUri(location)
                    val mime = call.argument<String>("mime") ?: contentResolver.getType(uri) ?: "application/octet-stream"
                    val intent = if (call.method == "share") Intent(Intent.ACTION_SEND).apply {
                        type = mime; putExtra(Intent.EXTRA_STREAM, uri); clipData = ClipData.newRawUri("Download", uri)
                    } else Intent(Intent.ACTION_VIEW).setDataAndType(uri, mime)
                    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                    startActivity(if (call.method == "share") Intent.createChooser(intent, null) else intent)
                    result.success(null)
                } catch (failure: Exception) { result.error("DOWNLOAD_OPEN", failure.message, null) }
                "delete" -> filesExecutor.execute {
                    try {
                        val location = requireNotNull(call.argument<String>("location"))
                        val removed = if (location.startsWith("content://")) {
                            val uri = downloadUri(location)
                            val exists = contentResolver.query(uri, arrayOf(MediaStore.Downloads._ID), null, null, null)?.use { it.moveToFirst() } ?: false
                            !exists || contentResolver.delete(uri, null, null) > 0
                        } else { val file = checkedFile(location); !file.exists() || file.delete() }
                        runOnUiThread { result.success(removed) }
                    } catch (failure: Exception) { runOnUiThread { result.error("DOWNLOAD_DELETE", failure.message, null) } }
                }
                else -> result.notImplemented()
            }
        }
    }
    private fun checkedFile(location: String): File {
        val file = File(location).canonicalFile
        val directory = requireNotNull(getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)).canonicalFile
        require(file.path.startsWith(directory.path + File.separator))
        return file
    }
    private fun downloadUri(location: String): Uri {
        if (!location.startsWith("content://")) return FileProvider.getUriForFile(this, "$packageName.browser_files", checkedFile(location))
        val uri = Uri.parse(location)
        require(uri.scheme == "content" && uri.authority == "media" && uri.pathSegments.size == 3 && uri.pathSegments[1] == "downloads")
        requireNotNull(uri.lastPathSegment?.toLongOrNull())
        return uri
    }
    private fun notifyComplete(location: String, mime: String, title: String, name: String) {
        val manager = getSystemService(NotificationManager::class.java)
        if (Build.VERSION.SDK_INT >= 26) manager.createNotificationChannel(NotificationChannel("cpdrive_downloads", "Downloads", NotificationManager.IMPORTANCE_DEFAULT))
        val uri = downloadUri(location)
        val open = Intent(Intent.ACTION_VIEW).setDataAndType(uri, mime).addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        val pending = PendingIntent.getActivity(this, location.hashCode(), open, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        manager.notify(location.hashCode(), NotificationCompat.Builder(this, "cpdrive_downloads")
            .setSmallIcon(android.R.drawable.stat_sys_download_done).setContentTitle(title).setContentText(name)
            .setContentIntent(pending).setAutoCancel(true).build())
    }
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\src\main\res\xml\browser_file_paths.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-files-path name="browser_downloads" path="Download/"/>
</paths>
```

## C:\Users\ADITYA\Desktop\CP DRIVE\ios\Runner\Info.plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>CADisableMinimumFrameDurationOnPhone</key>
		<true/>
		<key>NSPhotoLibraryUsageDescription</key>
        <string>CP Drive lets you browse, view, share and delete your photos and videos on your phone.</string>
        <key>NSPhotoLibraryAddUsageDescription</key>
        <string>Allow CP Drive to save photos and videos to your photo library when you choose to do so.</string>
        <key>PHPhotoLibraryPreventAutomaticLimitedAccessAlert</key>
        <true/>
        <key>NSCameraUsageDescription</key>
        <string>Allow camera access only when you approve a website request or choose to capture an upload.</string>
        <key>NSMicrophoneUsageDescription</key>
        <string>Allow microphone access only when you approve a website audio request.</string>
        <key>NSAppTransportSecurity</key>
        <dict><key>NSAllowsArbitraryLoadsInWebContent</key><true/></dict>
        <key>UIFileSharingEnabled</key><true/>
        <key>LSSupportsOpeningDocumentsInPlace</key><true/>
        <key>LSApplicationQueriesSchemes</key>
        <array><string>googlechrome</string><string>googlechromes</string><string>mailto</string><string>tel</string><string>sms</string></array>
		<key>CFBundleDevelopmentRegion</key>
		<string>$(DEVELOPMENT_LANGUAGE)</string>
		<key>CFBundleDisplayName</key>
		<string>CP Drive</string>
		<key>CFBundleExecutable</key>
		<string>$(EXECUTABLE_NAME)</string>
		<key>CFBundleIdentifier</key>
		<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
		<key>CFBundleInfoDictionaryVersion</key>
		<string>6.0</string>
		<key>CFBundleName</key>
		<string>CP Drive</string>
		<key>CFBundlePackageType</key>
		<string>APPL</string>
		<key>CFBundleShortVersionString</key>
		<string>$(FLUTTER_BUILD_NAME)</string>
		<key>CFBundleSignature</key>
		<string>????</string>
		<key>CFBundleVersion</key>
		<string>$(FLUTTER_BUILD_NUMBER)</string>
		<key>LSRequiresIPhoneOS</key>
		<true/>
		<key>UIApplicationSceneManifest</key>
		<dict>
			<key>UIApplicationSupportsMultipleScenes</key>
			<false/>
			<key>UISceneConfigurations</key>
			<dict>
				<key>UIWindowSceneSessionRoleApplication</key>
				<array>
					<dict>
						<key>UISceneClassName</key>
						<string>UIWindowScene</string>
						<key>UISceneConfigurationName</key>
						<string>flutter</string>
						<key>UISceneDelegateClassName</key>
						<string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
						<key>UISceneStoryboardFile</key>
						<string>Main</string>
					</dict>
				</array>
			</dict>
		</dict>
		<key>UIApplicationSupportsIndirectInputEvents</key>
		<true/>
		<key>UILaunchStoryboardName</key>
		<string>LaunchScreen</string>
		<key>UIMainStoryboardFile</key>
		<string>Main</string>
		<key>UISupportedInterfaceOrientations</key>
		<array>
			<string>UIInterfaceOrientationPortrait</string>
			<string>UIInterfaceOrientationLandscapeLeft</string>
			<string>UIInterfaceOrientationLandscapeRight</string>
		</array>
		<key>UISupportedInterfaceOrientations~ipad</key>
		<array>
			<string>UIInterfaceOrientationPortrait</string>
			<string>UIInterfaceOrientationPortraitUpsideDown</string>
			<string>UIInterfaceOrientationLandscapeLeft</string>
			<string>UIInterfaceOrientationLandscapeRight</string>
		</array>
		<key>UIStatusBarHidden</key>
		<false/>
	</dict>
</plist>
```

## C:\Users\ADITYA\Desktop\CP DRIVE\ios\Podfile

```ruby
platform :ios, '16.0'
ENV['COCOAPODS_DISABLE_STATS'] = 'true'
project 'Runner', { 'Debug' => :debug, 'Profile' => :release, 'Release' => :release }
def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  raise 'Run flutter pub get first' unless File.exist?(generated_xcode_build_settings_path)
  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT\=(.*)/)
    return matches[1].strip if matches
  end
  raise 'FLUTTER_ROOT missing; run flutter pub get'
end
require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)
flutter_ios_podfile_setup
target 'Runner' do
  use_frameworks!
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
  target 'RunnerTests' do
    inherit! :search_paths
  end
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'PERMISSION_CAMERA=1', 'PERMISSION_MICROPHONE=1', 'PERMISSION_NOTIFICATIONS=1']
    end
  end
end
```

## C:\Users\ADITYA\Desktop\CP DRIVE\third_party\flutter_inappwebview_android\PATCHES.md

```markdown
# Local Android compatibility patch

Upstream: flutter_inappwebview_android 1.1.3 from pub.dev, used by flutter_inappwebview 6.1.5. Upstream license is retained in LICENSE. Android and Dart library sources are copied unchanged; examples and upstream tests are not needed to build the application.

Only change: android/build.gradle uses proguard-android-optimize.txt instead of proguard-android.txt in both build types. AGP 9.1 rejects the removed non-optimizing default. There are no browser-runtime changes in this fork.

The app uses a path dependency override so the compatibility fix is reproducible and does not modify the shared pub cache. Remove the override and vendored package when an upstream stable Android release includes AGP 9 compatibility, then rerun Android builds and browser device checks.
```

## C:\Users\ADITYA\Desktop\CP DRIVE\third_party\flutter_inappwebview_android\android\build.gradle

```groovy
group 'com.pichillilorenzo.flutter_inappwebview_android'
version '1.0-SNAPSHOT'

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:8.0.1'
    }
}

rootProject.allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

apply plugin: 'com.android.library'

android {
    // Conditional for compatibility with AGP <4.2.
    if (project.android.hasProperty("namespace")) {
        namespace 'com.pichillilorenzo.flutter_inappwebview_android'
    }
    compileSdk 34

    defaultConfig {
        minSdkVersion 19
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"

        vectorDrawables.useSupportLibrary = true
        consumerProguardFiles 'proguard-rules.pro'
    }
    lintOptions {
        disable 'InvalidPackage'
    }
    buildTypes {
        debug {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
        release {
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    dependencies {
        implementation 'androidx.webkit:webkit:1.12.0'
        implementation 'androidx.browser:browser:1.8.0'
        implementation 'androidx.appcompat:appcompat:1.6.1'
        implementation 'androidx.swiperefreshlayout:swiperefreshlayout:1.1.0'
    }
}
```
