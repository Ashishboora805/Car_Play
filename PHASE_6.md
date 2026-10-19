# CP Drive — Phase 6 complete source
Full current application and tests, Android Auto media declaration, shared media tree and native activity/service wiring. See ANDROID_AUTO.md for DHU and Play Console steps. Existing binary assets and platform scaffolding remain in the workspace; the unchanged WebView dependency source is in PHASE_4_DEPENDENCY_SOURCE.md. CarPlay belongs to Phase 7.

Validation: dependency resolution succeeds, analyzer clean, all 65 tests pass and the Android debug APK builds successfully. DHU is not installed on this PC; real Android Auto discovery, cold-start playback and backend behavior remain unverified.

## Snapshot tree
```text
pubspec.yaml
pubspec.lock
analysis_options.yaml
l10n.yaml
README.md
ANDROID_AUTO.md
lib\app.dart
lib\main.dart
lib\core\api\api_client.dart
lib\core\api\api_config.dart
lib\core\api\auth_interceptor.dart
lib\core\router\app_router.dart
lib\core\router\route_observer.dart
lib\core\theme\app_theme.dart
lib\core\utils\refresh_controller.dart
lib\features\audio\audio_bootstrap.dart
lib\features\audio\audio_handler.dart
lib\features\audio\audio_output.dart
lib\features\audio\audio_repository.dart
lib\features\audio\commentary_engine.dart
lib\features\audio\media_tree.dart
lib\features\audio\mini_player.dart
lib\features\audio\player_screen.dart
lib\features\audio\speech_queue.dart
lib\features\audio\voice_picker_tile.dart
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
lib\features\matches\home_screen.dart
lib\features\matches\match_card.dart
lib\features\matches\match_repository.dart
lib\features\matches\matches_screen.dart
lib\features\matches\models\match.dart
lib\features\match_details\match_details_screen.dart
lib\features\settings\settings_controller.dart
lib\features\settings\settings_screen.dart
lib\l10n\app_en.arb
lib\l10n\app_hi.arb
lib\l10n\app_localizations_en.dart
lib\l10n\app_localizations_hi.dart
lib\l10n\app_localizations.dart
test\audio_test.dart
test\audio_widget_test.dart
test\auth_test.dart
test\browser_test.dart
test\browser_widget_test.dart
test\gallery_test.dart
test\match_test.dart
test\phase2_test.dart
android/app/build.gradle.kts
android/app/src/main/AndroidManifest.xml
android/app/src/main/kotlin/com/cricketerspitch/drive/MainActivity.kt
android/app/src/main/res/xml/automotive_app_desc.xml
android/app/src/main/res/xml/browser_file_paths.xml
android/app/src/main/res/drawable/ic_audio_notification.xml
```

## C:\Users\ADITYA\Desktop\CP DRIVE\pubspec.yaml
````text
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
  audio_service: ^0.18.19
  just_audio: ^0.10.6
  audio_session: ^0.2.4
  flutter_tts: ^4.2.5
  rxdart: ^0.28.0

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
    - assets/audio/live_keepalive.wav
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\pubspec.lock
````text
# Generated by pub
# See https://dart.dev/tools/pub/glossary#lockfile
packages:
  android_intent_plus:
    dependency: "direct main"
    description:
      name: android_intent_plus
      sha256: "4d4bbd619d698cbee3c400ba89246ecb0f525146b0ae05389f62ede47abd5bec"
      url: "https://pub.dev"
    source: hosted
    version: "6.1.0"
  ansicolor:
    dependency: transitive
    description:
      name: ansicolor
      sha256: "50e982d500bc863e1d703448afdbf9e5a72eb48840a4f766fa361ffd6877055f"
      url: "https://pub.dev"
    source: hosted
    version: "2.0.3"
  archive:
    dependency: transitive
    description:
      name: archive
      sha256: "0d58d1fa1fddf6588251ccf2819f3fb3b6d0452c1b2813ac7413a05592bfbefe"
      url: "https://pub.dev"
    source: hosted
    version: "4.5.2"
  args:
    dependency: transitive
    description:
      name: args
      sha256: d0481093c50b1da8910eb0bb301626d4d8eb7284aa739614d2b394ee09e3ea04
      url: "https://pub.dev"
    source: hosted
    version: "2.7.0"
  async:
    dependency: transitive
    description:
      name: async
      sha256: e2eb0491ba5ddb6177742d2da23904574082139b07c1e33b8503b9f46f3e1a37
      url: "https://pub.dev"
    source: hosted
    version: "2.13.1"
  audio_service:
    dependency: "direct main"
    description:
      name: audio_service
      sha256: "95f3267f3449eb5cf71c8fcf1d556f57af1e898e2dc5815fb168d1843653edb7"
      url: "https://pub.dev"
    source: hosted
    version: "0.18.19"
  audio_service_platform_interface:
    dependency: transitive
    description:
      name: audio_service_platform_interface
      sha256: "6283782851f6c8b501b60904a32fc7199dc631172da0629d7301e66f672ab777"
      url: "https://pub.dev"
    source: hosted
    version: "0.1.3"
  audio_service_web:
    dependency: transitive
    description:
      name: audio_service_web
      sha256: b8ea9243201ee53383157fbccf13d5d2a866b5dda922ec19d866d1d5d70424df
      url: "https://pub.dev"
    source: hosted
    version: "0.1.4"
  audio_session:
    dependency: "direct main"
    description:
      name: audio_session
      sha256: f9e7711a0e24ca8b40f5d7ac374c3c6e55016f3157912badd18199cdbbca5c4d
      url: "https://pub.dev"
    source: hosted
    version: "0.2.4"
  boolean_selector:
    dependency: transitive
    description:
      name: boolean_selector
      sha256: "8aab1771e1243a5063b8b0ff68042d67334e3feab9e95b9490f9a6ebf73b42ea"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.2"
  characters:
    dependency: transitive
    description:
      name: characters
      sha256: faf38497bda5ead2a8c7615f4f7939df04333478bf32e4173fcb06d428b5716b
      url: "https://pub.dev"
    source: hosted
    version: "1.4.1"
  checked_yaml:
    dependency: transitive
    description:
      name: checked_yaml
      sha256: "959525d3162f249993882720d52b7e0c833978df229be20702b33d48d91de70f"
      url: "https://pub.dev"
    source: hosted
    version: "2.0.4"
  chewie:
    dependency: "direct main"
    description:
      name: chewie
      sha256: "56b6641693ddd72f0cd54ddfedf4f3e9390e6d7b7b22dc2503b7e6ad91476f7f"
      url: "https://pub.dev"
    source: hosted
    version: "1.17.2"
  cli_util:
    dependency: transitive
    description:
      name: cli_util
      sha256: ff6785f7e9e3c38ac98b2fb035701789de90154024a75b6cb926445e83197d1c
      url: "https://pub.dev"
    source: hosted
    version: "0.4.2"
  clock:
    dependency: transitive
    description:
      name: clock
      sha256: e51d50bca3217c9a9fa2b41a30e4a38971133f5f9ec7a3d57bae095007f1d28e
      url: "https://pub.dev"
    source: hosted
    version: "1.1.3"
  code_assets:
    dependency: transitive
    description:
      name: code_assets
      sha256: bf394f466ba9205f1812a0433b392d6af280f155f56651eda7c18cc32ed493b8
      url: "https://pub.dev"
    source: hosted
    version: "1.2.1"
  collection:
    dependency: transitive
    description:
      name: collection
      sha256: "2f5709ae4d3d59dd8f7cd309b4e023046b57d8a6c82130785d2b0e5868084e76"
      url: "https://pub.dev"
    source: hosted
    version: "1.19.1"
  cross_file:
    dependency: transitive
    description:
      name: cross_file
      sha256: f141ea4f277af142a0356955707f6556f37b03947d39d55585981a06ca437bd6
      url: "https://pub.dev"
    source: hosted
    version: "0.3.5+5"
  crypto:
    dependency: transitive
    description:
      name: crypto
      sha256: c8ea0233063ba03258fbcf2ca4d6dadfefe14f02fab57702265467a19f27fadf
      url: "https://pub.dev"
    source: hosted
    version: "3.0.7"
  csslib:
    dependency: transitive
    description:
      name: csslib
      sha256: "09bad715f418841f976c77db72d5398dc1253c21fb9c0c7f0b0b985860b2d58e"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.2"
  cupertino_icons:
    dependency: transitive
    description:
      name: cupertino_icons
      sha256: "41e005c33bd814be4d3096aff55b1908d419fde52ca656c8c47719ec745873cd"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.9"
  cupertino_ui:
    dependency: transitive
    description:
      name: cupertino_ui
      sha256: "8e14acc2817ff469b925b0e275ab85ecc6c769621360dd0af1331c47f916e247"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.3"
  dbus:
    dependency: transitive
    description:
      name: dbus
      sha256: f7db8504e715b835f5ebe5fe74604ccd961d504c73389a5d8e81bafc2e2f3612
      url: "https://pub.dev"
    source: hosted
    version: "0.8.0"
  dio:
    dependency: "direct main"
    description:
      name: dio
      sha256: "852ec3b48cc431ac04fff978413c541502b67ffc3e26921e74e3d994694192c1"
      url: "https://pub.dev"
    source: hosted
    version: "5.11.1"
  dio_web_adapter:
    dependency: transitive
    description:
      name: dio_web_adapter
      sha256: "3a1b2cd7be71086f38504956e3ebcd2837288d231ff454bafa78021244102bfc"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.2"
  fake_async:
    dependency: transitive
    description:
      name: fake_async
      sha256: "5368f224a74523e8d2e7399ea1638b37aecfca824a3cc4dfdf77bf1fa905ac44"
      url: "https://pub.dev"
    source: hosted
    version: "1.3.3"
  ffi:
    dependency: transitive
    description:
      name: ffi
      sha256: "6d7fd89431262d8f3125e81b50d3847a091d846eafcd4fdb88dd06f36d705a45"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.0"
  ffi_leak_tracker:
    dependency: transitive
    description:
      name: ffi_leak_tracker
      sha256: "4093d4ef9ca06ffe2786e73bfb25e22aa92112b9bb4ec941f11e3e6b61489a97"
      url: "https://pub.dev"
    source: hosted
    version: "0.1.2"
  file:
    dependency: transitive
    description:
      name: file
      sha256: a3b4f84adafef897088c160faf7dfffb7696046cb13ae90b508c2cbc95d3b8d4
      url: "https://pub.dev"
    source: hosted
    version: "7.0.1"
  fixnum:
    dependency: transitive
    description:
      name: fixnum
      sha256: b6dc7065e46c974bc7c5f143080a6764ec7a4be6da1285ececdc37be96de53be
      url: "https://pub.dev"
    source: hosted
    version: "1.1.1"
  flutter:
    dependency: "direct main"
    description: flutter
    source: sdk
    version: "0.0.0"
  flutter_cache_manager:
    dependency: transitive
    description:
      name: flutter_cache_manager
      sha256: f94fc6f5480977e3eb7b622ed488f671ba96c971bd0e274e6bd0f0ba9b044816
      url: "https://pub.dev"
    source: hosted
    version: "3.4.5"
  flutter_custom_tabs:
    dependency: "direct main"
    description:
      name: flutter_custom_tabs
      sha256: abd00c87e26bc0415a61fa3985653444e9cc16b6a90584aad0d252abb3802532
      url: "https://pub.dev"
    source: hosted
    version: "2.6.0"
  flutter_custom_tabs_android:
    dependency: transitive
    description:
      name: flutter_custom_tabs_android
      sha256: "01557f40deeade9bf2969e093c55b827558ab28cfd71c58b73358bc0ab02b3da"
      url: "https://pub.dev"
    source: hosted
    version: "2.5.0"
  flutter_custom_tabs_ios:
    dependency: transitive
    description:
      name: flutter_custom_tabs_ios
      sha256: "70e69a00dd03666a073b1e0b5bc11c3401ed12e557e048498abf65f1f7c2ee38"
      url: "https://pub.dev"
    source: hosted
    version: "2.6.0"
  flutter_custom_tabs_platform_interface:
    dependency: transitive
    description:
      name: flutter_custom_tabs_platform_interface
      sha256: ef8fac8160d81f562d749a921e2dfeea4ccaad18df329b1797803c1874abcba1
      url: "https://pub.dev"
    source: hosted
    version: "2.5.0"
  flutter_custom_tabs_web:
    dependency: transitive
    description:
      name: flutter_custom_tabs_web
      sha256: "7b1f2cfc024f355cbb42cd704e56669b23996c79de3a7cc518af8a3c8e805b46"
      url: "https://pub.dev"
    source: hosted
    version: "2.5.0"
  flutter_inappwebview:
    dependency: "direct main"
    description:
      name: flutter_inappwebview
      sha256: "80092d13d3e29b6227e25b67973c67c7210bd5e35c4b747ca908e31eb71a46d5"
      url: "https://pub.dev"
    source: hosted
    version: "6.1.5"
  flutter_inappwebview_android:
    dependency: "direct overridden"
    description:
      path: "third_party/flutter_inappwebview_android"
      relative: true
    source: path
    version: "1.1.3"
  flutter_inappwebview_internal_annotations:
    dependency: transitive
    description:
      name: flutter_inappwebview_internal_annotations
      sha256: e30fba942e3debea7b7e6cdd4f0f59ce89dd403a9865193e3221293b6d1544c6
      url: "https://pub.dev"
    source: hosted
    version: "1.3.0"
  flutter_inappwebview_ios:
    dependency: transitive
    description:
      name: flutter_inappwebview_ios
      sha256: "5818cf9b26cf0cbb0f62ff50772217d41ea8d3d9cc00279c45f8aabaa1b4025d"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.2"
  flutter_inappwebview_macos:
    dependency: transitive
    description:
      name: flutter_inappwebview_macos
      sha256: c1fbb86af1a3738e3541364d7d1866315ffb0468a1a77e34198c9be571287da1
      url: "https://pub.dev"
    source: hosted
    version: "1.1.2"
  flutter_inappwebview_platform_interface:
    dependency: transitive
    description:
      name: flutter_inappwebview_platform_interface
      sha256: cf5323e194096b6ede7a1ca808c3e0a078e4b33cc3f6338977d75b4024ba2500
      url: "https://pub.dev"
    source: hosted
    version: "1.3.0+1"
  flutter_inappwebview_web:
    dependency: transitive
    description:
      name: flutter_inappwebview_web
      sha256: "55f89c83b0a0d3b7893306b3bb545ba4770a4df018204917148ebb42dc14a598"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.2"
  flutter_inappwebview_windows:
    dependency: transitive
    description:
      name: flutter_inappwebview_windows
      sha256: "8b4d3a46078a2cdc636c4a3d10d10f2a16882f6be607962dbfff8874d1642055"
      url: "https://pub.dev"
    source: hosted
    version: "0.6.0"
  flutter_launcher_icons:
    dependency: "direct dev"
    description:
      name: flutter_launcher_icons
      sha256: "10f13781741a2e3972126fae08393d3c4e01fa4cd7473326b94b72cf594195e7"
      url: "https://pub.dev"
    source: hosted
    version: "0.14.4"
  flutter_lints:
    dependency: "direct dev"
    description:
      name: flutter_lints
      sha256: "3105dc8492f6183fb076ccf1f351ac3d60564bff92e20bfc4af9cc1651f4e7e1"
      url: "https://pub.dev"
    source: hosted
    version: "6.0.0"
  flutter_localizations:
    dependency: "direct main"
    description: flutter
    source: sdk
    version: "0.0.0"
  flutter_native_splash:
    dependency: "direct dev"
    description:
      name: flutter_native_splash
      sha256: "9db4b80b044e9af17cc4b1272137fc7ace0054d879ef8210a76adc34aaf4cdff"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.8"
  flutter_riverpod:
    dependency: "direct main"
    description:
      name: flutter_riverpod
      sha256: "2b7f9d2a3c730ac1a98221b420cef966b990fca7ab546ede324642ca57a533e3"
      url: "https://pub.dev"
    source: hosted
    version: "3.4.3"
  flutter_secure_storage:
    dependency: "direct main"
    description:
      name: flutter_secure_storage
      sha256: d4e1fb6b2cb524868929e78dc0282fa000554b22060fb53789dc481c9fc95bb8
      url: "https://pub.dev"
    source: hosted
    version: "11.2.0"
  flutter_secure_storage_darwin:
    dependency: transitive
    description:
      name: flutter_secure_storage_darwin
      sha256: a031ceac9b070e62ef183cd7f7d1a8798ebde402d5049f0fe6eb3a51bd797a21
      url: "https://pub.dev"
    source: hosted
    version: "0.4.3"
  flutter_secure_storage_linux:
    dependency: transitive
    description:
      name: flutter_secure_storage_linux
      sha256: caa75bd78f017422912e3a904933113b2428eb79f981ac37acd2dd2a700458ea
      url: "https://pub.dev"
    source: hosted
    version: "3.0.3"
  flutter_secure_storage_platform_interface:
    dependency: transitive
    description:
      name: flutter_secure_storage_platform_interface
      sha256: "64951127f001f546891c86f414972bf49ef2c4c8a4c92c65f5790cc0c9100045"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.1"
  flutter_secure_storage_web:
    dependency: transitive
    description:
      name: flutter_secure_storage_web
      sha256: "073a62b3aeb866ab4ce795f960413948e51e5a42a9b0c8333b6daf5bb3208a1c"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.1"
  flutter_secure_storage_windows:
    dependency: transitive
    description:
      name: flutter_secure_storage_windows
      sha256: "471951813a97006d899db4948acc654a4f28c440083ea08178935ce20b173ec1"
      url: "https://pub.dev"
    source: hosted
    version: "4.2.2"
  flutter_test:
    dependency: "direct dev"
    description: flutter
    source: sdk
    version: "0.0.0"
  flutter_tts:
    dependency: "direct main"
    description:
      name: flutter_tts
      sha256: ce5eb209b40e95f2f4a1397116c87ab2fcdff32257d04ed7a764e75894c03775
      url: "https://pub.dev"
    source: hosted
    version: "4.2.5"
  flutter_web_plugins:
    dependency: transitive
    description: flutter
    source: sdk
    version: "0.0.0"
  glob:
    dependency: transitive
    description:
      name: glob
      sha256: "218aeb56050c714f62a3182775320dfa04602b55074873e24e31bbd39bda96fb"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.0"
  go_router:
    dependency: "direct main"
    description:
      name: go_router
      sha256: "8b05bc90a4f8f8d579db351e2bd6bac566813e12953494dc2a9d7461e7c6dbe7"
      url: "https://pub.dev"
    source: hosted
    version: "18.1.0"
  hooks:
    dependency: transitive
    description:
      name: hooks
      sha256: "9a62a50b50b769a737bc0a8ff381f333529df3ab746b2f6b02e83760231455ba"
      url: "https://pub.dev"
    source: hosted
    version: "2.0.2"
  html:
    dependency: transitive
    description:
      name: html
      sha256: "43b67b8f43321ab066817dfac5619596c98bb1b61624e77203bb4351785f9699"
      url: "https://pub.dev"
    source: hosted
    version: "0.15.7"
  http:
    dependency: transitive
    description:
      name: http
      sha256: "87721a4a50b19c7f1d49001e51409bddc46303966ce89a65af4f4e6004896412"
      url: "https://pub.dev"
    source: hosted
    version: "1.6.0"
  http_parser:
    dependency: transitive
    description:
      name: http_parser
      sha256: "178d74305e7866013777bab2c3d8726205dc5a4dd935297175b19a23a2e66571"
      url: "https://pub.dev"
    source: hosted
    version: "4.1.2"
  image:
    dependency: "direct dev"
    description:
      name: image
      sha256: "89ed75b2f8231fe676808c5564f9590d728024ded7ac782a7ed8474f1c95b72a"
      url: "https://pub.dev"
    source: hosted
    version: "4.12.0"
  intl:
    dependency: "direct main"
    description:
      name: intl
      sha256: "1ca20c894b1717686a2319b8548763d812bc0aabdac580420a44c5178c57a867"
      url: "https://pub.dev"
    source: hosted
    version: "0.20.3"
  jni:
    dependency: transitive
    description:
      name: jni
      sha256: "6b9ca0602fef0230e83149afbe3f9f8227e94f2bbe84a1da4f14d699742f402d"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.0"
  jni_flutter:
    dependency: transitive
    description:
      name: jni_flutter
      sha256: "0dd33d67797560f66e961a6053882d4df54bd345bf063b8fe7ea133f7ad8b191"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.4+1"
  jni_util:
    dependency: transitive
    description:
      name: jni_util
      sha256: "1ba86da04a5f2bf18fde2edb235587e70c5b0fc5bd4ba955f46b00942c3fc35f"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.0"
  js:
    dependency: transitive
    description:
      name: js
      sha256: "53385261521cc4a0c4658fd0ad07a7d14591cf8fc33abbceae306ddb974888dc"
      url: "https://pub.dev"
    source: hosted
    version: "0.7.2"
  json_annotation:
    dependency: transitive
    description:
      name: json_annotation
      sha256: "2a743920d81b7910627f68ee2c9ac1fc0bfee32b9fc3403587d7c6791ca12f80"
      url: "https://pub.dev"
    source: hosted
    version: "4.12.0"
  just_audio:
    dependency: "direct main"
    description:
      name: just_audio
      sha256: e60aa97b233ddea025e13dfac59195207f528fa5e9e4a4a49a8c0766701e5fe6
      url: "https://pub.dev"
    source: hosted
    version: "0.10.6"
  just_audio_platform_interface:
    dependency: transitive
    description:
      name: just_audio_platform_interface
      sha256: "2532c8d6702528824445921c5ff10548b518b13f808c2e34c2fd54793b999a6a"
      url: "https://pub.dev"
    source: hosted
    version: "4.6.0"
  just_audio_web:
    dependency: transitive
    description:
      name: just_audio_web
      sha256: "6ba8a2a7e87d57d32f0f7b42856ade3d6a9fbe0f1a11fabae0a4f00bb73f0663"
      url: "https://pub.dev"
    source: hosted
    version: "0.4.16"
  leak_tracker:
    dependency: transitive
    description:
      name: leak_tracker
      sha256: "33e2e26bdd85a0112ec15400c8cbffea70d0f9c3407491f672a2fad47915e2de"
      url: "https://pub.dev"
    source: hosted
    version: "11.0.2"
  leak_tracker_flutter_testing:
    dependency: transitive
    description:
      name: leak_tracker_flutter_testing
      sha256: "1dbc140bb5a23c75ea9c4811222756104fbcd1a27173f0c34ca01e16bea473c1"
      url: "https://pub.dev"
    source: hosted
    version: "3.0.10"
  leak_tracker_testing:
    dependency: transitive
    description:
      name: leak_tracker_testing
      sha256: "8d5a2d49f4a66b49744b23b018848400d23e54caf9463f4eb20df3eb8acb2eb1"
      url: "https://pub.dev"
    source: hosted
    version: "3.0.2"
  lints:
    dependency: transitive
    description:
      name: lints
      sha256: "12f842a479589fea194fe5c5a3095abc7be0c1f2ddfa9a0e76aed1dbd26a87df"
      url: "https://pub.dev"
    source: hosted
    version: "6.1.0"
  listen:
    dependency: transitive
    description:
      name: listen
      sha256: "47501a08016a43fcad79252439d723f50f14f88fa7bfd8a177e0a417e5c9e1f2"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.1"
  logging:
    dependency: transitive
    description:
      name: logging
      sha256: c8245ada5f1717ed44271ed1c26b8ce85ca3228fd2ffdb75468ab01979309d61
      url: "https://pub.dev"
    source: hosted
    version: "1.3.0"
  matcher:
    dependency: transitive
    description:
      name: matcher
      sha256: "31bd099b47c10cd1aeb55146a2d46ce0277630ecef3f7dae54ad7873f36696cd"
      url: "https://pub.dev"
    source: hosted
    version: "0.12.20"
  material_color_utilities:
    dependency: transitive
    description:
      name: material_color_utilities
      sha256: "9c337007e82b1889149c82ed242ed1cb24a66044e30979c44912381e9be4c48b"
      url: "https://pub.dev"
    source: hosted
    version: "0.13.0"
  material_ui:
    dependency: transitive
    description:
      name: material_ui
      sha256: "27ea1af251a79728ee63068417f2ab469d294931a9bb8366ba8b85b0ef839060"
      url: "https://pub.dev"
    source: hosted
    version: "1.7.0"
  meta:
    dependency: transitive
    description:
      name: meta
      sha256: c82594181e3312f3d0695fc95aaaf7758d75b8d4ae2bbecf223b9fd5109a059d
      url: "https://pub.dev"
    source: hosted
    version: "1.18.3"
  mime:
    dependency: transitive
    description:
      name: mime
      sha256: bd47de35f07e27267e69c8c8b22edf9473bfee170a60d60fcc93730c5144b7f6
      url: "https://pub.dev"
    source: hosted
    version: "2.1.0"
  native_toolchain_c:
    dependency: transitive
    description:
      name: native_toolchain_c
      sha256: f9c168717100ae6d9fee9ffb0be379bf1f8b26b0f6bcbd4fdddcd931993a6a72
      url: "https://pub.dev"
    source: hosted
    version: "0.19.2"
  nested:
    dependency: transitive
    description:
      name: nested
      sha256: "03bac4c528c64c95c722ec99280375a6f2fc708eec17c7b3f07253b626cd2a20"
      url: "https://pub.dev"
    source: hosted
    version: "1.0.0"
  objective_c:
    dependency: transitive
    description:
      name: objective_c
      sha256: b7fb95a6d9a4f009edd63dc5ac69f07420b23a16161c6dd8660290b59c602e8e
      url: "https://pub.dev"
    source: hosted
    version: "9.5.0"
  open_filex:
    dependency: "direct main"
    description:
      name: open_filex
      sha256: "0c3fe80e73f0b3200fef6e175b83dae9790dd23c9cdbb6d15f46e2ff10ae84ad"
      url: "https://pub.dev"
    source: hosted
    version: "5.0.0"
  package_config:
    dependency: transitive
    description:
      name: package_config
      sha256: ffcf4cf3d6c0b74ac43708d9f56625506e8a68aa935abe9d267a7330f320eb5d
      url: "https://pub.dev"
    source: hosted
    version: "3.0.0"
  package_info_plus:
    dependency: transitive
    description:
      name: package_info_plus
      sha256: "73ef2cd5c11a7548f9b7f6fc2a4f6113de2e64aa2a70de63feede95548822908"
      url: "https://pub.dev"
    source: hosted
    version: "10.2.2"
  package_info_plus_platform_interface:
    dependency: transitive
    description:
      name: package_info_plus_platform_interface
      sha256: db762cb2f4f25ee60fb6359773861b0f199e00b90d237bd85a76a1e806b46ef4
      url: "https://pub.dev"
    source: hosted
    version: "4.1.0"
  path:
    dependency: "direct main"
    description:
      name: path
      sha256: "75cca69d1490965be98c73ceaea117e8a04dd21217b37b292c9ddbec0d955bc5"
      url: "https://pub.dev"
    source: hosted
    version: "1.9.1"
  path_provider:
    dependency: "direct main"
    description:
      name: path_provider
      sha256: a7f4874f987173da295a61c181b8ee71dab59b332a486b391babf26a1b884825
      url: "https://pub.dev"
    source: hosted
    version: "2.1.6"
  path_provider_android:
    dependency: transitive
    description:
      name: path_provider_android
      sha256: "69cbd515a62b94d32a7944f086b2f82b4ac40a1d45bebfc00813a430ab2dabcd"
      url: "https://pub.dev"
    source: hosted
    version: "2.3.1"
  path_provider_foundation:
    dependency: transitive
    description:
      name: path_provider_foundation
      sha256: "2a376b7d6392d80cd3705782d2caa734ca4727776db0b6ec36ef3f1855197699"
      url: "https://pub.dev"
    source: hosted
    version: "2.6.0"
  path_provider_linux:
    dependency: transitive
    description:
      name: path_provider_linux
      sha256: "58c2005f147315b11e9b4a7bc889cd5203e250cba8e3f012dae259b4972b5c16"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.2"
  path_provider_platform_interface:
    dependency: transitive
    description:
      name: path_provider_platform_interface
      sha256: "484838772624c3a4b94f1e44a3e19897fee738f2d5c4ce448443b0417f7c9dda"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.3"
  path_provider_windows:
    dependency: transitive
    description:
      name: path_provider_windows
      sha256: bd6f00dbd873bfb70d0761682da2b3a2c2fccc2b9e84c495821639601d81afe7
      url: "https://pub.dev"
    source: hosted
    version: "2.3.0"
  permission_handler:
    dependency: "direct main"
    description:
      name: permission_handler
      sha256: fe54465bcc62a4564c6e4db337bbaded6c0c0fa6e10487414436d163114784f6
      url: "https://pub.dev"
    source: hosted
    version: "12.0.3"
  permission_handler_android:
    dependency: transitive
    description:
      name: permission_handler_android
      sha256: "1e3bc410ca1bf84662104b100eb126e066cb55791b7451307f9708d4007350e6"
      url: "https://pub.dev"
    source: hosted
    version: "13.0.1"
  permission_handler_apple:
    dependency: transitive
    description:
      name: permission_handler_apple
      sha256: "066bbbc60031b63b916a3871e7bb4b6a8c5e7cec8146dafec53d1da304eff0a5"
      url: "https://pub.dev"
    source: hosted
    version: "9.6.2"
  permission_handler_html:
    dependency: transitive
    description:
      name: permission_handler_html
      sha256: "6ea98b3f17f60d3b527f2647ed2ab4dc0f6bfe25b22cb1c363f5d8f62252f6ac"
      url: "https://pub.dev"
    source: hosted
    version: "0.1.4+1"
  permission_handler_platform_interface:
    dependency: transitive
    description:
      name: permission_handler_platform_interface
      sha256: ed86a61c190258fdd65de395ea0632822e3415c1faec38eae0c31b479c28a531
      url: "https://pub.dev"
    source: hosted
    version: "4.4.1"
  permission_handler_windows:
    dependency: transitive
    description:
      name: permission_handler_windows
      sha256: caeae01858a0a7d2df67a445ac98e1ad95e55a0e77c73044f4e9b1c8c2289cbd
      url: "https://pub.dev"
    source: hosted
    version: "0.2.2"
  petitparser:
    dependency: transitive
    description:
      name: petitparser
      sha256: "91bd59303e9f769f108f8df05e371341b15d59e995e6806aefab827b58336675"
      url: "https://pub.dev"
    source: hosted
    version: "7.0.2"
  photo_manager:
    dependency: "direct main"
    description:
      name: photo_manager
      sha256: "2d00a785b501bf1e5f6180bbef772846e767be11d45d11112b63092ef54a419e"
      url: "https://pub.dev"
    source: hosted
    version: "3.12.0"
  photo_manager_image_provider:
    dependency: "direct main"
    description:
      name: photo_manager_image_provider
      sha256: b6015b67b32f345f57cf32c126f871bced2501236c405aafaefa885f7c821e4f
      url: "https://pub.dev"
    source: hosted
    version: "2.2.0"
  photo_view:
    dependency: "direct main"
    description:
      name: photo_view
      sha256: "1fc3d970a91295fbd1364296575f854c9863f225505c28c46e0a03e48960c75e"
      url: "https://pub.dev"
    source: hosted
    version: "0.15.0"
  platform:
    dependency: transitive
    description:
      name: platform
      sha256: a36d119c13416516a7b5913fbe8af8531e11633d784c550b2125f76c758524ec
      url: "https://pub.dev"
    source: hosted
    version: "3.2.0"
  plugin_platform_interface:
    dependency: transitive
    description:
      name: plugin_platform_interface
      sha256: "4820fbfdb9478b1ebae27888254d445073732dae3d6ea81f0b7e06d5dedc3f02"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.8"
  posix:
    dependency: transitive
    description:
      name: posix
      sha256: bc1bad54ad2b735816e31f8d4600cfde6c7839975085ddfbca48b6c9f7c4044e
      url: "https://pub.dev"
    source: hosted
    version: "6.5.2"
  provider:
    dependency: transitive
    description:
      name: provider
      sha256: "4e82183fa20e5ca25703ead7e05de9e4cceed1fbd1eadc1ac3cb6f565a09f272"
      url: "https://pub.dev"
    source: hosted
    version: "6.1.5+1"
  pub_semver:
    dependency: transitive
    description:
      name: pub_semver
      sha256: "261236774e8b1d69cfc6b9eabbc96c40f25e7a2d6b171f3385d4f65d5734fb24"
      url: "https://pub.dev"
    source: hosted
    version: "2.2.1"
  record_use:
    dependency: transitive
    description:
      name: record_use
      sha256: "2551bd8eecfe95d14ae75f6021ad0248be5c27f138c2ec12fcb52b500b3ba1ed"
      url: "https://pub.dev"
    source: hosted
    version: "0.6.0"
  riverpod:
    dependency: transitive
    description:
      name: riverpod
      sha256: "484dfc873ea4c4f4240e5635444fa066f87b07862b7279ebd004a2b71fba4b7a"
      url: "https://pub.dev"
    source: hosted
    version: "3.4.3"
  rxdart:
    dependency: "direct main"
    description:
      name: rxdart
      sha256: "5c3004a4a8dbb94bd4bf5412a4def4acdaa12e12f269737a5751369e12d1a962"
      url: "https://pub.dev"
    source: hosted
    version: "0.28.0"
  share_plus:
    dependency: "direct main"
    description:
      name: share_plus
      sha256: db40767f130189d53f3ae8a6393c217ff4a492da1baff718a9873679c0c00224
      url: "https://pub.dev"
    source: hosted
    version: "13.3.1"
  share_plus_platform_interface:
    dependency: transitive
    description:
      name: share_plus_platform_interface
      sha256: "365ef7379fc22507256adda3385152942ffce08935452bc972c2e52a0bebae41"
      url: "https://pub.dev"
    source: hosted
    version: "7.2.0"
  shared_preferences:
    dependency: "direct main"
    description:
      name: shared_preferences
      sha256: "1e85e0dccf5b4a016077fea7dfbb4a7cb39c759ac1596fcf60c06deadb7da91f"
      url: "https://pub.dev"
    source: hosted
    version: "2.5.6"
  shared_preferences_android:
    dependency: transitive
    description:
      name: shared_preferences_android
      sha256: "1e12aafe408aa50da80edfd679a2a6bf63ba7ab37c7fa98286da459a757b3399"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.28"
  shared_preferences_foundation:
    dependency: transitive
    description:
      name: shared_preferences_foundation
      sha256: "2ec3934efa51e46117f23031cc141b8fc878e8525b94ec1ea4f7f586cf1b47ea"
      url: "https://pub.dev"
    source: hosted
    version: "2.5.7"
  shared_preferences_linux:
    dependency: transitive
    description:
      name: shared_preferences_linux
      sha256: "580abfd40f415611503cae30adf626e6656dfb2f0cee8f465ece7b6defb40f2f"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.1"
  shared_preferences_platform_interface:
    dependency: "direct dev"
    description:
      name: shared_preferences_platform_interface
      sha256: "649dc798a33931919ea356c4305c2d1f81619ea6e92244070b520187b5140ef9"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.2"
  shared_preferences_web:
    dependency: transitive
    description:
      name: shared_preferences_web
      sha256: c49bd060261c9a3f0ff445892695d6212ff603ef3115edbb448509d407600019
      url: "https://pub.dev"
    source: hosted
    version: "2.4.3"
  shared_preferences_windows:
    dependency: transitive
    description:
      name: shared_preferences_windows
      sha256: "94ef0f72b2d71bc3e700e025db3710911bd51a71cefb65cc609dd0d9a982e3c1"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.1"
  sky_engine:
    dependency: transitive
    description: flutter
    source: sdk
    version: "0.0.0"
  source_span:
    dependency: transitive
    description:
      name: source_span
      sha256: "56a02f1f4cd1a2d96303c0144c93bd6d909eea6bee6bf5a0e0b685edbd4c47ab"
      url: "https://pub.dev"
    source: hosted
    version: "1.10.2"
  sqflite:
    dependency: "direct main"
    description:
      name: sqflite
      sha256: "273218a1678360a3127fcf15e543381d9b813d413d783bc6e9a53eed4d2eb8fe"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.4+2"
  sqflite_android:
    dependency: transitive
    description:
      name: sqflite_android
      sha256: e4f659c14bdd14464127fcd234a7a96f61fe0f539b8568e5a38f99f5a568a835
      url: "https://pub.dev"
    source: hosted
    version: "2.4.4+1"
  sqflite_common:
    dependency: transitive
    description:
      name: sqflite_common
      sha256: b80e94ff0d551d5f1f8c7d14348d29b576cca3ae30f6e195a7c380552c32b1e0
      url: "https://pub.dev"
    source: hosted
    version: "2.5.14"
  sqflite_common_ffi:
    dependency: "direct dev"
    description:
      name: sqflite_common_ffi
      sha256: "4cb6179390549743fc1a5a2fb8f134e5ad87ce459f6f4e563531487dadd81710"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.4"
  sqflite_darwin:
    dependency: transitive
    description:
      name: sqflite_darwin
      sha256: "8de68fc306040f992aaf378750c16f95e4298c4bb150dd45091d75e42b1f08ee"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.4+1"
  sqflite_platform_interface:
    dependency: transitive
    description:
      name: sqflite_platform_interface
      sha256: c9177b2f3150ed0647b90a94307c28452fe0a5401863044216aed83addd6c7c5
      url: "https://pub.dev"
    source: hosted
    version: "2.4.2"
  sqlite3:
    dependency: transitive
    description:
      name: sqlite3
      sha256: "4c7fe79840389aaeaf05fd093f795b631b5a98e2bd28d54e555c100f4a9c7a1c"
      url: "https://pub.dev"
    source: hosted
    version: "3.5.2"
  stack_trace:
    dependency: transitive
    description:
      name: stack_trace
      sha256: "277654b3034d17ac6f9f1cb5595db011b1d5d41e8806866db28e0abaa101c490"
      url: "https://pub.dev"
    source: hosted
    version: "1.12.2"
  state_notifier:
    dependency: transitive
    description:
      name: state_notifier
      sha256: b8677376aa54f2d7c58280d5a007f9e8774f1968d1fb1c096adcb4792fba29bb
      url: "https://pub.dev"
    source: hosted
    version: "1.0.0"
  stream_channel:
    dependency: transitive
    description:
      name: stream_channel
      sha256: "969e04c80b8bcdf826f8f16579c7b14d780458bd97f56d107d3950fdbeef059d"
      url: "https://pub.dev"
    source: hosted
    version: "2.1.4"
  string_scanner:
    dependency: transitive
    description:
      name: string_scanner
      sha256: "921cd31725b72fe181906c6a94d987c78e3b98c2e205b397ea399d4054872b43"
      url: "https://pub.dev"
    source: hosted
    version: "1.4.1"
  synchronized:
    dependency: transitive
    description:
      name: synchronized
      sha256: b3d516dbd3757ff2a458735e4f6cbac9ff261f576f6e87bcb17feabb39e657c5
      url: "https://pub.dev"
    source: hosted
    version: "3.5.0"
  term_glyph:
    dependency: transitive
    description:
      name: term_glyph
      sha256: "7f554798625ea768a7518313e58f83891c7f5024f88e46e7182a4558850a4b8e"
      url: "https://pub.dev"
    source: hosted
    version: "1.2.2"
  test_api:
    dependency: transitive
    description:
      name: test_api
      sha256: "2a122cbe059f8b610d3a5415f42e255b6c17b1f21eee1d960f31080237fb4f11"
      url: "https://pub.dev"
    source: hosted
    version: "0.7.12"
  typed_data:
    dependency: transitive
    description:
      name: typed_data
      sha256: f9049c039ebfeb4cf7a7104a675823cd72dba8297f264b6637062516699fa006
      url: "https://pub.dev"
    source: hosted
    version: "1.4.0"
  universal_io:
    dependency: transitive
    description:
      name: universal_io
      sha256: f63cbc48103236abf48e345e07a03ce5757ea86285ed313a6a032596ed9301e2
      url: "https://pub.dev"
    source: hosted
    version: "2.3.1"
  url_launcher:
    dependency: "direct main"
    description:
      name: url_launcher
      sha256: e8cc955c97e06df9879140a1fe301f3d493f01b7c62dec7f46834be31d7e9fda
      url: "https://pub.dev"
    source: hosted
    version: "6.3.3"
  url_launcher_android:
    dependency: transitive
    description:
      name: url_launcher_android
      sha256: "611e87fb320b70d1dd721dc46af89c98aceccea9b31fde49e084591414e0c610"
      url: "https://pub.dev"
    source: hosted
    version: "6.3.33"
  url_launcher_ios:
    dependency: transitive
    description:
      name: url_launcher_ios
      sha256: "8faa1aab294f1ab4040b43660c887b0418d5fa4f0cffef76a484e6aa1092eb4a"
      url: "https://pub.dev"
    source: hosted
    version: "6.4.2"
  url_launcher_linux:
    dependency: transitive
    description:
      name: url_launcher_linux
      sha256: "10f86fef4c2c43563fa6c211ff9cf757adf4d3ab762c56bd430664a947d70cd0"
      url: "https://pub.dev"
    source: hosted
    version: "3.2.3"
  url_launcher_macos:
    dependency: transitive
    description:
      name: url_launcher_macos
      sha256: "5e835a3b869c2d70325349c81c5a45c28e20791265b67b2669da6b08c5cd5201"
      url: "https://pub.dev"
    source: hosted
    version: "3.2.6"
  url_launcher_platform_interface:
    dependency: transitive
    description:
      name: url_launcher_platform_interface
      sha256: "552f8a1e663569be95a8190206a38187b531910283c3e982193e4f2733f01029"
      url: "https://pub.dev"
    source: hosted
    version: "2.3.2"
  url_launcher_web:
    dependency: transitive
    description:
      name: url_launcher_web
      sha256: "85c81589622fbc87c1c683aaea164d3604a7777495a79d91e39ffcdec39ddb34"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.3"
  url_launcher_windows:
    dependency: transitive
    description:
      name: url_launcher_windows
      sha256: "6c5ad3f22cd4c38e089b81963b3cd7bb83b111b2df5dce008bb066162f42e429"
      url: "https://pub.dev"
    source: hosted
    version: "3.1.6"
  uuid:
    dependency: transitive
    description:
      name: uuid
      sha256: "9b129329f58692f6e6578329498a8fe9fbe98f090beb764ffbb8ee2eadd01dcd"
      url: "https://pub.dev"
    source: hosted
    version: "4.6.0"
  vector_math:
    dependency: transitive
    description:
      name: vector_math
      sha256: "1d774bbdf6b72a0b12122fc1560c9c2d2a67db5a4a4cc2bd8a5c990ab20e3188"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.0"
  video_player:
    dependency: "direct main"
    description:
      name: video_player
      sha256: "07ae1e03f2d4c8e2e9a75ee678f90acbc4506d4458a9c628512d119a1eee5754"
      url: "https://pub.dev"
    source: hosted
    version: "2.14.1"
  video_player_android:
    dependency: transitive
    description:
      name: video_player_android
      sha256: d27054dea34d748a44f06d433a57005d2aac69944485b0abbaed3303dbcfa3f1
      url: "https://pub.dev"
    source: hosted
    version: "2.12.2"
  video_player_avfoundation:
    dependency: transitive
    description:
      name: video_player_avfoundation
      sha256: "4f8a845173377ab250a50f9b9dfe4a43500cc76a7c49dd8410d02d8fc29dfd8b"
      url: "https://pub.dev"
    source: hosted
    version: "2.12.1"
  video_player_platform_interface:
    dependency: "direct dev"
    description:
      name: video_player_platform_interface
      sha256: "92c0fbabe20c788e71fd10d26cea998d0d253282e65d145aed0818731cf593ce"
      url: "https://pub.dev"
    source: hosted
    version: "6.9.0"
  video_player_web:
    dependency: transitive
    description:
      name: video_player_web
      sha256: "9f3c00be2ef9b76a95d94ac5119fb843dca6f2c69e6c9968f6f2b6c9e7afbdeb"
      url: "https://pub.dev"
    source: hosted
    version: "2.4.0"
  vm_service:
    dependency: transitive
    description:
      name: vm_service
      sha256: "89b11d62e1040ee681af3b4f1c97a803ecbf010c6e8b9c5896ee5b08c3bf7b78"
      url: "https://pub.dev"
    source: hosted
    version: "15.4.0"
  wakelock_plus:
    dependency: transitive
    description:
      name: wakelock_plus
      sha256: "9a91139ee876c24a9ebe1484e4b9b7923b07d368566a5e0b2301870b0f5029c8"
      url: "https://pub.dev"
    source: hosted
    version: "1.8.1"
  wakelock_plus_platform_interface:
    dependency: transitive
    description:
      name: wakelock_plus_platform_interface
      sha256: "764c25504562abc8ac3406f5d175f126b276e6ba916c7c2675690b73368ca384"
      url: "https://pub.dev"
    source: hosted
    version: "1.7.0"
  web:
    dependency: transitive
    description:
      name: web
      sha256: "868d88a33d8a87b18ffc05f9f030ba328ffefba92d6c127917a2ba740f9cfe4a"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.1"
  win32:
    dependency: transitive
    description:
      name: win32
      sha256: a0b93865d5644f11cf6a8c3f6db909f1ec168958b5805f6cc684adea957cd63d
      url: "https://pub.dev"
    source: hosted
    version: "6.4.0"
  xdg_directories:
    dependency: transitive
    description:
      name: xdg_directories
      sha256: "7a3f37b05d989967cdddcbb571f1ea834867ae2faa29725fd085180e0883aa15"
      url: "https://pub.dev"
    source: hosted
    version: "1.1.0"
  xml:
    dependency: transitive
    description:
      name: xml
      sha256: "67f0aff7be013d107995e9b75bf4e7f2c3ef2dfdb2c8e68024bba0a7fd5756a4"
      url: "https://pub.dev"
    source: hosted
    version: "7.0.1"
  yaml:
    dependency: transitive
    description:
      name: yaml
      sha256: f67cdd8e07d3c6329146aaef1ba043542b3134c12489f553ca9a7435d1068aea
      url: "https://pub.dev"
    source: hosted
    version: "3.1.4"
sdks:
  dart: ">=3.13.4 <4.0.0"
  flutter: ">=3.47.0"

````

## C:\Users\ADITYA\Desktop\CP DRIVE\analysis_options.yaml
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\l10n.yaml
````text
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart

````

## C:\Users\ADITYA\Desktop\CP DRIVE\README.md
````text
# CP Drive — Phase 6

Flutter 3.47.5 stable / Dart 3.13.4. The phone gallery, browser, shared commentary engine and Android Auto media integration are implemented. Phase 7 adds CarPlay. See [Android Auto setup and review guide](ANDROID_AUTO.md) for DHU testing and Play Console steps.

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

## Phase 5: shared commentary audio

### Architecture and behavior

Dependencies added: audio_service 0.18.19, just_audio 0.10.6, audio_session 0.2.4, flutter_tts 4.2.5 and rxdart 0.28.0. The app creates one ProviderContainer, restores the secure session, loads settings, and calls AudioService.init once before showing the UI. That single CPDriveAudioHandler is used by Listen live, the mini-player, full player, notification, lock screen and headset controls. No widget creates a second handler. Audio initialization failure leaves the phone app usable and shows a restart message when listening is requested.

Live matches with stream_url use just_audio instead of TTS. URLs must be directly accessible media URLs; HTTPS public or signed URLs are the intended cross-platform contract. The CP API token is not forwarded to arbitrary media servers. If your stream endpoint requires a Token header or a special player/DRM contract, supply that backend contract before integration. There is no certificate bypass or broad iOS ATS media exception. A failed stream shows an audio error and can be retried with Play.

Without a stream, listening starts with the current real score (or match title if no score is available), then joins commentary at the newest available ball. Match detail and commentary updates are polled every 25 seconds. The first commentary request reuses the already fetched match details. A match-list fetch runs separately so a slow queue refresh cannot delay the selected broadcast. MediaItem.artist follows the refreshed status/score. A lack of new balls stays silent while playbackState.playing remains true. Empty, malformed or failed commentary falls back to changed score strings. The code never invents a score when the backend has supplied none. Details errors retain the last metadata and keep retrying; the full player shows the connection-interrupted state. A match that finishes speaks its result once and ends listening.

Preparation is published as playing/loading so Android starts the foreground media service promptly after a user media action. Preparing a source has a 25-second overall deadline; HTTP connect/receive timeouts remain 20 seconds. A serialized command path plus generation checks and CancelTokens prevents an old response from restarting audio after Pause, Stop or a match switch. Queue refresh and polling requests are canceled on interruption. Speech waits for the native completion callback; utterances do not overlap. Pause/Stop immediately cancel speech and pending lines. A delivery cursor is committed only after speech completes; canceled pending deliveries remain eligible after Resume. The queue bounds pending work to 32 lines, commentary text to 800 characters per line, and native speech waits to three minutes to avoid unbounded backlog or stalled engines. Very old backlog can be skipped in favor of live updates.

Delivery identity is numeric over/ball, with an optional numeric innings field supported when the server resets overs between innings. The first poll selects the latest delivery; later polls sort numerically and reject already spoken/pending keys. Repeated text under the same key is not read again. The backend must provide unique keys for distinct commentary events. If over/ball keys are reused across innings, provide innings or a monotonic numbering contract; that ambiguity cannot be resolved from the original three-field response alone. Cursors are kept per match in memory through pauses and match switches, and reset on sign-out or process restart. Restarting joins the current latest delivery again.

Fallback score fields are the optional score, team1_score and team2_score strings supported in the match model. A string such as 120/3 after 14.2 overs becomes 120 for 3 after 14.2 overs in English; Hindi uses a Hindi wicket phrase. Actual backend score keys still need confirmation. Backend commentary text is spoken as provided, not machine-translated.

Upcoming items speak title/date/time/venue, results speak the result, and Next/Previous select live matches. Browse folders use the same media tree as playback: chosen ordered car tabs, at most 20 matches per folder, list content-style hints, a locally copied logo URI, search and getMediaItem. Browse data refreshes at a two-minute cadence. Show in car affects browsing/search and does not disable phone playback. Signed-out media requests stop audio and publish authentication error code 3 with the exact parked-phone sign-in message. Android Auto discovery/automotive XML and DHU steps remain Phase 6; native CarPlay templates and the shared-engine scene conversion remain Phase 7.

### Phone controls and voices

The mini-player is hidden until a media item is selected. It shows the match/score and Previous, Play/Pause, Next and Stop controls. Tap the match to open the full player with artwork, source type, connection/error state and larger controls. Stop clears the item and removes the mini-player. Listen live on a live match details screen calls the same handler with match:<id>. On Android it requests notification permission if needed; denial does not change the media permission model or the need for the system foreground service.

Settings > Commentary voice enumerates the engine's available voices for the selected English/Hindi language and saves name, locale and optional iOS identifier. Android voices explicitly marked notInstalled are excluded. Use the system default clears the selection. Speech rate and voice changes apply through the handler; changing app language clears an incompatible saved voice. Some engine voices may require network access. If the device lacks an appropriate voice, install it through the device's speech settings and reopen the picker. Choosing a voice does not record audio and does not require microphone access.

### Background audio and platform entries

Android MainActivity now extends AudioServiceActivity while retaining the existing browser file MethodChannel. This is required now for the shared phone/background Flutter engine, before Android Auto discovery is added in Phase 6. The manifest registers AudioService with mediaPlayback type and MediaButtonReceiver, and adds FOREGROUND_SERVICE, FOREGROUND_SERVICE_MEDIA_PLAYBACK and WAKE_LOCK. These support the user-started media service and keep live polling/speech alive while listening. POST_NOTIFICATIONS was already present; a TTS_SERVICE query permits engine discovery on Android 11+. A white vector headphone icon is used for the audio notification.

The audio session uses speech/media attributes, playback category and spokenAudio mode. Android pauses on becoming noisy. Interruptions pause speech/stream output and release focus; transient interruptions can resume if no manual pause/stop occurred. Android automatic recovery is limited to a foreground app, avoiding an unprompted background foreground-service restart; otherwise use the media Play action. Pause releases the native output/focus and lets the Android service leave foreground state, while Stop makes the handler idle and clears the player. Media controls remain the way to resume, including from the lock screen/headset/car.

iOS Info.plist adds UIBackgroundModes/audio. FlutterTts uses a shared playback/spokenAudio audio session with duckOthers and auto-stop disabled between utterances. assets/audio/live_keepalive.wav is a one-second mono 16-bit 16-kHz silent WAV; just_audio loops it only on iOS while live TTS listening is active, so the session can remain active between real commentary updates. It is stopped on Pause, Stop, completion, sign-out and errors. It is not used for stream playback or one-shot upcoming/result announcements. iOS background scheduling, route changes and this keepalive behavior require actual device validation and App Review verification; a Windows build cannot prove them.

The secure-storage provider uses iOS first_unlock_this_device accessibility: the token stays in the device keychain, is available to background audio after the device has been unlocked once since boot, and does not migrate to another device. Valid existing session records are rewritten during restore to adopt that setting. Token/user id are never copied into preferences, media extras, browser storage or logs. A keychain access failure blocks the phone's authenticated route and does not reuse a stale in-memory token.

### Phase 5 setup and device checks

1. Set the real CP_API_BASE_URL, CP_LOGIN_ENDPOINT and CP_COMMENTARY_ENDPOINT in your local backend.json. Keep credentials out of that file. Run flutter pub get, flutter gen-l10n, flutter analyze and flutter test. Run flutter run --dart-define-from-file=backend.json on a phone to exercise the actual backend; the distributed debug APK without defines has login disabled until rebuilt with configuration.
2. On Android, install a build configured for your backend, sign in, open a live match and tap Listen live. Grant or deny notifications and verify both cases. Test a match with stream_url and one without it. Lock the phone for several refreshes, use notification/headset play/pause/next/previous, unplug headphones and test incoming calls. Check that there is no repeated ball on ordinary refresh, Pause interrupts immediately, and Stop removes playback. Test offline recovery, stream failure, server 401/403 and sign-out during an utterance.
3. On a Mac, use the CocoaPods setup from the earlier platform guide, then open ios/Runner.xcworkspace. Select Runner target > Signing & Capabilities > + Capability > Background Modes > enable Audio, AirPlay, and Picture in Picture. UIBackgroundModes/audio is already included. Select an iPhone device and Run. Test English/Hindi voices, locked-screen gaps longer than 25 seconds, Control Center controls, Bluetooth changes, interruptions, silent-loop stop and keychain restore after one unlock. A simulator is useful for controls, but is not a substitute for background/device testing.
4. Confirm the backend returns unique delivery keys (and innings if needed) and score fields the model understands. Test initial join, repeated batches, reversed delivery order, score-only fallback, paused/canceled speech and a match finishing. Public/signed media URLs must remain valid for the listening session.

The audio tests cover malformed commentary, numeric ordering, latest-ball joining, pending/committed deduplication, optional innings, score fallback, speech serialization/cancellation/error recovery, media-tree limits, stream-vs-TTS selection, metadata updates, skipping, auth expiry, headphone/focus handling, late canceled requests, result completion, voice persistence, selected-folder search, slow queue fetches and the 25-second timer. Widget tests cover shared-handler Listen live, mini/full-player controls at large font and the voice picker. Native TTS rendering, audio routing, lock-screen controls and real background survival remain device checks.

References: https://pub.dev/packages/audio_service, https://pub.dev/packages/just_audio, https://pub.dev/packages/audio_session, https://pub.dev/packages/flutter_tts

### Phase 5 verification results

Flutter analysis reports no issues, all 62 tests pass, and the Android debug APK builds successfully. The build reports upstream legacy Kotlin plugin warnings for flutter_tts and photo_manager; these do not prevent this build. No real backend or connected phone was available, so native speech, media routing, background survival and lock-screen controls remain unverified. iOS compilation and device validation require a Mac and iPhone.

````

## C:\Users\ADITYA\Desktop\CP DRIVE\ANDROID_AUTO.md
````text
# Phase 6: Android Auto

Android Auto discovers CP Drive through the application metadata and automotive_app_desc.xml, which declares media. MainActivity extends AudioServiceActivity and retains the phone browser channel. The exported AudioService and MediaButtonReceiver expose browsing and transport controls. audio_service owns one shared engine; main restores secure auth and settings before initializing the single handler, including when the service starts the process without the phone activity. Cold-start behavior requires device validation.

The root advertises list content styles. Live, Upcoming, Results and My Matches respect selected order, Show in car and the 20-item cap. Lists refresh every two minutes; active commentary/score metadata refresh every 25 seconds. Artwork uses the shared file-backed logo. Gallery and Browser stay on the phone. Signed-out browse/play/voice search reports authentication error 3 and: "Sign in to CP Drive on your phone when you are parked." Metadata responses from a previous account are discarded.

INTERNET permits API/stream access. FOREGROUND_SERVICE and FOREGROUND_SERVICE_MEDIA_PLAYBACK authorize playback foreground operation; WAKE_LOCK supports playback. POST_NOTIFICATIONS is requested by the phone Listen live flow on Android 13+, while parked. Media-session notifications have a permission exemption; the car service does not launch permission dialogs. Existing gallery/browser permissions remain phone features. This phase does not create an Android Automotive OS standalone app.

## Desktop Head Unit on Windows

1. On a phone, enable Developer options through Settings > About phone > Build number (tap seven times; manufacturer paths vary), then enable USB debugging. Connect USB, unlock and accept the computer debugging prompt.
2. Update Android Auto from Google Play. Install a backend-configured CP Drive build using flutter run --dart-define-from-file=backend.json. While parked, sign in and install English/Hindi speech voices if needed. The supplied APK without backend defines cannot sign in to your server.
3. Android Studio > Tools > SDK Manager > SDK Tools > Android Auto Desktop Head Unit Emulator > Apply > OK > Finish. Keep the downloaded libraries alongside the executable.
4. Phone Settings > search Android Auto > open settings > scroll to Version (expand Version and permission info if necessary) > tap version ten times > accept developer mode. Overflow > Developer settings > Unknown sources ON for sideloaded media testing. Return > overflow > Start head unit server. Previously connected cars > Add new cars to Android Auto ON.
5. Open PowerShell and run these commands. Unlock the phone for initial connection and accept Android Auto setup prompts. The last command opens the interactive DHU window.

```powershell
$cpAndroidSdk = "$env:LOCALAPPDATA\Android\sdk"
& "$cpAndroidSdk\platform-tools\adb.exe" devices
& "$cpAndroidSdk\platform-tools\adb.exe" forward tcp:5277 tcp:5277
Set-Location "$cpAndroidSdk\extras\google\auto"
.\desktop-head-unit.exe
```

6. DHU app launcher > CP Drive. Browse enabled folders and tap a match. Check logo, score, play/pause/stop and next/previous. Test both streams and TTS commentary, an upcoming summary, a result summary and team-name voice search.
7. Close the phone activity, reconnect DHU and browse with the screen locked. For process recreation, disconnect DHU, stop playback and background CP Drive, then run adb shell am kill com.cricketerspitch.drive. Reconnect without opening the activity; verify account/settings restore and playback. Do not substitute force-stop, which blocks ordinary component starts until user interaction.
8. While parked, sign out on the phone and attempt car browsing and voice playback. Confirm the exact parked sign-in message and no speech. Test API 401/403, offline errors, empty lists, selected tab order, Show in car off/on, 20-item limits, several polling cycles and headset/call interruptions.
9. If discovery fails, check Unknown sources, the installed build, Show in car and the server, then reconnect. Use a trusted Google Play testing/release path for real cars. Unknown sources is a development aid, not approval. Close DHU, stop the server and run adb forward --remove tcp:5277 when finished.

Official instructions: [DHU setup](https://developer.android.com/training/cars/testing/dhu), [Android Auto media declaration](https://developer.android.com/training/cars/media/auto), [car testing](https://developer.android.com/training/cars/testing).

## Play Console

1. Select CP Drive > Test and release (Release in older navigation) > Advanced settings > Form factors > Add form factor > Android Auto. Accept terms and save. Choose the offered release-track configuration; labels can vary by account.
2. Complete Store listing, privacy policy, App content and Data safety, including phone gallery photo/video declarations and the media-playback foreground-service declaration when requested. App access must provide reviewers a dedicated working account and available broadcast instructions. Keep credentials out of source control.
3. Configure production backend defines and release signing, build a signed Android App Bundle and upload it to the appropriate track. This debug APK is not a store release; release signing belongs to store preparation.
4. Check media quality requirements, upload requested car screenshots and explain in review notes: CP Drive provides sports audio, car screens contain match lists and Now Playing, gallery/browser are phone-only, and sign-in is performed while parked. Supply real review data for streams, TTS, upcoming and results.
5. Submit the release/form factor for review and address findings before rollout. Metadata does not imply approval. Follow status in Play Console and the developer-account email.

References: [Distribute to cars](https://developer.android.com/training/cars/distribute), [Car app quality](https://developer.android.com/docs/quality-guidelines/car-app-quality), [Media-session notification exemption](https://developer.android.com/develop/ui/views/notifications/notification-permission#media-sessions).

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\app.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\main.dart
````text
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/api/api_client.dart';
import 'features/audio/audio_bootstrap.dart';
import 'features/settings/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsController(SharedPreferencesAsync());
  try {
    await settings.load();
  } catch (_) {
    /* Storage unavailable: retain defaults. */
  }
  final container = ProviderContainer(
    overrides: [settingsProvider.overrideWithValue(settings)],
  );
  await container.read(authProvider).restore();
  await initializeAudio(container);
  runApp(
    UncontrolledProviderScope(container: container, child: const CPDriveApp()),
  );
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\api\api_client.dart
````text
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/auth_controller.dart';
import 'auth_interceptor.dart';
import 'api_config.dart';

final authProvider = Provider<AuthController>((ref) {
  final auth = AuthController(
    const FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    ),
  );
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\api\api_config.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\api\auth_interceptor.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\router\app_router.dart
````text
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
    if (!ref.read(authProvider).ready) {
      Future.microtask(() => ref.read(authProvider).restore());
    }
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\router\route_observer.dart
````text
import 'package:flutter/widgets.dart';

final routeObserver = RouteObserver<ModalRoute<void>>();

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\theme\app_theme.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\core\utils\refresh_controller.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\audio_bootstrap.dart
````text
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../core/api/api_client.dart';
import '../matches/match_repository.dart';
import '../settings/settings_controller.dart';
import 'audio_handler.dart';
import 'audio_output.dart';
import 'audio_repository.dart';
import 'media_tree.dart';

class AudioRuntime {
  AudioHandler? handler;
  bool failed = false;
}

final audioRuntimeProvider = Provider<AudioRuntime>((ref) => AudioRuntime());
final audioHandlerProvider = Provider<AudioHandler?>(
  (ref) => ref.watch(audioRuntimeProvider).handler,
);
Future<void> initializeAudio(ProviderContainer container) async {
  final runtime = container.read(audioRuntimeProvider);
  NativeAudioOutput? output;
  CPDriveAudioHandler? candidate;
  try {
    final directory = await getApplicationSupportDirectory();
    final artwork = File(path.join(directory.path, 'cpdrive_media_logo.png'));
    if (!await artwork.exists()) {
      final data = await rootBundle.load('assets/images/logo.png');
      await artwork.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        flush: true,
      );
    }
    output = NativeAudioOutput();
    await output.initialize();
    final readyOutput = output;
    runtime.handler = await AudioService.init<CPDriveAudioHandler>(
      builder: () => candidate = CPDriveAudioHandler(
        auth: container.read(authProvider),
        settings: container.read(settingsProvider),
        repository: NetworkAudioRepository(
          container.read(matchRepositoryProvider),
          container.read(apiProvider),
        ),
        output: readyOutput,
        tree: MediaTree(artwork.uri),
      ),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.cricketerspitch.drive.commentary',
        androidNotificationChannelName: 'CP Drive commentary',
        androidNotificationIcon: 'drawable/ic_audio_notification',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
        androidBrowsableRootExtras: MediaTree.style,
      ),
    );
  } catch (_) {
    runtime.failed = true;
    if (candidate != null || output != null) {
      try {
        final ownedHandler = candidate;
        if (ownedHandler != null) {
          await ownedHandler.shutdown();
        } else {
          await output!.dispose();
        }
      } catch (_) {
        /* Keep the phone app available if native audio initialization fails. */
      }
    }
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\audio_handler.dart
````text
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../auth/auth_controller.dart';
import '../matches/models/match.dart';
import '../settings/settings_controller.dart';
import 'audio_output.dart';
import 'audio_repository.dart';
import 'commentary_engine.dart';
import 'media_tree.dart';
import 'speech_queue.dart';

class CPDriveAudioHandler extends BaseAudioHandler {
  CPDriveAudioHandler({
    required this.auth,
    required this.settings,
    required this.repository,
    required this.output,
    required this.tree,
    this.pollInterval = const Duration(seconds: 25),
    this.browseInterval = const Duration(minutes: 2),
    CommentaryEngine? commentary,
  }) : engine = commentary ?? CommentaryEngine() {
    speech = SpeechQueue(output, onError: (_) => unawaited(_failure()));
    _subscriptions.add(output.events.listen(_transport));
    _subscriptions.add(output.focus.listen(_focus));
    auth.addListener(_authChanged);
    settings.addListener(_settingsChanged);
    _fingerprint = _voiceFingerprint;
    _user = auth.userId;
    _browseTimer = Timer.periodic(browseInterval, (_) => _notifyChildren());
    _publish(AudioProcessingState.idle);
  }
  final AuthController auth;
  final SettingsController settings;
  final AudioRepository repository;
  final AudioOutput output;
  final MediaTree tree;
  final CommentaryEngine engine;
  final Duration pollInterval, browseInterval;
  late final SpeechQueue speech;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  final Map<String, BehaviorSubject<Map<String, dynamic>>> _children = {};
  final Map<int, Match> _cache = {};
  final Map<String, ({DateTime time, List<Match> matches})> _browseCache = {};
  List<Match> _liveQueue = [];
  Match? _current;
  Timer? _pollTimer, _browseTimer;
  CancelToken? _request, _queueRequest;
  int _epoch = 0, _revision = 0;
  int? _resumeEpoch;
  int? _pollEpoch;
  bool _active = false, _stream = false, _disposed = false;
  Future<void> _commands = Future.value();
  Future<void> _silencing = Future.value();
  late String _fingerprint;
  String? _user;
  String get language => settings.language == 'system'
      ? (PlatformDispatcher.instance.locale.languageCode == 'hi' ? 'hi' : 'en')
      : settings.language;
  bool get hindi => language == 'hi';
  String get _voiceFingerprint =>
      jsonEncode([language, settings.speechRate, settings.speechVoice]);
  String get signInMessage =>
      'Sign in to CP Drive on your phone when you are parked.';
  String get errorMessage => hindi
      ? 'कमेंट्री नहीं चली। कनेक्शन और आवाज़ जाँचकर फिर प्रयास करें।'
      : 'Commentary could not be played. Check your connection, stream and installed speech voices, then retry.';
  bool _valid(int epoch) => !_disposed && epoch == _epoch && auth.signedIn;
  void _publish(
    AudioProcessingState state, {
    int? errorCode,
    String? errorMessage,
  }) {
    if (_disposed) {
      return;
    }
    final index = _liveQueue.indexWhere((match) => match.id == _current?.id);
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          _active ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
          MediaControl.stop,
        ],
        androidCompactActionIndices: const [0, 1, 2],
        processingState: state,
        playing: _active,
        updatePosition: _stream ? output.position : Duration.zero,
        bufferedPosition: _stream ? output.bufferedPosition : Duration.zero,
        systemActions: {
          if (_stream && output.duration != null) MediaAction.seek,
        },
        queueIndex: index < 0 ? null : index,
        errorCode: errorCode,
        errorMessage: errorMessage,
      ),
    );
  }

  int _interrupt() {
    final epoch = ++_epoch;
    _active = false;
    _resumeEpoch = null;
    _pollTimer?.cancel();
    _pollTimer = null;
    _request?.cancel();
    _queueRequest?.cancel();
    _request = null;
    _queueRequest = null;
    final previous = _silencing;
    _silencing = Future.wait<void>([
      previous,
      speech.stop(),
      output.stopPlayer(),
      output.deactivate(),
    ]).then((_) {}).catchError((Object _) {});
    return epoch;
  }

  Future<void> _schedule(int epoch, Future<void> Function() operation) {
    final result = _commands.catchError((Object _) {}).then((_) async {
      await _silencing;
      if (!_valid(epoch)) {
        return;
      }
      try {
        await operation().timeout(const Duration(seconds: 25));
      } catch (_) {
        if (_valid(epoch)) {
          await _failure();
        }
      }
    });
    _commands = result;
    return result;
  }

  @override
  Future<void> playFromMediaId(String mediaId, [Map<String, dynamic>? extras]) {
    final id = MediaTree.matchId(mediaId);
    if (!auth.signedIn) {
      return _expired();
    }
    if (id == null || id < 0) {
      return _failure();
    }
    final epoch = _interrupt();
    _active = true;
    _publish(AudioProcessingState.loading);
    return _schedule(epoch, () => _begin(id, epoch));
  }

  Future<void> _begin(int id, int epoch) async {
    final token = CancelToken();
    _request = token;
    final match = await repository.details(id, token);
    if (!_valid(epoch)) {
      return;
    }
    _current = match;
    _cache[id] = match;
    _stream = match.status == MatchStatus.live && match.streamUrl != null;
    if (match.status == MatchStatus.live) {
      _liveQueue = _liveQueue
          .where((m) => m.status == MatchStatus.live)
          .take(20)
          .toList();
      if (!_liveQueue.any((m) => m.id == id)) {
        _liveQueue = [match, ..._liveQueue.take(19)];
      }
      queue.add(_liveQueue.map((m) => tree.item(m, hindi: hindi)).toList());
    } else {
      _liveQueue = [];
      queue.add([tree.item(match, hindi: hindi)]);
    }
    if (!_stream) {
      await output.configureVoice(
        language,
        settings.speechRate,
        settings.speechVoice,
      );
    }
    if (!_valid(epoch)) {
      return;
    }
    if (!await output.activate()) {
      throw StateError('Audio focus unavailable');
    }
    if (!_valid(epoch)) {
      return;
    }
    if (_stream) {
      await output.loadStream(match.streamUrl!);
    } else if (match.status == MatchStatus.live) {
      await output.keepAlive();
    }
    if (!_valid(epoch)) {
      return;
    }
    mediaItem.add(
      tree
          .item(match, hindi: hindi)
          .copyWith(duration: _stream ? output.duration : null),
    );
    _active = true;
    _fingerprint = _voiceFingerprint;
    customState.add({
      'offline': false,
      'source': _stream ? 'stream' : 'speech',
    });
    _publish(AudioProcessingState.ready);
    if (_stream) {
      output.playStream();
    } else {
      speech.start();
      if (match.status == MatchStatus.live) {
        engine.primeScore(id, match);
        final score = CommentaryEngine.spokenScore(match, hindi: hindi);
        speech.add(SpeechUtterance(score.isEmpty ? match.title() : score));
      } else {
        _announce(match, epoch);
        return;
      }
    }
    unawaited(_refreshQueue(epoch));
    _pollTimer = Timer.periodic(pollInterval, (_) => unawaited(_tick(epoch)));
    unawaited(_tick(epoch, initial: match));
  }

  Future<void> _refreshQueue(int epoch) async {
    final token = CancelToken();
    _queueRequest = token;
    try {
      var matches = (await repository.matches(token))
          .where((m) => m.status == MatchStatus.live && m.id != null)
          .take(20)
          .toList();
      if (!_valid(epoch) || _current == null) {
        return;
      }
      if (!matches.any((m) => m.id == _current!.id)) {
        matches = [_current!, ...matches.take(19)];
      }
      _liveQueue = matches;
      queue.add(matches.map((m) => tree.item(m, hindi: hindi)).toList());
      _publish(playbackState.value.processingState);
    } catch (_) {
      /* Browsing failures must not delay or stop an already selected broadcast. */
    }
  }

  void _announce(Match match, int epoch) {
    final sentence = match.status == MatchStatus.upcoming
        ? [
            match.title(),
            hindi ? 'आगामी मैच' : 'Upcoming match',
            match.date,
            match.start,
            match.venue(),
          ].where((s) => s.isNotEmpty).join('. ')
        : [
            match.title(),
            match.result.isEmpty
                ? (hindi ? 'मैच समाप्त' : 'Match finished')
                : match.result,
          ].join('. ');
    speech.add(
      SpeechUtterance(
        sentence,
        onComplete: () => unawaited(_announcementCompleted(epoch)),
      ),
    );
  }

  Future<void> _announcementCompleted(int epoch) async {
    if (!_valid(epoch)) {
      return;
    }
    final next = _interrupt();
    await _silencing;
    if (next == _epoch) {
      _publish(AudioProcessingState.completed);
    }
  }

  Future<void> _tick(int epoch, {Match? initial}) async {
    if (!_valid(epoch) ||
        !_active ||
        _current?.status != MatchStatus.live ||
        _pollEpoch == epoch) {
      return;
    }
    _pollEpoch = epoch;
    final id = _current!.id!;
    final token = CancelToken();
    _request = token;
    try {
      try {
        await settings.load();
      } catch (_) {
        /* Keep the current preferences if storage is unavailable. */
      }
      if (!_valid(epoch)) {
        return;
      }
      if (!_stream && _fingerprint != _voiceFingerprint) {
        _settingsChanged();
        return;
      }
      final match = initial ?? await repository.details(id, token);
      if (!_valid(epoch) || !_active) {
        return;
      }
      _current = match;
      _cache[id] = match;
      mediaItem.add(
        tree
            .item(match, hindi: hindi)
            .copyWith(duration: _stream ? output.duration : null),
      );
      customState.add({
        'offline': false,
        'source': _stream ? 'stream' : 'speech',
      });
      if (match.status != MatchStatus.live) {
        final next = _interrupt();
        await _silencing;
        if (!_valid(next)) {
          return;
        }
        _stream = false;
        await output.configureVoice(
          language,
          settings.speechRate,
          settings.speechVoice,
        );
        if (!_valid(next) || !await output.activate()) {
          return;
        }
        if (!_valid(next)) {
          return;
        }
        _active = true;
        speech.start();
        _publish(AudioProcessingState.ready);
        _announce(match, next);
        return;
      }
      if (_stream) {
        _publish(playbackState.value.processingState);
        return;
      }
      Object? payload;
      bool fetched = true;
      try {
        payload = await repository.commentary(id, token);
      } catch (_) {
        fetched = false;
      }
      if (!_valid(epoch) || !_active) {
        return;
      }
      final parsed = CommentaryBall.parse(payload);
      final balls = engine.plan(id, payload);
      if (parsed.isNotEmpty) {
        engine.observeScore(id, match);
        for (final ball in balls) {
          speech.add(
            SpeechUtterance(
              ball.text,
              onComplete: () => engine.spoken(id, ball.key),
              onDiscard: () => engine.release(id, ball.key),
            ),
          );
        }
      } else {
        final update = engine.planScore(id, match, hindi: hindi);
        if (update != null) {
          final signature = CommentaryEngine.scoreSignature(match);
          speech.add(
            SpeechUtterance(
              update,
              onComplete: () => engine.scoreSpoken(id, signature),
              onDiscard: () => engine.releaseScore(id),
            ),
          );
        }
      }
      if (!fetched) {
        customState.add({'offline': true, 'source': 'speech'});
      }
    } catch (_) {
      if (_valid(epoch) && _active) {
        customState.add({
          'offline': true,
          'source': _stream ? 'stream' : 'speech',
        });
      }
    } finally {
      if (_pollEpoch == epoch) {
        _pollEpoch = null;
      }
    }
  }

  @override
  Future<void> play() {
    final id = _current?.id;
    if (id == null) {
      return _skip(1);
    }
    return playFromMediaId('match:$id');
  }

  @override
  Future<void> pause() async {
    final epoch = _interrupt();
    _publish(AudioProcessingState.ready);
    await _silencing;
    if (epoch == _epoch) {
      _publish(AudioProcessingState.ready);
    }
  }

  @override
  Future<void> stop() async {
    final epoch = _interrupt();
    _stream = false;
    _current = null;
    mediaItem.add(null);
    queue.add([]);
    _liveQueue = [];
    _publish(AudioProcessingState.idle);
    await _silencing;
    if (epoch == _epoch) {
      _publish(AudioProcessingState.idle);
    }
  }

  Future<void> _expired() async {
    final epoch = _interrupt();
    _current = null;
    _stream = false;
    engine.clear();
    _cache.clear();
    _browseCache.clear();
    _liveQueue = [];
    mediaItem.add(null);
    queue.add([]);
    _publish(
      AudioProcessingState.error,
      errorCode: 3,
      errorMessage: signInMessage,
    );
    await _silencing;
    if (epoch == _epoch) {
      _publish(
        AudioProcessingState.error,
        errorCode: 3,
        errorMessage: signInMessage,
      );
    }
  }

  Future<void> _failure() async {
    if (_disposed) {
      return;
    }
    if (!auth.signedIn) {
      await _expired();
      return;
    }
    final epoch = _interrupt();
    _publish(
      AudioProcessingState.error,
      errorCode: 1,
      errorMessage: errorMessage,
    );
    await _silencing;
    if (epoch == _epoch) {
      _publish(
        AudioProcessingState.error,
        errorCode: 1,
        errorMessage: errorMessage,
      );
    }
  }

  @override
  Future<void> skipToNext() => _skip(1);
  @override
  Future<void> skipToPrevious() => _skip(-1);
  Future<void> _skip(int direction) {
    if (!auth.signedIn) {
      return _expired();
    }
    final previous = _current?.id;
    final epoch = _interrupt();
    _active = true;
    _publish(AudioProcessingState.loading);
    return _schedule(epoch, () async {
      final token = CancelToken();
      _request = token;
      List<Match> matches;
      try {
        matches = (await repository.matches(token))
            .where((m) => m.status == MatchStatus.live && m.id != null)
            .take(20)
            .toList();
      } catch (_) {
        matches = _liveQueue;
      }
      if (!_valid(epoch)) {
        return;
      }
      if (matches.isEmpty) {
        throw StateError('No live matches');
      }
      final index = matches.indexWhere((m) => m.id == previous);
      final next = index < 0
          ? (direction > 0 ? 0 : matches.length - 1)
          : (index + direction) % matches.length;
      await _begin(matches[next].id!, epoch);
    });
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index >= 0 && index < queue.value.length) {
      await playFromMediaId(queue.value[index].id);
    }
  }

  @override
  Future<void> seek(Duration position) async {
    if (!_stream || output.duration == null) {
      return;
    }
    final safe = position < Duration.zero
        ? Duration.zero
        : position > output.duration!
        ? output.duration!
        : position;
    try {
      await output.seek(safe);
      _publish(playbackState.value.processingState);
    } catch (_) {
      await _failure();
    }
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) =>
      playFromMediaId(mediaItem.id);
  void _transport(TransportEvent event) {
    if (!_active || _disposed || !_stream) {
      return;
    }
    switch (event.state) {
      case TransportState.error:
        unawaited(_failure());
      case TransportState.completed:
        unawaited(_announcementCompleted(_epoch));
      case TransportState.loading:
        _publish(AudioProcessingState.loading);
      case TransportState.buffering:
        _publish(AudioProcessingState.buffering);
      case TransportState.ready:
        _publish(AudioProcessingState.ready);
      case TransportState.idle:
        break;
    }
  }

  void _focus(FocusEvent event) {
    if (_disposed) {
      return;
    }
    if (event.noisy) {
      unawaited(pause());
      return;
    }
    if (event.begin && _active) {
      final epoch = _interrupt();
      _resumeEpoch = event.resumable ? epoch : null;
      _publish(AudioProcessingState.ready);
    } else if (event.end) {
      final resume = _resumeEpoch;
      _resumeEpoch = null;
      final foregroundAllowed =
          defaultTargetPlatform != TargetPlatform.android ||
          WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
      if (event.resumable && resume == _epoch && foregroundAllowed) {
        unawaited(play());
      }
    }
  }

  void _authChanged() {
    _cache.clear();
    _browseCache.clear();
    _notifyChildren();
    final changedUser = _user != auth.userId;
    _user = auth.userId;
    if (!auth.signedIn) {
      unawaited(_expired());
    } else if (changedUser && _current != null) {
      unawaited(stop());
    } else if (playbackState.value.errorCode == 3) {
      _publish(AudioProcessingState.idle);
    }
  }

  void _settingsChanged() {
    _notifyChildren();
    final fingerprint = _voiceFingerprint;
    if (fingerprint != _fingerprint) {
      _fingerprint = fingerprint;
      if (_active && !_stream) {
        unawaited(play());
      }
    }
  }

  void _notifyChildren() {
    for (final subject in _children.values) {
      subject.add({'revision': ++_revision});
    }
  }

  @override
  ValueStream<Map<String, dynamic>> subscribeToChildren(String parentMediaId) =>
      _children.putIfAbsent(
        parentMediaId,
        () => BehaviorSubject.seeded({'revision': _revision}),
      );
  Future<List<Match>> _browse(String tab) async {
    final user = tab == 'mine' ? auth.userId : null;
    final key = user ?? 'all';
    final cached = _browseCache[key];
    if (cached != null &&
        DateTime.now().difference(cached.time) < browseInterval) {
      return cached.matches;
    }
    final generation = auth.generation;
    final matches = await repository.matches(CancelToken(), userId: user);
    if (!auth.signedIn || auth.generation != generation) {
      return [];
    }
    _browseCache[key] = (time: DateTime.now(), matches: matches);
    for (final match in matches) {
      if (match.id != null) {
        _cache[match.id!] = match;
      }
    }
    return matches;
  }

  @override
  Future<List<MediaItem>> getChildren(
    String parentMediaId, [
    Map<String, dynamic>? options,
  ]) async {
    try {
      await settings.load();
    } catch (_) {
      /* Use current settings. */
    }
    if (!settings.showInCar) {
      return [];
    }
    if (!auth.signedIn) {
      await _expired();
      return [
        MediaItem(
          id: 'signed_out',
          title: signInMessage,
          playable: false,
          artUri: tree.artUri,
        ),
      ];
    }
    if (parentMediaId == MediaTree.root) {
      return tree.folders(settings, hindi: hindi);
    }
    if (!parentMediaId.startsWith('folder:')) {
      return [];
    }
    final tab = parentMediaId.substring(7);
    if (!settings.carTabs.contains(tab)) {
      return [];
    }
    try {
      return tree.children(tab, await _browse(tab), hindi: hindi);
    } catch (_) {
      if (!auth.signedIn) {
        return [
          MediaItem(
            id: 'signed_out',
            title: signInMessage,
            playable: false,
            artUri: tree.artUri,
          ),
        ];
      }
      return [
        MediaItem(
          id: 'unavailable',
          title: hindi
              ? 'मैच लोड नहीं हुए। बाद में प्रयास करें।'
              : 'Matches unavailable. Try again later.',
          playable: false,
          artUri: tree.artUri,
        ),
      ];
    }
  }

  @override
  Future<MediaItem?> getMediaItem(String mediaId) async {
    if (!auth.signedIn) {
      await _expired();
      return null;
    }
    final id = MediaTree.matchId(mediaId);
    if (id == null) {
      return null;
    }
    final generation = auth.generation;
    try {
      final match = _cache[id] ?? await repository.details(id, CancelToken());
      if (!auth.signedIn || auth.generation != generation) {
        return null;
      }
      _cache[id] = match;
      return tree.item(match, hindi: hindi);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<MediaItem>> search(
    String query, [
    Map<String, dynamic>? extras,
  ]) async {
    try {
      await settings.load();
    } catch (_) {}
    if (!auth.signedIn) {
      await _expired();
      return [];
    }
    if (!settings.showInCar) {
      return [];
    }
    try {
      final text = query.toLowerCase();
      final items = <MediaItem>[];
      final ids = <String>{};
      for (final tab in settings.carTabs) {
        for (final item in tree.children(
          tab,
          await _browse(tab),
          hindi: hindi,
        )) {
          if (item.title.toLowerCase().contains(text) && ids.add(item.id)) {
            items.add(item);
          }
          if (items.length == 20) {
            return items;
          }
        }
      }
      return items;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> playFromSearch(
    String query, [
    Map<String, dynamic>? extras,
  ]) async {
    final items = await search(query, extras);
    if (!auth.signedIn) {
      await _expired();
      return;
    }
    if (items.isNotEmpty) {
      await playFromMediaId(items.first.id);
    } else {
      await _failure();
    }
  }

  @override
  Future<dynamic> customAction(
    String name, [
    Map<String, dynamic>? extras,
  ]) async {
    if (name == 'voices') {
      try {
        return await output.voices();
      } catch (_) {
        return <Map<String, String>>[];
      }
    }
    if (name == 'refresh') {
      await _tick(_epoch);
      return null;
    }
    return null;
  }

  Future<void> shutdown() async {
    if (_disposed) {
      return;
    }
    await stop();
    _disposed = true;
    _browseTimer?.cancel();
    auth.removeListener(_authChanged);
    settings.removeListener(_settingsChanged);
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    for (final subject in _children.values) {
      await subject.close();
    }
    await output.dispose();
    await playbackState.close();
    await mediaItem.close();
    await queue.close();
    await customState.close();
    await customEvent.close();
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\audio_output.dart
````text
import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

import 'speech_queue.dart';

enum TransportState { idle, loading, buffering, ready, completed, error }

class TransportEvent {
  const TransportEvent(this.state);
  final TransportState state;
}

class FocusEvent {
  const FocusEvent({
    this.begin = false,
    this.end = false,
    this.noisy = false,
    this.resumable = false,
  });
  final bool begin, end, noisy, resumable;
}

abstract class AudioOutput implements SpeechDriver {
  Stream<TransportEvent> get events;
  Stream<FocusEvent> get focus;
  Duration get position;
  Duration get bufferedPosition;
  Duration? get duration;
  Future<void> initialize();
  Future<bool> activate();
  Future<void> deactivate();
  Future<void> configureVoice(
    String language,
    double rate,
    Map<String, String>? voice,
  );
  Future<List<Map<String, String>>> voices();
  Future<void> loadStream(Uri url);
  void playStream();
  Future<void> keepAlive();
  Future<void> stopPlayer();
  Future<void> seek(Duration position);
  Future<void> dispose();
}

class NativeAudioOutput implements AudioOutput {
  final _player = AudioPlayer(
    handleInterruptions: false,
    handleAudioSessionActivation: false,
  );
  final _tts = FlutterTts();
  AudioSession? _session;
  final _events = StreamController<TransportEvent>.broadcast();
  final _focus = StreamController<FocusEvent>.broadcast();
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  bool _disposed = false;
  int _playerSerial = 0;
  @override
  Stream<TransportEvent> get events => _events.stream;
  @override
  Stream<FocusEvent> get focus => _focus.stream;
  @override
  Duration get position => _player.position;
  @override
  Duration get bufferedPosition => _player.bufferedPosition;
  @override
  Duration? get duration => _player.duration;
  @override
  Future<void> initialize() async {
    await _tts.awaitSpeakCompletion(true);
    if (Platform.isIOS) {
      await _tts.setSharedInstance(true);
      await _tts.autoStopSharedSession(false);
      await _tts.setIosAudioCategory(IosTextToSpeechAudioCategory.playback, [
        IosTextToSpeechAudioCategoryOptions.duckOthers,
      ], IosTextToSpeechAudioMode.spokenAudio);
    }
    _session = await AudioSession.instance;
    await _configureSession();
    _subscriptions.add(
      _player.playerStateStream.listen((state) {
        if (!_disposed) {
          _events.add(
            TransportEvent(switch (state.processingState) {
              ProcessingState.idle => TransportState.idle,
              ProcessingState.loading => TransportState.loading,
              ProcessingState.buffering => TransportState.buffering,
              ProcessingState.ready => TransportState.ready,
              ProcessingState.completed => TransportState.completed,
            }),
          );
        }
      }),
    );
    _subscriptions.add(
      _player.errorStream.listen((error) {
        if (!_disposed) {
          _events.add(const TransportEvent(TransportState.error));
        }
      }),
    );
    _subscriptions.add(
      _session!.becomingNoisyEventStream.listen((_) {
        if (!_disposed) {
          _focus.add(const FocusEvent(noisy: true));
        }
      }),
    );
    _subscriptions.add(
      _session!.interruptionEventStream.listen((event) {
        if (!_disposed) {
          _focus.add(
            FocusEvent(
              begin: event.begin,
              end: !event.begin,
              resumable: event.type != AudioInterruptionType.unknown,
            ),
          );
        }
      }),
    );
  }

  Future<void> _configureSession() async => _session!.configure(
    const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ),
  );
  @override
  Future<bool> activate() async {
    await _configureSession();
    return _session!.setActive(true);
  }

  @override
  Future<void> deactivate() async {
    await _session?.setActive(false);
  }

  @override
  Future<void> configureVoice(
    String language,
    double rate,
    Map<String, String>? voice,
  ) async {
    if (voice == null) {
      await _tts.clearVoice();
    }
    final result = await _tts.setLanguage(
      voice?['locale'] ?? (language == 'hi' ? 'hi-IN' : 'en-IN'),
    );
    if (result == 0) {
      throw StateError('Speech language unavailable');
    }
    await _tts.setSpeechRate(rate);
    if (voice != null) {
      final selected = await _tts.setVoice(voice);
      if (selected == 0) {
        throw StateError('Speech voice unavailable');
      }
    }
  }

  @override
  Future<List<Map<String, String>>> voices() async {
    final result = await _tts.getVoices;
    if (result is! List) {
      return [];
    }
    return [
      for (final item in result)
        if (item is Map &&
            item['name'] is String &&
            item['locale'] is String &&
            !(item['features'] is String &&
                (item['features'] as String)
                    .split('\t')
                    .contains('notInstalled')))
          {
            for (final key in ['name', 'locale', 'identifier'])
              if (item[key] is String) key: item[key] as String,
          },
    ];
  }

  @override
  Future<void> speak(String text) async {
    final result = await _tts.speak(text).timeout(const Duration(minutes: 3));
    if (result == 0) {
      throw StateError('Speech failed');
    }
  }

  @override
  Future<void> stopSpeech() async {
    await _tts.stop();
  }

  @override
  Future<void> loadStream(Uri url) async {
    await _player.setLoopMode(LoopMode.off);
    await _player.setUrl(url.toString());
  }

  @override
  void playStream() {
    final serial = _playerSerial;
    unawaited(
      _player.play().catchError((Object error) {
        if (!_disposed && serial == _playerSerial) {
          _events.add(const TransportEvent(TransportState.error));
        }
      }),
    );
  }

  @override
  Future<void> keepAlive() async {
    if (!Platform.isIOS) {
      return;
    }
    await _player.setLoopMode(LoopMode.one);
    await _player.setAsset('assets/audio/live_keepalive.wav');
    playStream();
  }

  @override
  Future<void> stopPlayer() {
    _playerSerial++;
    return _player.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);
  @override
  Future<void> dispose() async {
    _disposed = true;
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _tts.stop();
    await _player.dispose();
    await deactivate();
    await _events.close();
    await _focus.close();
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\audio_repository.dart
````text
import 'package:dio/dio.dart';

import '../../core/api/api_config.dart';
import '../matches/match_repository.dart';
import '../matches/models/match.dart';

abstract class AudioRepository {
  Future<Match> details(int id, CancelToken token);
  Future<List<Match>> matches(CancelToken token, {String? userId});
  Future<Object?> commentary(int id, CancelToken token);
}

class NetworkAudioRepository implements AudioRepository {
  NetworkAudioRepository(this.repository, this.dio);
  final MatchRepository repository;
  final Dio dio;
  @override
  Future<Match> details(int id, CancelToken token) =>
      repository.details(id, cancelToken: token);
  @override
  Future<List<Match>> matches(CancelToken token, {String? userId}) =>
      repository.list(userId: userId, cancelToken: token);
  @override
  Future<Object?> commentary(int id, CancelToken token) async {
    if (ApiConfig.commentaryEndpoint.isEmpty) {
      return [];
    }
    return (await dio.get<Object?>(
      ApiConfig.endpoint(ApiConfig.commentaryEndpoint),
      queryParameters: {'match': id},
      cancelToken: token,
    )).data;
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\commentary_engine.dart
````text
import '../matches/models/match.dart';

class BallKey implements Comparable<BallKey> {
  const BallKey(this.over, this.ball, {this.innings = 0});
  final int over, ball, innings;
  @override
  int compareTo(BallKey other) => innings != other.innings
      ? innings.compareTo(other.innings)
      : over == other.over
      ? ball.compareTo(other.ball)
      : over.compareTo(other.over);
  @override
  bool operator ==(Object other) =>
      other is BallKey &&
      over == other.over &&
      ball == other.ball &&
      innings == other.innings;
  @override
  int get hashCode => Object.hash(innings, over, ball);
  @override
  String toString() => '$over.$ball';
}

class CommentaryBall {
  const CommentaryBall(this.key, this.text);
  final BallKey key;
  final String text;
  static List<CommentaryBall> parse(Object? payload) {
    final rows = payload is List ? payload : object(payload)['results'];
    if (rows is! List) {
      return [];
    }
    final unique = <BallKey, CommentaryBall>{};
    for (final row in rows) {
      final json = object(row);
      final over = _whole(json['over']);
      final ball = _whole(json['ball']);
      final text = string(json['text']).trim();
      if (over == null ||
          ball == null ||
          over < 0 ||
          over > 10000 ||
          ball < 0 ||
          ball > 99 ||
          text.isEmpty) {
        continue;
      }
      final key = BallKey(over, ball, innings: _whole(json['innings']) ?? 0);
      unique[key] = CommentaryBall(
        key,
        text.length > 800 ? text.substring(0, 800) : text,
      );
    }
    return unique.values.toList()..sort((a, b) => a.key.compareTo(b.key));
  }

  static int? _whole(Object? value) {
    final number = value is num ? value : num.tryParse(string(value));
    return number != null && number.isFinite && number == number.roundToDouble()
        ? number.toInt()
        : null;
  }
}

class _Cursor {
  BallKey? floor, lastSpoken;
  final Set<BallKey> pending = {};
  String? score;
  String? pendingScore;
}

class CommentaryEngine {
  final Map<int, _Cursor> _cursors = {};
  _Cursor _cursor(int id) => _cursors.putIfAbsent(id, _Cursor.new);
  List<CommentaryBall> plan(int id, Object? payload) {
    final parsed = CommentaryBall.parse(payload);
    if (parsed.isEmpty) {
      return [];
    }
    final cursor = _cursor(id);
    // Join a broadcast at its latest ball rather than reading the full innings history.
    cursor.floor ??= parsed.last.key;
    final candidates = parsed
        .where(
          (ball) =>
              ball.key.compareTo(cursor.floor!) >= 0 &&
              (cursor.lastSpoken == null ||
                  ball.key.compareTo(cursor.lastSpoken!) > 0) &&
              !cursor.pending.contains(ball.key),
        )
        .toList();
    final newest = candidates.length > 32
        ? candidates.sublist(candidates.length - 32)
        : candidates;
    cursor.pending.addAll(newest.map((ball) => ball.key));
    return newest;
  }

  void spoken(int id, BallKey key) {
    final c = _cursor(id);
    c.pending.remove(key);
    if (c.lastSpoken == null || key.compareTo(c.lastSpoken!) > 0) {
      c.lastSpoken = key;
    }
  }

  void release(int id, BallKey key) => _cursor(id).pending.remove(key);
  BallKey? lastSpoken(int id) => _cursor(id).lastSpoken;
  void primeScore(int id, Match match) {
    _cursor(id).score ??= scoreSignature(match);
  }

  String? planScore(int id, Match match, {bool hindi = false}) {
    final c = _cursor(id);
    final signature = scoreSignature(match);
    if (signature.isEmpty ||
        signature == c.score ||
        signature == c.pendingScore) {
      return null;
    }
    c.pendingScore = signature;
    return spokenScore(match, hindi: hindi);
  }

  void scoreSpoken(int id, String signature) {
    final c = _cursor(id);
    c.score = signature;
    c.pendingScore = null;
  }

  void releaseScore(int id) {
    _cursor(id).pendingScore = null;
  }

  void observeScore(int id, Match match) {
    _cursor(id).score = scoreSignature(match);
  }

  void clear() => _cursors.clear();
  static String scoreSignature(Match match) => [
    match.score,
    match.team1Score,
    match.team2Score,
  ].where((s) => s.trim().isNotEmpty).join('|');
  static String spokenScore(Match match, {bool hindi = false}) {
    String natural(String score) => score.replaceAllMapped(
      RegExp(r'(\d+)\s*/\s*(\d+)'),
      (m) => hindi ? '${m[1]} रन पर ${m[2]} विकेट' : '${m[1]} for ${m[2]}',
    );
    if (match.score.isNotEmpty) {
      return '${match.title()}. ${natural(match.score)}';
    }
    return [
      if (match.team1Score.isNotEmpty)
        '${match.team1Name} ${natural(match.team1Score)}',
      if (match.team2Score.isNotEmpty)
        '${match.team2Name} ${natural(match.team2Score)}',
    ].join('. ');
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\media_tree.dart
````text
import 'package:audio_service/audio_service.dart';

import '../matches/models/match.dart';
import '../settings/settings_controller.dart';

class MediaTree {
  const MediaTree(this.artUri);
  final Uri artUri;
  static const root = AudioService.browsableRootId;
  static const style = {
    'android.media.browse.CONTENT_STYLE_BROWSABLE_HINT': 1,
    'android.media.browse.CONTENT_STYLE_PLAYABLE_HINT': 1,
    'android.media.browse.CONTENT_STYLE_SUPPORTED': true,
  };
  static int? matchId(String value) =>
      value.startsWith('match:') ? int.tryParse(value.substring(6)) : null;
  static String label(String id, {bool hindi = false}) => switch (id) {
    'live' => hindi ? 'लाइव' : 'Live',
    'upcoming' => hindi ? 'आगामी' : 'Upcoming',
    'results' => hindi ? 'परिणाम' : 'Results',
    'mine' => hindi ? 'मेरे मैच' : 'My Matches',
    _ => id,
  };
  List<MediaItem> folders(SettingsController settings, {bool hindi = false}) =>
      !settings.showInCar
      ? []
      : [
          for (final tab in settings.carTabs)
            MediaItem(
              id: 'folder:$tab',
              title: label(tab, hindi: hindi),
              artUri: artUri,
              playable: false,
              extras: style,
            ),
        ];
  MediaItem item(Match match, {bool hindi = false}) => MediaItem(
    id: 'match:${match.id}',
    title: match.title(),
    artist: match.statusLine().isEmpty
        ? label(
            match.status == MatchStatus.live
                ? 'live'
                : match.status == MatchStatus.upcoming
                ? 'upcoming'
                : 'results',
            hindi: hindi,
          )
        : match.statusLine(),
    album: match.tournament,
    artUri: artUri,
    isLive: match.status == MatchStatus.live,
    extras: style,
  );
  List<MediaItem> children(
    String tab,
    List<Match> matches, {
    bool hindi = false,
  }) => [
    for (final match
        in matches
            .where(
              (m) =>
                  m.id != null &&
                  (tab == 'mine' ||
                      m.status ==
                          switch (tab) {
                            'live' => MatchStatus.live,
                            'upcoming' => MatchStatus.upcoming,
                            _ => MatchStatus.result,
                          }),
            )
            .take(20))
      item(match, hindi: hindi),
  ];
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\mini_player.dart
````text
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import 'audio_bootstrap.dart';
import 'player_screen.dart';

Future<void> audioCommand(
  BuildContext context,
  Future<void> Function() command,
) async {
  try {
    await command();
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.audioError)),
      );
    }
  }
}

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handler = ref.watch(audioHandlerProvider);
    if (handler == null) {
      return const SizedBox.shrink();
    }
    final text = AppLocalizations.of(context)!;
    return StreamBuilder<MediaItem?>(
      stream: handler.mediaItem,
      initialData: handler.mediaItem.value,
      builder: (context, itemSnapshot) {
        final item = itemSnapshot.data;
        if (item == null) {
          return const SizedBox.shrink();
        }
        return StreamBuilder<PlaybackState>(
          stream: handler.playbackState,
          initialData: handler.playbackState.value,
          builder: (context, stateSnapshot) {
            final state = stateSnapshot.data!;
            final loading =
                state.processingState == AudioProcessingState.loading ||
                state.processingState == AudioProcessingState.buffering;
            return Material(
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  children: [
                    if (loading) const LinearProgressIndicator(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).push<void>(
                              MaterialPageRoute(
                                builder: (_) => const PlayerScreen(),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall,
                                  ),
                                  Text(
                                    state.processingState ==
                                            AudioProcessingState.error
                                        ? text.audioError
                                        : item.artist ?? text.waitingCommentary,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: text.previousMatch,
                          onPressed: () =>
                              audioCommand(context, handler.skipToPrevious),
                          icon: const Icon(Icons.skip_previous),
                        ),
                        IconButton(
                          tooltip: state.playing ? text.pause : text.play,
                          onPressed: () => audioCommand(
                            context,
                            state.playing ? handler.pause : handler.play,
                          ),
                          icon: Icon(
                            state.playing ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                        IconButton(
                          tooltip: text.nextMatch,
                          onPressed: () =>
                              audioCommand(context, handler.skipToNext),
                          icon: const Icon(Icons.skip_next),
                        ),
                        IconButton(
                          tooltip: text.stop,
                          onPressed: () => audioCommand(context, handler.stop),
                          icon: const Icon(Icons.close),
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
    );
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\player_screen.dart
````text
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import 'audio_bootstrap.dart';
import 'mini_player.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final handler = ref.watch(audioHandlerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(text.nowPlaying)),
      body: SafeArea(
        child: handler == null
            ? Center(child: Text(text.audioNotReady))
            : StreamBuilder<MediaItem?>(
                stream: handler.mediaItem,
                initialData: handler.mediaItem.value,
                builder: (context, itemSnapshot) {
                  final item = itemSnapshot.data;
                  if (item == null) {
                    return Center(child: Text(text.waitingCommentary));
                  }
                  return StreamBuilder<PlaybackState>(
                    stream: handler.playbackState,
                    initialData: handler.playbackState.value,
                    builder: (context, stateSnapshot) {
                      final state = stateSnapshot.data!;
                      return StreamBuilder<dynamic>(
                        stream: handler.customState,
                        builder: (context, customSnapshot) {
                          final info = customSnapshot.data;
                          final offline =
                              info is Map && info['offline'] == true;
                          final streaming =
                              info is Map && info['source'] == 'stream';
                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    width: 180,
                                    height: 180,
                                    excludeFromSemantics: true,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  item.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
                                  textAlign: TextAlign.center,
                                ),
                                if (item.artist != null)
                                  Text(
                                    item.artist!,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                if (item.album != null &&
                                    item.album!.isNotEmpty)
                                  Text(
                                    item.album!,
                                    textAlign: TextAlign.center,
                                  ),
                                const SizedBox(height: 16),
                                Text(
                                  streaming
                                      ? text.streamSource
                                      : text.speechSource,
                                  textAlign: TextAlign.center,
                                ),
                                if (offline)
                                  Semantics(
                                    liveRegion: true,
                                    child: Text(
                                      text.audioOffline,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                if (state.processingState ==
                                        AudioProcessingState.loading ||
                                    state.processingState ==
                                        AudioProcessingState.buffering)
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        const LinearProgressIndicator(),
                                        Text(text.audioLoading),
                                      ],
                                    ),
                                  ),
                                if (state.processingState ==
                                    AudioProcessingState.error)
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      text.audioError,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                const SizedBox(height: 16),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 12,
                                  children: [
                                    IconButton(
                                      tooltip: text.previousMatch,
                                      onPressed: () => audioCommand(
                                        context,
                                        handler.skipToPrevious,
                                      ),
                                      icon: const Icon(Icons.skip_previous),
                                      iconSize: 40,
                                    ),
                                    IconButton(
                                      tooltip: state.playing
                                          ? text.pause
                                          : text.play,
                                      onPressed: () => audioCommand(
                                        context,
                                        state.playing
                                            ? handler.pause
                                            : handler.play,
                                      ),
                                      icon: Icon(
                                        state.playing
                                            ? Icons.pause_circle
                                            : Icons.play_circle,
                                      ),
                                      iconSize: 64,
                                    ),
                                    IconButton(
                                      tooltip: text.nextMatch,
                                      onPressed: () => audioCommand(
                                        context,
                                        handler.skipToNext,
                                      ),
                                      icon: const Icon(Icons.skip_next),
                                      iconSize: 40,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                OutlinedButton.icon(
                                  onPressed: () =>
                                      audioCommand(context, handler.stop),
                                  icon: const Icon(Icons.stop),
                                  label: Text(text.stop),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\speech_queue.dart
````text
import 'dart:async';
import 'dart:collection';

abstract class SpeechDriver {
  Future<void> speak(String text);
  Future<void> stopSpeech();
}

class SpeechUtterance {
  SpeechUtterance(this.text, {this.onComplete, this.onDiscard});
  final String text;
  final void Function()? onComplete, onDiscard;
}

class SpeechQueue {
  SpeechQueue(this.driver, {required this.onError});
  final SpeechDriver driver;
  final void Function(Object error) onError;
  final Queue<SpeechUtterance> _pending = Queue();
  bool enabled = false;
  int _epoch = 0;
  Future<void>? _draining;
  Completer<void>? _cancel;
  Future<void> _stopping = Future.value();
  bool get isEmpty => _pending.isEmpty && _draining == null;
  void start() {
    enabled = true;
    _kick();
  }

  void add(SpeechUtterance item) {
    if (!enabled) {
      item.onDiscard?.call();
      return;
    }
    if (_pending.length >= 32) {
      _pending.removeFirst().onDiscard?.call();
    }
    _pending.add(item);
    _kick();
  }

  void _kick() {
    if (_draining != null || !enabled || _pending.isEmpty) {
      return;
    }
    final epoch = _epoch;
    _draining = _drain(epoch).whenComplete(() {
      _draining = null;
      _kick();
    });
  }

  Future<void> _drain(int epoch) async {
    // Give _kick time to install the drain future even for synchronous driver failures.
    await Future<void>.value();
    while (enabled && epoch == _epoch && _pending.isNotEmpty) {
      final item = _pending.removeFirst();
      final cancel = Completer<void>();
      _cancel = cancel;
      try {
        await Future.any<void>([driver.speak(item.text), cancel.future]);
        if (epoch == _epoch && enabled && !cancel.isCompleted) {
          item.onComplete?.call();
        } else {
          item.onDiscard?.call();
        }
      } catch (error) {
        item.onDiscard?.call();
        if (epoch == _epoch) {
          enabled = false;
          while (_pending.isNotEmpty) {
            _pending.removeFirst().onDiscard?.call();
          }
          onError(error);
        }
        return;
      } finally {
        if (_cancel == cancel) {
          _cancel = null;
        }
      }
    }
  }

  Future<void> stop() {
    enabled = false;
    _epoch++;
    while (_pending.isNotEmpty) {
      _pending.removeFirst().onDiscard?.call();
    }
    final cancel = _cancel;
    if (cancel != null && !cancel.isCompleted) {
      cancel.complete();
    }
    final drain = _draining;
    _stopping = _stopping.catchError((Object _) {}).then((_) async {
      await driver.stopSpeech();
      await drain;
    });
    return _stopping;
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\audio\voice_picker_tile.dart
````text
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../settings/settings_controller.dart';
import 'audio_bootstrap.dart';

class VoicePickerTile extends ConsumerStatefulWidget {
  const VoicePickerTile({super.key});
  @override
  ConsumerState<VoicePickerTile> createState() => _VoicePickerTileState();
}

class _VoicePickerTileState extends ConsumerState<VoicePickerTile> {
  bool loading = false;
  Future<void> select() async {
    final text = AppLocalizations.of(context)!;
    final handler = ref.read(audioHandlerProvider);
    if (handler == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(text.audioNotReady)));
      return;
    }
    setState(() => loading = true);
    try {
      final settings = ref.read(settingsProvider);
      final language = settings.language == 'system'
          ? Localizations.localeOf(context).languageCode
          : settings.language;
      final raw = await handler.customAction('voices');
      if (!mounted) {
        return;
      }
      final voices = <Map<String, String>>[];
      final seen = <String>{};
      if (raw is List) {
        for (final item in raw) {
          if (item is Map &&
              item['name'] is String &&
              item['locale'] is String) {
            final locale = (item['locale'] as String)
                .replaceAll('_', '-')
                .toLowerCase();
            final voice = {
              for (final key in ['name', 'locale', 'identifier'])
                if (item[key] is String) key: item[key] as String,
            };
            if ((locale == language || locale.startsWith('$language-')) &&
                seen.add(jsonEncode(voice))) {
              voices.add(voice);
            }
          }
        }
      }
      setState(() => loading = false);
      final selected = await showModalBottomSheet<Map<String, String>>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) => FractionallySizedBox(
          heightFactor: 0.7,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                text.chooseVoice,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ListTile(
                title: Text(text.voiceDefault),
                leading: const Icon(Icons.settings_voice),
                onTap: () => Navigator.pop(context, <String, String>{}),
              ),
              if (voices.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(text.voicesUnavailable),
                ),
              for (final voice in voices)
                ListTile(
                  title: Text(voice['name']!),
                  subtitle: Text(voice['locale']!),
                  onTap: () => Navigator.pop(context, voice),
                ),
            ],
          ),
        ),
      );
      if (selected != null) {
        if (mounted) {
          setState(() => loading = true);
        }
        await settings.update(
          voice: selected.isEmpty ? null : selected,
          resetVoice: selected.isEmpty,
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(text.saveError)));
      }
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(text.voice),
      subtitle: Text(
        settings.speechVoice == null
            ? text.systemVoice
            : '${settings.speechVoice!['name']} · ${settings.speechVoice!['locale']}',
      ),
      trailing: loading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            )
          : const Icon(Icons.chevron_right),
      onTap: loading ? null : select,
    );
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\auth\auth_controller.dart
````text
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
    token = null;
    userId = null;
    try {
      final raw = await storage.read(key: 'session');
      if (raw != null) {
        final value = jsonDecode(raw);
        if (value is Map &&
            value['token'] is String &&
            value['userId'] is String &&
            (value['token'] as String).isNotEmpty &&
            (value['userId'] as String).isNotEmpty) {
          // Rewrite once per restore to migrate existing iOS records to the configured accessibility.
          await storage.write(key: 'session', value: raw);
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\auth\login_screen.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_downloads.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_external.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_library_screen.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_models.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_platform.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_screen.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_session.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_store.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_tab_view.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\browser\browser_urls.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_controller.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_format.dart
````text
String mediaDuration(int seconds) {
  final duration = Duration(seconds: seconds);
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return duration.inHours > 0
      ? '${duration.inHours}:$minutes:$secs'
      : '$minutes:$secs';
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_library.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_permission_screen.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_screen.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_video.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\gallery\gallery_viewer.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\home_screen.dart
````text
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../audio/mini_player.dart';
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
            const MiniPlayer(),
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\match_card.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\match_repository.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\matches_screen.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\matches\models\match.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\match_details\match_details_screen.dart
````text
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

import '../audio/audio_bootstrap.dart';
import '../audio/mini_player.dart';

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
                        onPressed: () => audioCommand(context, () async {
                          final handler = ref.read(audioHandlerProvider);
                          if (handler == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(text.audioNotReady)),
                            );
                            return;
                          }
                          if (Platform.isAndroid) {
                            await Permission.notification.request();
                          }
                          await handler.playFromMediaId('match:${match.id}');
                        }),
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\settings\settings_controller.dart
````text
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
  Map<String, String>? speechVoice;
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
      speechVoice = null;
      final savedVoice = value['speechVoice'];
      if (savedVoice is Map &&
          savedVoice['name'] is String &&
          savedVoice['locale'] is String) {
        speechVoice = {
          for (final key in ['name', 'locale', 'identifier'])
            if (savedVoice[key] is String) key: savedVoice[key] as String,
        };
      }
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
    Map<String, String>? voice,
    bool resetVoice = false,
    bool? car,
    List<String>? tabs,
  }) async {
    if (locale != null && !['system', 'en', 'hi'].contains(locale) ||
        listInterval != null && ![30, 60, 120, 300].contains(listInterval) ||
        detailInterval != null && ![30, 60, 120].contains(detailInterval) ||
        rate != null && (!rate.isFinite || rate < 0.2 || rate > 1)) {
      throw ArgumentError('Unsupported settings value');
    }
    if (voice != null &&
        ((voice['name'] ?? '').isEmpty || (voice['locale'] ?? '').isEmpty)) {
      throw ArgumentError('A voice needs a name and locale');
    }
    final nextVoice = resetVoice || locale != null && locale != language
        ? null
        : voice ?? speechVoice;
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
      'speechVoice': nextVoice,
      'showInCar': car ?? showInCar,
      'carTabs': nextTabs,
    };
    await preferences.setString(key, jsonEncode(next));
    theme = themeMode ?? theme;
    language = locale ?? language;
    listSeconds = listInterval ?? listSeconds;
    detailSeconds = detailInterval ?? detailSeconds;
    speechRate = rate ?? speechRate;
    speechVoice = nextVoice == null ? null : Map.of(nextVoice);
    showInCar = car ?? showInCar;
    carTabs = List.of(nextTabs);
    notifyListeners();
  }
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\features\settings\settings_screen.dart
````text
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../audio/voice_picker_tile.dart';
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
            const VoicePickerTile(),
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_en.arb
````text
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
  "privateTabs": "Private tabs",
  "audioNotReady": "Audio could not be initialized. Restart CP Drive and try again.",
  "audioError": "Commentary could not be played. Check your connection, stream and installed speech voices, then retry.",
  "audioSignedOut": "Sign in to CP Drive on your phone when you are parked.",
  "nowPlaying": "Now playing",
  "speechSource": "Spoken commentary",
  "streamSource": "Live audio stream",
  "waitingCommentary": "Listening for the next update",
  "audioOffline": "Connection interrupted. Waiting for the next update.",
  "chooseVoice": "Choose an installed voice",
  "voicesUnavailable": "No installed voices were found for this language.",
  "voiceDefault": "Use the system default",
  "listenAgain": "Listen again",
  "audioLoading": "Connecting to commentary",
  "nextMatch": "Next live match",
  "previousMatch": "Previous live match",
  "noLiveAudio": "No live matches are available to play."
}
````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_hi.arb
````text
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
  "privateTabs": "निजी टैब",
  "audioNotReady": "ऑडियो शुरू नहीं हुआ। CP Drive पुनः शुरू करके प्रयास करें।",
  "audioError": "कमेंट्री नहीं चली। कनेक्शन, स्ट्रीम और स्थापित आवाज़ें जाँचकर फिर प्रयास करें।",
  "audioSignedOut": "पार्क करने के बाद अपने फ़ोन पर CP Drive में साइन इन करें।",
  "nowPlaying": "अभी चल रहा है",
  "speechSource": "बोली गई कमेंट्री",
  "streamSource": "लाइव ऑडियो स्ट्रीम",
  "waitingCommentary": "अगले अपडेट की प्रतीक्षा",
  "audioOffline": "कनेक्शन बाधित है। अगले अपडेट की प्रतीक्षा है।",
  "chooseVoice": "स्थापित आवाज़ चुनें",
  "voicesUnavailable": "इस भाषा की कोई स्थापित आवाज़ नहीं मिली।",
  "voiceDefault": "सिस्टम की डिफ़ॉल्ट आवाज़",
  "listenAgain": "फिर सुनें",
  "audioLoading": "कमेंट्री से जुड़ रहा है",
  "nextMatch": "अगला लाइव मैच",
  "previousMatch": "पिछला लाइव मैच",
  "noLiveAudio": "चलाने के लिए कोई लाइव मैच उपलब्ध नहीं है।"
}
````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_localizations_en.dart
````text
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

  @override
  String get audioNotReady =>
      'Audio could not be initialized. Restart CP Drive and try again.';

  @override
  String get audioError =>
      'Commentary could not be played. Check your connection, stream and installed speech voices, then retry.';

  @override
  String get audioSignedOut =>
      'Sign in to CP Drive on your phone when you are parked.';

  @override
  String get nowPlaying => 'Now playing';

  @override
  String get speechSource => 'Spoken commentary';

  @override
  String get streamSource => 'Live audio stream';

  @override
  String get waitingCommentary => 'Listening for the next update';

  @override
  String get audioOffline =>
      'Connection interrupted. Waiting for the next update.';

  @override
  String get chooseVoice => 'Choose an installed voice';

  @override
  String get voicesUnavailable =>
      'No installed voices were found for this language.';

  @override
  String get voiceDefault => 'Use the system default';

  @override
  String get listenAgain => 'Listen again';

  @override
  String get audioLoading => 'Connecting to commentary';

  @override
  String get nextMatch => 'Next live match';

  @override
  String get previousMatch => 'Previous live match';

  @override
  String get noLiveAudio => 'No live matches are available to play.';
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_localizations_hi.dart
````text
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

  @override
  String get audioNotReady =>
      'ऑडियो शुरू नहीं हुआ। CP Drive पुनः शुरू करके प्रयास करें।';

  @override
  String get audioError =>
      'कमेंट्री नहीं चली। कनेक्शन, स्ट्रीम और स्थापित आवाज़ें जाँचकर फिर प्रयास करें।';

  @override
  String get audioSignedOut =>
      'पार्क करने के बाद अपने फ़ोन पर CP Drive में साइन इन करें।';

  @override
  String get nowPlaying => 'अभी चल रहा है';

  @override
  String get speechSource => 'बोली गई कमेंट्री';

  @override
  String get streamSource => 'लाइव ऑडियो स्ट्रीम';

  @override
  String get waitingCommentary => 'अगले अपडेट की प्रतीक्षा';

  @override
  String get audioOffline => 'कनेक्शन बाधित है। अगले अपडेट की प्रतीक्षा है।';

  @override
  String get chooseVoice => 'स्थापित आवाज़ चुनें';

  @override
  String get voicesUnavailable => 'इस भाषा की कोई स्थापित आवाज़ नहीं मिली।';

  @override
  String get voiceDefault => 'सिस्टम की डिफ़ॉल्ट आवाज़';

  @override
  String get listenAgain => 'फिर सुनें';

  @override
  String get audioLoading => 'कमेंट्री से जुड़ रहा है';

  @override
  String get nextMatch => 'अगला लाइव मैच';

  @override
  String get previousMatch => 'पिछला लाइव मैच';

  @override
  String get noLiveAudio => 'चलाने के लिए कोई लाइव मैच उपलब्ध नहीं है।';
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_localizations.dart
````text
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

  /// No description provided for @audioNotReady.
  ///
  /// In en, this message translates to:
  /// **'Audio could not be initialized. Restart CP Drive and try again.'**
  String get audioNotReady;

  /// No description provided for @audioError.
  ///
  /// In en, this message translates to:
  /// **'Commentary could not be played. Check your connection, stream and installed speech voices, then retry.'**
  String get audioError;

  /// No description provided for @audioSignedOut.
  ///
  /// In en, this message translates to:
  /// **'Sign in to CP Drive on your phone when you are parked.'**
  String get audioSignedOut;

  /// No description provided for @nowPlaying.
  ///
  /// In en, this message translates to:
  /// **'Now playing'**
  String get nowPlaying;

  /// No description provided for @speechSource.
  ///
  /// In en, this message translates to:
  /// **'Spoken commentary'**
  String get speechSource;

  /// No description provided for @streamSource.
  ///
  /// In en, this message translates to:
  /// **'Live audio stream'**
  String get streamSource;

  /// No description provided for @waitingCommentary.
  ///
  /// In en, this message translates to:
  /// **'Listening for the next update'**
  String get waitingCommentary;

  /// No description provided for @audioOffline.
  ///
  /// In en, this message translates to:
  /// **'Connection interrupted. Waiting for the next update.'**
  String get audioOffline;

  /// No description provided for @chooseVoice.
  ///
  /// In en, this message translates to:
  /// **'Choose an installed voice'**
  String get chooseVoice;

  /// No description provided for @voicesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No installed voices were found for this language.'**
  String get voicesUnavailable;

  /// No description provided for @voiceDefault.
  ///
  /// In en, this message translates to:
  /// **'Use the system default'**
  String get voiceDefault;

  /// No description provided for @listenAgain.
  ///
  /// In en, this message translates to:
  /// **'Listen again'**
  String get listenAgain;

  /// No description provided for @audioLoading.
  ///
  /// In en, this message translates to:
  /// **'Connecting to commentary'**
  String get audioLoading;

  /// No description provided for @nextMatch.
  ///
  /// In en, this message translates to:
  /// **'Next live match'**
  String get nextMatch;

  /// No description provided for @previousMatch.
  ///
  /// In en, this message translates to:
  /// **'Previous live match'**
  String get previousMatch;

  /// No description provided for @noLiveAudio.
  ///
  /// In en, this message translates to:
  /// **'No live matches are available to play.'**
  String get noLiveAudio;
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\test\audio_test.dart
````text
import 'dart:async';
import 'dart:ui' show AppLifecycleState;

import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:drive/features/audio/audio_handler.dart';
import 'package:drive/features/audio/audio_output.dart';
import 'package:drive/features/audio/audio_repository.dart';
import 'package:drive/features/audio/commentary_engine.dart';
import 'package:drive/features/audio/media_tree.dart';
import 'package:drive/features/audio/speech_queue.dart';
import 'package:drive/features/auth/auth_controller.dart';
import 'package:drive/features/matches/models/match.dart';
import 'package:drive/features/settings/settings_controller.dart';

Match fixture(
  int id, {
  String status = 'Live',
  String score = '100/2',
  String? stream,
  String result = '',
}) => Match.fromJson({
  'id': id,
  'match_status': status,
  'score': score,
  'result': result,
  'stream_url': stream,
  'date': '2026-10-16',
  'start': '10:00:00',
  'rawdata': {
    'team1': {'name': 'Team $id'},
    'team2': {'name': 'Visitors'},
    'tournament': {'title': 'Cup'},
    'ground': {'title': 'Oval', 'city': 'London'},
  },
});

class FakeAudioRepository extends AudioRepository {
  final records = <int, Match>{1: fixture(1), 2: fixture(2)};
  Object? balls = [
    {'over': 1, 'ball': 1, 'text': 'One run'},
    {'over': 1, 'ball': 2, 'text': 'Four runs'},
  ];
  bool commentaryFails = false, detailsFail = false;
  int detailCalls = 0, commentaryCalls = 0;
  Completer<Match>? delayed;
  Completer<List<Match>>? matchesDelayed;
  @override
  Future<Match> details(int id, CancelToken token) async {
    detailCalls++;
    if (detailsFail) {
      throw StateError('Offline');
    }
    if (delayed != null) {
      return Future.any([
        delayed!.future,
        token.whenCancel.then<Match>((error) => throw error),
      ]);
    }
    return records[id]!;
  }

  @override
  Future<List<Match>> matches(CancelToken token, {String? userId}) async =>
      matchesDelayed == null
      ? records.values.toList()
      : Future.any([
          matchesDelayed!.future,
          token.whenCancel.then<List<Match>>((error) => throw error),
        ]);
  @override
  Future<Object?> commentary(int id, CancelToken token) async {
    commentaryCalls++;
    if (commentaryFails) {
      throw StateError('Offline');
    }
    return balls;
  }
}

class FakeAudioOutput extends AudioOutput {
  final transport = StreamController<TransportEvent>.broadcast();
  final interruptions = StreamController<FocusEvent>.broadcast();
  final utterances = <String>[];
  final pending = <Completer<void>>[];
  bool autoComplete = true, allowed = true;
  int speaking = 0,
      maxSpeaking = 0,
      streamPlays = 0,
      stops = 0,
      keepAlives = 0,
      activations = 0;
  Uri? loaded;
  double? configuredRate;
  Map<String, String>? configuredVoice;
  @override
  Stream<TransportEvent> get events => transport.stream;
  @override
  Stream<FocusEvent> get focus => interruptions.stream;
  @override
  Duration position = Duration.zero;
  @override
  Duration bufferedPosition = Duration.zero;
  @override
  Duration? duration;
  @override
  Future<void> initialize() async {}
  @override
  Future<bool> activate() async {
    activations++;
    return allowed;
  }

  @override
  Future<void> deactivate() async {}
  @override
  Future<void> configureVoice(
    String language,
    double rate,
    Map<String, String>? voice,
  ) async {
    configuredRate = rate;
    configuredVoice = voice;
  }

  @override
  Future<List<Map<String, String>>> voices() async => [
    {'name': 'Test voice', 'locale': 'en-IN'},
  ];
  @override
  Future<void> loadStream(Uri url) async {
    loaded = url;
    duration = const Duration(hours: 1);
  }

  @override
  void playStream() {
    streamPlays++;
  }

  @override
  Future<void> keepAlive() async {
    keepAlives++;
  }

  @override
  Future<void> stopPlayer() async {
    stops++;
  }

  @override
  Future<void> seek(Duration value) async {
    position = value;
  }

  @override
  Future<void> speak(String text) async {
    utterances.add(text);
    speaking++;
    if (speaking > maxSpeaking) {
      maxSpeaking = speaking;
    }
    final completer = Completer<void>();
    pending.add(completer);
    if (autoComplete) {
      completer.complete();
    }
    try {
      await completer.future;
    } finally {
      speaking--;
      pending.remove(completer);
    }
  }

  void complete() {
    if (pending.isNotEmpty && !pending.first.isCompleted) {
      pending.first.complete();
    }
  }

  @override
  Future<void> stopSpeech() async {
    for (final c in List.of(pending)) {
      if (!c.isCompleted) {
        c.complete();
      }
    }
  }

  @override
  Future<void> dispose() async {
    await stopSpeech();
    await transport.close();
    await interruptions.close();
  }
}

Future<void> flush() async {
  for (var i = 0; i < 6; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SettingsController settings;
  late AuthController auth;
  late FakeAudioRepository repository;
  late FakeAudioOutput output;
  CPDriveAudioHandler? handler;
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    FlutterSecureStorage.setMockInitialValues({});
    settings = SettingsController(SharedPreferencesAsync());
    auth = AuthController(const FlutterSecureStorage())
      ..token = 'test-token'
      ..userId = '42'
      ..ready = true;
    repository = FakeAudioRepository();
    output = FakeAudioOutput();
  });
  tearDown(() async {
    await handler?.shutdown();
    handler = null;
    auth.dispose();
    settings.dispose();
  });
  CPDriveAudioHandler create() => handler = CPDriveAudioHandler(
    auth: auth,
    settings: settings,
    repository: repository,
    output: output,
    tree: MediaTree(Uri.file('/logo.png')),
  );
  test('commentary parsing tolerates malformed rows, sorts balls numerically and deduplicates', () {
    final parsed = CommentaryBall.parse([
      null,
      {'over': 10, 'ball': 1, 'text': 'Ten'},
      {'over': '2', 'ball': 6.0, 'text': 'Two'},
      {'over': 10, 'ball': 1, 'text': 'Corrected ten'},
      {'over': -1, 'ball': 1, 'text': 'invalid'},
      {'over': 3, 'ball': 1, 'text': null},
    ]);
    expect(parsed.map((b) => b.key.toString()), ['2.6', '10.1']);
    expect(parsed.last.text, 'Corrected ten');
    expect(CommentaryBall.parse({'results': false}), isEmpty);
  });
  test('joining starts at newest ball and committed deliveries are not spoken twice', () {
    final engine = CommentaryEngine();
    final first = engine.plan(1, repository.balls);
    expect(first.single.key, const BallKey(1, 2));
    expect(engine.plan(1, repository.balls), isEmpty);
    engine.spoken(1, first.single.key);
    final next = engine.plan(1, [
      {'over': 1, 'ball': 2, 'text': 'Four runs'},
      {'over': 1, 'ball': 3, 'text': 'Wicket'},
    ]);
    expect(next.single.key, const BallKey(1, 3));
    engine.spoken(1, next.single.key);
    expect(engine.lastSpoken(1), const BallKey(1, 3));
  });
  test('discarded or interrupted balls are eligible on resume, and innings keys can reset overs', () {
    final engine = CommentaryEngine();
    final ball = engine.plan(1, [
      {'innings': 1, 'over': 19, 'ball': 6, 'text': 'End'},
    ]).single;
    engine.release(1, ball.key);
    expect(
      engine.plan(1, [
        {'innings': 1, 'over': 19, 'ball': 6, 'text': 'End'},
      ]).length,
      1,
    );
    engine.spoken(1, ball.key);
    final next = engine.plan(1, [
      {'innings': 2, 'over': 0, 'ball': 1, 'text': 'New innings'},
    ]);
    expect(next.single.key.innings, 2);
  });
  test('score fallback speaks changed real scores without inventing missing values', () {
    final engine = CommentaryEngine();
    engine.primeScore(1, fixture(1));
    expect(engine.planScore(1, fixture(1)), isNull);
    final match = fixture(1, score: '120/3 after 14.2 overs');
    expect(engine.planScore(1, match), contains('120 for 3 after 14.2 overs'));
    expect(engine.planScore(1, match), isNull);
    engine.releaseScore(1);
    expect(engine.planScore(1, match), isNotNull);
    engine.scoreSpoken(1, CommentaryEngine.scoreSignature(match));
    expect(engine.planScore(1, match), isNull);
    expect(CommentaryEngine.spokenScore(Match.fromJson({})), isEmpty);
  });
  test(
    'speech queue runs one utterance at a time and cancels unspoken work',
    () async {
      output.autoComplete = false;
      var completed = 0;
      var discarded = 0;
      final queue = SpeechQueue(output, onError: (error) => fail('$error'));
      queue.start();
      queue.add(
        SpeechUtterance(
          'first',
          onComplete: () => completed++,
          onDiscard: () => discarded++,
        ),
      );
      queue.add(SpeechUtterance('second', onDiscard: () => discarded++));
      await flush();
      expect(output.utterances, ['first']);
      expect(output.maxSpeaking, 1);
      await queue.stop();
      expect(completed, 0);
      expect(discarded, 2);
      queue.start();
      queue.add(SpeechUtterance('resumed', onComplete: () => completed++));
      await flush();
      output.complete();
      await flush();
      expect(completed, 1);
      expect(output.maxSpeaking, 1);
      await queue.stop();
      await output.dispose();
    },
  );
  test(
    'speech queue recovers after driver errors without retaining pending work',
    () async {
      output.autoComplete = false;
      var errors = 0;
      final queue = SpeechQueue(output, onError: (_) => errors++);
      queue.start();
      queue.add(SpeechUtterance('fails'));
      await flush();
      output.pending.first.completeError(StateError('TTS failed'));
      await flush();
      expect(errors, 1);
      expect(queue.enabled, false);
      output.autoComplete = true;
      queue.start();
      queue.add(SpeechUtterance('retry'));
      await flush();
      expect(output.utterances.last, 'retry');
      await queue.stop();
      await output.dispose();
    },
  );
  test(
    'media tree respects tab selection/order, car visibility and 20-item cap',
    () async {
      final tree = MediaTree(Uri.file('/logo.png'));
      await settings.update(tabs: ['mine', 'live']);
      expect(tree.folders(settings).map((i) => i.id), [
        'folder:mine',
        'folder:live',
      ]);
      expect(
        tree.children('live', List.generate(30, (i) => fixture(i))).length,
        20,
      );
      expect(
        tree
            .children('results', [fixture(1), fixture(2, status: 'Finished')])
            .single
            .id,
        'match:2',
      );
      await settings.update(car: false);
      expect(tree.folders(settings), isEmpty);
      expect(tree.item(fixture(1)).artUri?.scheme, 'file');
    },
  );
  test('live TTS remains playing between balls, speaks only new deliveries and updates metadata', () async {
    final audio = create();
    await audio.playFromMediaId('match:1');
    await flush();
    expect(audio.playbackState.value.playing, true);
    expect(output.utterances.where((text) => text == 'Four runs').length, 1);
    expect(output.utterances.contains('One run'), false);
    expect(output.maxSpeaking, 1);
    await audio.customAction('refresh');
    await flush();
    expect(output.utterances.where((text) => text == 'Four runs').length, 1);
    repository.records[1] = fixture(1, score: '104/2');
    repository.balls = [
      {'over': 1, 'ball': 2, 'text': 'Four runs'},
      {'over': 1, 'ball': 3, 'text': 'A single'},
    ];
    await audio.customAction('refresh');
    await flush();
    expect(output.utterances.last, 'A single');
    expect(audio.mediaItem.value?.artist, '104/2');
    expect(audio.playbackState.value.playing, true);
  });
  test('empty or failed commentary falls back once per score change and retains listening', () async {
    repository.balls = [];
    final audio = create();
    await audio.playFromMediaId('match:1');
    await flush();
    final initial = output.utterances.length;
    repository.records[1] = fixture(1, score: '105/3');
    repository.commentaryFails = true;
    await audio.customAction('refresh');
    await flush();
    expect(output.utterances.length, initial + 1);
    expect(output.utterances.last, contains('105 for 3'));
    await audio.customAction('refresh');
    await flush();
    expect(output.utterances.length, initial + 1);
    expect(audio.playbackState.value.playing, true);
    expect((audio.customState.value as Map)['offline'], true);
  });
  test('pause interrupts active speech and resume requeues an unspoken latest ball', () async {
    output.autoComplete = false;
    final audio = create();
    await audio.playFromMediaId('match:1');
    await flush();
    expect(output.utterances.length, 1);
    await audio.pause();
    expect(audio.playbackState.value.playing, false);
    output.autoComplete = true;
    await audio.play();
    await flush();
    expect(output.utterances.where((text) => text == 'Four runs').length, 1);
    expect(output.maxSpeaking, 1);
    await audio.stop();
    expect(audio.mediaItem.value, isNull);
    expect(
      audio.playbackState.value.processingState,
      AudioProcessingState.idle,
    );
  });
  test('stream URLs use just-audio output and never speak TTS balls', () async {
    repository.records[1] = fixture(1, stream: 'https://example.com/live.mp3');
    final audio = create();
    await audio.playFromMediaId('match:1');
    await flush();
    expect(output.loaded?.path, '/live.mp3');
    expect(output.streamPlays, 1);
    expect(output.utterances, isEmpty);
    expect(repository.commentaryCalls, 0);
    await audio.seek(const Duration(hours: 2));
    expect(output.position, const Duration(hours: 1));
    output.transport.add(const TransportEvent(TransportState.buffering));
    await flush();
    expect(
      audio.playbackState.value.processingState,
      AudioProcessingState.buffering,
    );
    expect(audio.playbackState.value.playing, true);
  });
  test(
    'skip next and previous use live matches and share the same handler',
    () async {
      final audio = create();
      await audio.playFromMediaId('match:1');
      await audio.skipToNext();
      expect(audio.mediaItem.value?.id, 'match:2');
      await audio.skipToPrevious();
      expect(audio.mediaItem.value?.id, 'match:1');
    },
  );
  test(
    'sign-out stops audio, clears metadata and reports authentication error 3',
    () async {
      output.autoComplete = false;
      final audio = create();
      await audio.playFromMediaId('match:1');
      await auth.signOut();
      await flush();
      expect(audio.playbackState.value.playing, false);
      expect(audio.playbackState.value.errorCode, 3);
      expect(audio.mediaItem.value, isNull);
      final children = await audio.getChildren(MediaTree.root);
      expect(
        children.single.title,
        'Sign in to CP Drive on your phone when you are parked.',
      );
    },
  );
  test('headphone disconnection pauses; transient focus loss resumes only without a manual pause', () async {
    TestWidgetsFlutterBinding.ensureInitialized()
        .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final audio = create();
    await audio.playFromMediaId('match:1');
    output.interruptions.add(const FocusEvent(noisy: true));
    await flush();
    expect(audio.playbackState.value.playing, false);
    await audio.play();
    output.interruptions.add(const FocusEvent(begin: true, resumable: true));
    await flush();
    expect(audio.playbackState.value.playing, false);
    output.interruptions.add(const FocusEvent(end: true, resumable: true));
    await flush();
    expect(audio.playbackState.value.playing, true);
    output.interruptions.add(const FocusEvent(begin: true, resumable: true));
    await flush();
    await audio.pause();
    output.interruptions.add(const FocusEvent(end: true, resumable: true));
    await flush();
    expect(audio.playbackState.value.playing, false);
  });
  test('pause cancels pending network selection so late completion cannot restart audio', () async {
    repository.delayed = Completer<Match>();
    final audio = create();
    final play = audio.playFromMediaId('match:1');
    await flush();
    expect(audio.playbackState.value.playing, true);
    await audio.pause();
    repository.delayed!.complete(fixture(1));
    await play;
    await flush();
    expect(audio.playbackState.value.playing, false);
    expect(output.utterances, isEmpty);
  });
  test('upcoming and result items speak their summary then complete', () async {
    repository.records[1] = fixture(1, status: 'Upcoming');
    final audio = create();
    await audio.playFromMediaId('match:1');
    await flush();
    expect(output.utterances.single, contains('Upcoming match'));
    expect(output.utterances.single, contains('Oval, London'));
    expect(
      audio.playbackState.value.processingState,
      AudioProcessingState.completed,
    );
    repository.records[2] = fixture(
      2,
      status: 'Finished',
      result: 'Visitors won by 3 wickets',
    );
    await audio.playFromMediaId('match:2');
    await flush();
    expect(output.utterances.last, contains('Visitors won by 3 wickets'));
    expect(audio.playbackState.value.playing, false);
  });
  test(
    'a live match finishing announces its result and stops the live timer',
    () async {
      final audio = create();
      await audio.playFromMediaId('match:1');
      await flush();
      repository.records[1] = fixture(
        1,
        status: 'Finished',
        result: 'Match drawn',
      );
      await audio.customAction('refresh');
      await flush();
      expect(output.utterances.last, contains('Match drawn'));
      expect(
        audio.playbackState.value.processingState,
        AudioProcessingState.completed,
      );
    },
  );
  test(
    'focus denial and malformed media ids report errors without playing',
    () async {
      output.allowed = false;
      final audio = create();
      await audio.playFromMediaId('match:1');
      expect(
        audio.playbackState.value.processingState,
        AudioProcessingState.error,
      );
      expect(output.utterances, isEmpty);
      await audio.playFromMediaId('not-a-match');
      expect(audio.playbackState.value.errorCode, 1);
    },
  );
  test(
    'voice selection survives restart and resets on language change',
    () async {
      await settings.update(
        voice: {'name': 'English voice', 'locale': 'en-IN'},
        rate: 0.8,
      );
      final restored = SettingsController(SharedPreferencesAsync());
      await restored.load();
      expect(restored.speechVoice?['name'], 'English voice');
      expect(restored.speechRate, 0.8);
      await restored.update(locale: 'hi');
      expect(restored.speechVoice, isNull);
      await settings.load();
      expect(settings.speechVoice, isNull);
      restored.dispose();
    },
  );

  test('browse search respects the enabled car folders', () async {
    repository.records[2] = fixture(2, status: 'Upcoming');
    await settings.update(tabs: ['upcoming']);
    final audio = create();
    expect((await audio.search('Team')).map((item) => item.id), ['match:2']);
    await settings.update(car: false);
    expect(await audio.search('Team'), isEmpty);
  });
  test(
    'cold signed-out car browse and voice play preserve authentication error',
    () async {
      auth.token = null;
      auth.userId = null;
      final audio = create();
      final rows = await audio.getChildren(MediaTree.root);
      expect(rows.single.title, audio.signInMessage);
      expect(rows.single.playable, isFalse);
      await audio.playFromSearch('Team');
      expect(audio.playbackState.value.errorCode, 3);
      expect(audio.playbackState.value.errorMessage, audio.signInMessage);
      expect(audio.playbackState.value.playing, isFalse);
      expect(repository.detailCalls, 0);
      expect(output.utterances, isEmpty);
    },
  );
  test('car metadata discards a response from a previous account', () async {
    repository.delayed = Completer<Match>();
    final audio = create();
    final pending = audio.getMediaItem('match:1');
    await auth.save('replacement-token', '99');
    repository.delayed!.complete(fixture(1));
    expect(await pending, isNull);
  });
  test(
    'car root is audio-only and advertises list content with artwork',
    () async {
      final audio = create();
      final folders = await audio.getChildren(MediaTree.root);
      expect(folders.map((item) => item.id), [
        'folder:live',
        'folder:upcoming',
        'folder:results',
        'folder:mine',
      ]);
      for (final item in folders) {
        expect(item.playable, isFalse);
        expect(item.artUri, Uri.file('/logo.png'));
        expect(item.extras, MediaTree.style);
      }
      expect(await audio.getChildren('folder:gallery'), isEmpty);
      expect(await audio.getChildren('folder:browser'), isEmpty);
      final match = await audio.getMediaItem('match:1');
      expect(match?.title, 'Team 1 vs Visitors');
      expect(match?.extras, MediaTree.style);
    },
  );
  test('Android background focus recovery stays paused until an explicit media action', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    final audio = create();
    await audio.playFromMediaId('match:1');
    TestWidgetsFlutterBinding.ensureInitialized()
        .handleAppLifecycleStateChanged(AppLifecycleState.paused);
    output.interruptions.add(const FocusEvent(begin: true, resumable: true));
    await flush();
    output.interruptions.add(const FocusEvent(end: true, resumable: true));
    await flush();
    expect(audio.playbackState.value.playing, false);
    TestWidgetsFlutterBinding.ensureInitialized()
        .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
  });
  test(
    'live-queue fetching cannot delay a selected stream or commentary',
    () async {
      repository.matchesDelayed = Completer<List<Match>>();
      repository.records[1] = fixture(
        1,
        stream: 'https://example.com/live.mp3',
      );
      final audio = create();
      await audio.playFromMediaId('match:1');
      expect(output.streamPlays, 1);
      expect(audio.playbackState.value.playing, true);
      expect(audio.mediaItem.value?.id, 'match:1');
      await audio.stop();
    },
  );
  testWidgets(
    'live polling waits 25 seconds and pauses without another refresh',
    (tester) async {
      output = FakeAudioOutput();
      final audio = create();
      await audio.playFromMediaId('match:1');
      final initial = repository.detailCalls;
      await tester.pump(const Duration(seconds: 24));
      expect(repository.detailCalls, initial);
      await tester.pump(const Duration(seconds: 1));
      await tester.pump();
      expect(repository.detailCalls, initial + 1);
      await audio.pause();
      final paused = repository.detailCalls;
      await tester.pump(const Duration(seconds: 50));
      expect(repository.detailCalls, paused);
      await tester.runAsync(audio.shutdown);
      handler = null;
    },
  );
}


````

## C:\Users\ADITYA\Desktop\CP DRIVE\test\audio_widget_test.dart
````text
import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:drive/features/audio/audio_bootstrap.dart';
import 'package:drive/features/audio/mini_player.dart';
import 'package:drive/features/audio/voice_picker_tile.dart';
import 'package:drive/features/match_details/match_details_screen.dart';
import 'package:drive/features/matches/match_repository.dart';
import 'package:drive/features/settings/settings_controller.dart';
import 'package:drive/l10n/app_localizations.dart';

class UiAudioHandler extends BaseAudioHandler {
  final calls = <String>[];
  void publish(bool playing) => playbackState.add(
    PlaybackState(
      playing: playing,
      processingState: AudioProcessingState.ready,
    ),
  );
  @override
  Future<void> playFromMediaId(
    String mediaId, [
    Map<String, dynamic>? extras,
  ]) async {
    calls.add(mediaId);
    mediaItem.add(
      MediaItem(id: mediaId, title: 'India vs England', artist: '120/3'),
    );
    customState.add({'source': 'speech', 'offline': false});
    publish(true);
  }

  @override
  Future<void> play() async {
    calls.add('play');
    publish(true);
  }

  @override
  Future<void> pause() async {
    calls.add('pause');
    publish(false);
  }

  @override
  Future<void> stop() async {
    calls.add('stop');
    publish(false);
    mediaItem.add(null);
  }

  @override
  Future<void> skipToNext() async {
    calls.add('next');
  }

  @override
  Future<void> skipToPrevious() async {
    calls.add('previous');
  }

  @override
  Future<dynamic> customAction(
    String name, [
    Map<String, dynamic>? extras,
  ]) async => [
    {'name': 'English Test Voice', 'locale': 'en-IN'},
    {'name': 'Hindi Test Voice', 'locale': 'hi-IN'},
  ];
  Future<void> close() async {
    await playbackState.close();
    await mediaItem.close();
    await customState.close();
  }
}

Widget localized(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);
void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });
  testWidgets(
    'mini-player hides when stopped and routes controls to the same handler at large font',
    (tester) async {
      tester.view.physicalSize = const Size(360, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final handler = UiAudioHandler();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [audioHandlerProvider.overrideWithValue(handler)],
          child: localized(
            MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(1.8)),
              child: const Column(children: [Spacer(), MiniPlayer()]),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('India vs England'), findsNothing);
      await handler.playFromMediaId('match:7');
      await tester.pumpAndSettle();
      expect(find.text('India vs England'), findsOneWidget);
      await tester.tap(find.byTooltip('Pause'));
      await tester.pumpAndSettle();
      expect(handler.calls.last, 'pause');
      await tester.tap(find.byTooltip('Play'));
      await tester.pumpAndSettle();
      expect(handler.calls.last, 'play');
      await tester.tap(find.byTooltip('Next live match'));
      await tester.pump();
      expect(handler.calls.last, 'next');
      await tester.tap(find.byTooltip('Previous live match'));
      await tester.pump();
      expect(handler.calls.last, 'previous');
      await tester.tap(find.text('India vs England'));
      await tester.pumpAndSettle();
      expect(find.text('Now playing'), findsOneWidget);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Stop'));
      await tester.pumpAndSettle();
      expect(find.text('India vs England'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.runAsync(handler.close);
    },
  );
  testWidgets(
    'voice picker filters installed voices and saves or resets the selection',
    (tester) async {
      final settings = SettingsController(SharedPreferencesAsync());
      final handler = UiAudioHandler();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsProvider.overrideWithValue(settings),
            audioHandlerProvider.overrideWithValue(handler),
          ],
          child: localized(const VoicePickerTile()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Commentary voice'));
      await tester.pumpAndSettle();
      expect(find.text('English Test Voice'), findsOneWidget);
      expect(find.text('Hindi Test Voice'), findsNothing);
      await tester.tap(find.text('English Test Voice'));
      await tester.pumpAndSettle();
      expect(settings.speechVoice?['name'], 'English Test Voice');
      await tester.tap(find.text('Commentary voice'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Use the system default'));
      await tester.pumpAndSettle();
      expect(settings.speechVoice, isNull);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.runAsync(handler.close);
      settings.dispose();
    },
  );
  testWidgets('Listen live sends the match id to the shared audio handler', (
    tester,
  ) async {
    final settings = SettingsController(SharedPreferencesAsync());
    final handler = UiAudioHandler();
    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, request) => request.resolve(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: {'id': 7, 'match_status': 'Live'},
          ),
        ),
      ),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsProvider.overrideWithValue(settings),
          audioHandlerProvider.overrideWithValue(handler),
          matchRepositoryProvider.overrideWithValue(MatchRepository(dio)),
        ],
        child: localized(const MatchDetailsScreen(id: 7)),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Listen live'), 300);
    await Scrollable.ensureVisible(
      tester.element(find.text('Listen live')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Listen live'));
    await tester.pumpAndSettle();
    expect(handler.calls.single, 'match:7');
    expect(handler.mediaItem.value?.id, 'match:7');
    await tester.pumpWidget(const SizedBox());
    await tester.runAsync(handler.close);
    settings.dispose();
    dio.close();
  });
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\test\auth_test.dart
````text
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:drive/features/auth/auth_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('session persists, restores and clears securely', () async {
    FlutterSecureStorage.setMockInitialValues({});
    final auth = AuthController(const FlutterSecureStorage());
    await auth.restore();
    expect(auth.signedIn, false);
    await auth.save('test-token', '42');
    final restored = AuthController(const FlutterSecureStorage());
    await restored.restore();
    expect(restored.signedIn, true);
    expect(restored.userId, '42');
    await restored.signOut();
    expect(restored.signedIn, false);
    expect(await restored.storage.read(key: 'session'), isNull);
    auth.dispose();
    restored.dispose();
  });
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\test\browser_test.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\test\browser_widget_test.dart
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\test\gallery_test.dart
````text
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';
import 'package:drive/features/gallery/gallery_controller.dart';
import 'package:drive/features/gallery/gallery_format.dart';
import 'package:drive/features/gallery/gallery_library.dart';
import 'package:drive/features/gallery/gallery_permission_screen.dart';
import 'package:drive/features/gallery/gallery_screen.dart';
import 'package:drive/features/gallery/gallery_video.dart';
import 'package:drive/features/gallery/gallery_viewer.dart';
import 'package:drive/l10n/app_localizations.dart';

class FakeLibrary extends GalleryLibrary {
  PermissionState state = PermissionState.authorized;
  final records = <int>[];
  GalleryFilter? filter;
  VoidCallback? callback;
  int requests = 0;
  int settings = 0;
  bool fails = false;
  List<AssetEntity> assets = List.generate(
    85,
    (i) => AssetEntity(
      id: '$i',
      typeInt: i.isEven ? 1 : 2,
      width: 100,
      height: 100,
      isFavorite: i == 84,
    ),
  );
  Completer<List<AssetEntity>>? pending;
  @override
  Future<PermissionState> permission({bool request = false}) async {
    if (request) {
      requests++;
    }
    return state;
  }

  @override
  Future<List<AssetPathEntity>> albums(GalleryFilter type) async {
    filter = type;
    if (fails) {
      throw StateError('Failed');
    }
    return [AssetPathEntity(id: 'root', name: 'Recent', isAll: true)];
  }

  @override
  Future<List<AssetEntity>> page(AssetPathEntity album, int index) async {
    records.add(index);
    if (pending != null) {
      return pending!.future;
    }
    if (fails) {
      throw StateError('Failed');
    }
    final result = assets
        .where(
          (a) => filter == GalleryFilter.photos
              ? a.type == AssetType.image
              : filter == GalleryFilter.videos
              ? a.type == AssetType.video
              : true,
        )
        .toList();
    return result.skip(index * 80).take(80).toList();
  }

  @override
  Future<void> selectMore() async {
    state = PermissionState.limited;
  }

  @override
  Future<void> openSettings() async {
    settings++;
  }

  @override
  Future<void> watch(VoidCallback callback) async {
    this.callback = callback;
  }

  @override
  Future<void> unwatch() async {
    callback = null;
  }

  @override
  Future<bool> delete(AssetEntity asset) async {
    assets.removeWhere((a) => a.id == asset.id);
    return true;
  }
}

class FileAsset extends AssetEntity {
  FileAsset() : super(id: 'video', typeInt: 2, width: 640, height: 360);
  @override
  Future<File?> get file async => File('test-video.mp4');
}

class FakeVideoPlatform extends VideoPlayerPlatform {
  int pauses = 0;
  bool disposed = false;
  @override
  Future<void> init() async {}
  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async => 1;
  @override
  Stream<VideoEvent> videoEventsFor(int id) async* {
    yield VideoEvent(
      eventType: VideoEventType.initialized,
      duration: const Duration(seconds: 60),
      size: const Size(640, 360),
    );
  }

  @override
  Future<void> dispose(int id) async {
    disposed = true;
  }

  @override
  Future<void> setLooping(int id, bool looping) async {}
  @override
  Future<void> play(int id) async {}
  @override
  Future<void> pause(int id) async {
    pauses++;
  }

  @override
  Future<void> setVolume(int id, double volume) async {}
  @override
  Future<void> seekTo(int id, Duration position) async {}
  @override
  Future<void> setPlaybackSpeed(int id, double speed) async {}
  @override
  Future<Duration> getPosition(int id) async => Duration.zero;
  @override
  Widget buildViewWithOptions(VideoViewOptions options) => const SizedBox();
}

Widget localized(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'mixed gallery pages in batches of 80 without duplicate items',
    () async {
      final library = FakeLibrary();
      final controller = GalleryController(library);
      await controller.refresh();
      expect(controller.items.length, 80);
      expect(controller.hasMore, true);
      await controller.loadMore();
      expect(controller.items.length, 85);
      expect(controller.hasMore, false);
      expect(library.records, [0, 1]);
      expect(
        controller.items.where((a) => a.type == AssetType.video),
        isNotEmpty,
      );
      controller.dispose();
      expect(library.callback, isNull);
    },
  );
  test(
    'favorites continue across empty pages and filters reset paging',
    () async {
      final library = FakeLibrary();
      final controller = GalleryController(library);
      await controller.choose(album: 'favorites');
      expect(controller.items, isEmpty);
      expect(controller.hasMore, true);
      await controller.loadMore();
      expect(controller.items.single.id, '84');
      await controller.choose(type: GalleryFilter.videos, album: 'all');
      expect(controller.items.every((a) => a.type == AssetType.video), true);
      expect(library.records.last, 0);
      await controller.choose(album: 'videos');
      expect(library.filter, GalleryFilter.videos);
      controller.dispose();
    },
  );
  test(
    'limited access is usable and permission revocation clears assets',
    () async {
      final library = FakeLibrary()..state = PermissionState.limited;
      final controller = GalleryController(library);
      await controller.refresh();
      expect(controller.accessible, true);
      expect(controller.limited, true);
      expect(controller.items, isNotEmpty);
      library.state = PermissionState.denied;
      await controller.refresh();
      expect(controller.accessible, false);
      expect(controller.items, isEmpty);
      expect(controller.hasMore, false);
      controller.dispose();
    },
  );
  test(
    'stale page cannot restore assets after permission is revoked',
    () async {
      final library = FakeLibrary()..pending = Completer<List<AssetEntity>>();
      final controller = GalleryController(library);
      final first = controller.refresh();
      await Future<void>.delayed(Duration.zero);
      library.state = PermissionState.denied;
      await controller.refresh();
      library.pending!.complete(library.assets);
      await first;
      expect(controller.items, isEmpty);
      expect(controller.permission, PermissionState.denied);
      controller.dispose();
    },
  );
  test('failed library queries are recoverable', () async {
    final library = FakeLibrary()..fails = true;
    final controller = GalleryController(library);
    await controller.refresh();
    expect(controller.error, isNotNull);
    expect(controller.busy, false);
    library.fails = false;
    await controller.refresh();
    expect(controller.error, isNull);
    expect(controller.items.length, 80);
    controller.dispose();
  });
  test('duration supports videos longer than an hour', () {
    expect(mediaDuration(65), '01:05');
    expect(mediaDuration(3661), '1:01:01');
  });
  testWidgets(
    'permission-denied screen offers Settings and retry at large font',
    (tester) async {
      var settings = 0;
      var retry = 0;
      await tester.pumpWidget(
        localized(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: GalleryPermissionScreen(
              denied: true,
              onAllow: () => retry++,
              onSettings: () => settings++,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Photo and video access is turned off.'),
        findsOneWidget,
      );
      await tester.ensureVisible(find.text('Open Settings'));
      await tester.tap(find.text('Open Settings'));
      expect(settings, 1);
      await tester.ensureVisible(find.text('Retry'));
      await tester.tap(find.text('Retry'));
      expect(retry, 1);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('gallery waits for a user gesture before requesting permission', (
    tester,
  ) async {
    final library = FakeLibrary()..state = PermissionState.denied;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [galleryLibraryProvider.overrideWithValue(library)],
        child: localized(const GalleryScreen(active: true)),
      ),
    );
    await tester.pumpAndSettle();
    expect(library.requests, 0);
    await tester.tap(find.text('Allow access'));
    await tester.pumpAndSettle();
    expect(library.requests, 1);
    expect(find.text('Open Settings'), findsOneWidget);
    await tester.tap(find.text('Open Settings'));
    await tester.pumpAndSettle();
    expect(library.settings, 1);
    await tester.pumpWidget(const SizedBox());
  });
  testWidgets(
    'library change notifications refresh and dispose removes the callback',
    (tester) async {
      final library = FakeLibrary();
      final controller = GalleryController(library);
      await controller.refresh();
      library.assets = [];
      library.callback!();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();
      expect(controller.items, isEmpty);
      controller.dispose();
      expect(library.callback, isNull);
    },
  );
  testWidgets('video pauses when swiped away and when app backgrounds', (
    tester,
  ) async {
    final previous = VideoPlayerPlatform.instance;
    final platform = FakeVideoPlatform();
    VideoPlayerPlatform.instance = platform;
    addTearDown(() => VideoPlayerPlatform.instance = previous);
    final asset = FileAsset();
    final active = ValueNotifier(true);
    await tester.pumpWidget(
      localized(
        ValueListenableBuilder<bool>(
          valueListenable: active,
          builder: (context, value, child) =>
              GalleryVideo(asset: asset, active: value),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(Chewie), findsOneWidget);
    final controller = tester
        .widget<Chewie>(find.byType(Chewie))
        .controller
        .videoPlayerController;
    await controller.play();
    await tester.pump();
    expect(controller.value.isPlaying, true);
    active.value = false;
    await tester.pump();
    expect(controller.value.isPlaying, false);
    active.value = true;
    await tester.pump();
    await controller.play();
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    expect(controller.value.isPlaying, false);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    await tester.runAsync(() async {
      await Future<void>.delayed(Duration.zero);
    });
    await tester.pump();
    expect(platform.disposed, true);
    active.dispose();
  });
  testWidgets(
    'returning from viewer refreshes without popping the gallery route',
    (tester) async {
      final previous = VideoPlayerPlatform.instance;
      VideoPlayerPlatform.instance = FakeVideoPlatform();
      addTearDown(() => VideoPlayerPlatform.instance = previous);
      final library = FakeLibrary()..assets = [FileAsset()];
      final controller = GalleryController(library);
      await controller.refresh();
      await tester.pumpWidget(
        localized(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                await Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (_) =>
                        GalleryViewer(controller: controller, initialIndex: 0),
                  ),
                );
                await controller.refresh();
              },
              child: const Text('Open viewer'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open viewer'));
      await tester.pumpAndSettle();
      expect(find.byType(GalleryViewer), findsOneWidget);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.text('Open viewer'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.runAsync(() async {
        await Future<void>.delayed(Duration.zero);
      });
      controller.dispose();
    },
  );
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\test\match_test.dart
````text
import 'package:flutter_test/flutter_test.dart';
import 'package:drive/features/matches/models/match.dart';

void main() {
  test('missing and malformed fields do not throw', () {
    for (final input in [
      null,
      {},
      {'id': [], 'rawdata': true, 'team1': {}, 'stream_url': 'bad'},
    ]) {
      final match = Match.fromJson(input);
      expect(match.title(), 'Team A vs Team B');
      expect(match.tossText(), '');
      expect(match.streamUrl, isNull);
    }
  });
  test('list and paginated responses parse identically', () {
    final data = [
      {'id': 4, 'match_status': 'Live'},
      null,
      1,
    ];
    expect(Match.parseList(data).single.id, 4);
    expect(Match.parseList({'results': data}).single.status, MatchStatus.live);
    expect(Match.parseList({'results': false}), isEmpty);
  });
  test('toss and venue use nested fields', () {
    final match = Match.fromJson({
      'team1': 1,
      'toss': 1,
      'choose': 'Batting',
      'rawdata': {
        'team1': {'name': 'India'},
        'ground': {'title': 'Oval', 'city': 'London'},
      },
    });
    expect(match.tossText(), 'India won the toss and chose to bat');
    expect(match.venue(), 'Oval, London');
  });
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\test\phase2_test.dart
````text
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:drive/core/api/api_client.dart';
import 'package:drive/core/utils/refresh_controller.dart';
import 'package:drive/features/matches/home_screen.dart';
import 'package:drive/features/match_details/match_details_screen.dart';
import 'package:drive/features/matches/match_repository.dart';
import 'package:drive/features/settings/settings_controller.dart';
import 'package:drive/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });
  test(
    'settings survive restart and preserve selected car tab order',
    () async {
      final settings = SettingsController(SharedPreferencesAsync());
      await settings.update(
        themeMode: ThemeMode.dark,
        locale: 'hi',
        listInterval: 30,
        detailInterval: 120,
        rate: 0.8,
        car: false,
        tabs: ['mine', 'live'],
      );
      final restored = SettingsController(SharedPreferencesAsync());
      await restored.load();
      expect(restored.theme, ThemeMode.dark);
      expect(restored.language, 'hi');
      expect(restored.listSeconds, 30);
      expect(restored.detailSeconds, 120);
      expect(restored.speechRate, 0.8);
      expect(restored.showInCar, false);
      expect(restored.carTabs, ['mine', 'live']);
      await expectLater(restored.update(tabs: []), throwsArgumentError);
      await expectLater(restored.update(listInterval: -1), throwsArgumentError);
      expect(restored.carTabs, ['mine', 'live']);
      settings.dispose();
      restored.dispose();
    },
  );
  test('invalid saved values use safe defaults and deduplicate tabs', () async {
    final preferences = SharedPreferencesAsync();
    await preferences.setString(
      SettingsController.key,
      jsonEncode({
        'theme': 'invalid',
        'language': 42,
        'listSeconds': -1,
        'detailSeconds': 300,
        'speechRate': 4,
        'carTabs': ['mine', 'mine', 'invalid'],
      }),
    );
    final settings = SettingsController(preferences);
    await settings.load();
    expect(settings.theme, ThemeMode.system);
    expect(settings.language, 'system');
    expect(settings.listSeconds, 120);
    expect(settings.detailSeconds, 60);
    expect(settings.speechRate, 1);
    expect(settings.carTabs, ['mine']);
    settings.dispose();
  });
  test('repository sends user filter, accepts pagination and rejects malformed data', () async {
    final dio = Dio();
    Object? payload = {
      'results': [
        {'id': 8, 'match_status': 'Live'},
      ],
    };
    RequestOptions? request;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          request = options;
          handler.resolve(
            Response(requestOptions: options, data: payload, statusCode: 200),
          );
        },
      ),
    );
    final repository = MatchRepository(dio);
    expect((await repository.list(userId: '42')).single.id, 8);
    expect(request!.queryParameters['user'], '42');
    expect(request!.queryParameters['limit'], 40);
    expect(request!.queryParameters['cache_buster'], isA<int>());
    payload = 'invalid';
    await expectLater(repository.list(), throwsFormatException);
    payload = {'id': 8};
    expect((await repository.details(8)).id, 8);
    await expectLater(repository.details(9), throwsFormatException);
    dio.close();
  });
  test('refresh prevents overlapping requests and retains data after connection failure', () async {
    var calls = 0;
    final pending = Completer<int>();
    var fail = false;
    final controller = RefreshController<int>(
      seconds: 60,
      fetch: (token) {
        calls++;
        if (fail) {
          throw DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.connectionError,
          );
        }
        return pending.future;
      },
    );
    final first = controller.refresh();
    await controller.refresh();
    expect(calls, 1);
    pending.complete(7);
    await first;
    expect(controller.data, 7);
    fail = true;
    await controller.refresh();
    expect(controller.data, 7);
    expect(controller.offline, true);
    controller.dispose();
  });
  testWidgets(
    'automatic refresh pauses in background and reacts to interval changes',
    (tester) async {
      var calls = 0;
      final controller = RefreshController<int>(
        seconds: 30,
        fetch: (_) async => ++calls,
      );
      controller.configure(interval: 30, enabled: true);
      await tester.pump(const Duration(seconds: 30));
      expect(calls, 1);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pump(const Duration(seconds: 60));
      expect(calls, 1);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(calls, 2);
      controller.configure(interval: 60, enabled: true);
      await tester.pump(const Duration(seconds: 30));
      expect(calls, 2);
      await tester.pump(const Duration(seconds: 30));
      expect(calls, 3);
      controller.dispose();
    },
  );
  testWidgets(
    'home filters tabs, requests My Matches and renders settings at large font',
    (tester) async {
      tester.view.resetPhysicalSize();
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final settings = SettingsController(SharedPreferencesAsync());
      final dio = Dio();
      var mineRequested = false;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            mineRequested =
                mineRequested || options.queryParameters['user'] == '42';
            handler.resolve(
              Response(
                requestOptions: options,
                data: [
                  {
                    'id': 1,
                    'match_status': 'Live',
                    'rawdata': {
                      'team1': {'name': 'Live XI'},
                    },
                  },
                  {
                    'id': 2,
                    'match_status': 'Upcoming',
                    'rawdata': {
                      'team1': {'name': 'Future XI'},
                    },
                  },
                ],
                statusCode: 200,
              ),
            );
          },
        ),
      );
      final container = ProviderContainer(
        overrides: [
          settingsProvider.overrideWithValue(settings),
          matchRepositoryProvider.overrideWithValue(MatchRepository(dio)),
        ],
      );
      container.read(authProvider).userId = '42';
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.5)),
              child: child!,
            ),
            home: const HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Live XI vs Team B'), findsOneWidget);
      expect(find.text('Future XI vs Team B'), findsNothing);
      await tester.tap(find.text('Upcoming'));
      await tester.pumpAndSettle();
      expect(find.text('Future XI vs Team B'), findsOneWidget);
      await tester.ensureVisible(find.text('My Matches'));
      await tester.tap(find.text('My Matches'));
      await tester.pumpAndSettle();
      expect(mineRequested, true);
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      expect(find.text('Theme'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      container.dispose();
      settings.dispose();
      dio.close();
    },
  );
  testWidgets('details retry, combined score and unavailable audio recovery', (
    tester,
  ) async {
    var fail = true;
    final settings = SettingsController(SharedPreferencesAsync());
    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (fail) {
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
              ),
            );
          } else {
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {
                  'id': 7,
                  'match_status': 'Live',
                  'score': '120/3',
                  'rawdata': {
                    'team1': {'name': 'India'},
                    'team2': {'name': 'England'},
                  },
                },
              ),
            );
          }
        },
      ),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsProvider.overrideWithValue(settings),
          matchRepositoryProvider.overrideWithValue(MatchRepository(dio)),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MatchDetailsScreen(id: 7),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Match details are unavailable.'), findsOneWidget);
    fail = false;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('India vs England'), findsOneWidget);
    expect(find.text('120/3'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Listen live'), 300);
    await tester.tap(find.text('Listen live'));
    await tester.pump();
    expect(
      find.text(
        'Audio could not be initialized. Restart CP Drive and try again.',
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    settings.dispose();
    dio.close();
  });
}

````

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\build.gradle.kts
````text
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\src\main\AndroidManifest.xml
````text
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
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK"/>
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
    <application
        android:label="CP Drive"
        android:usesCleartextTraffic="true"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <meta-data android:name="com.google.android.gms.car.application"
            android:resource="@xml/automotive_app_desc"/>
        <provider android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.browser_files" android:exported="false" android:grantUriPermissions="true">
            <meta-data android:name="android.support.FILE_PROVIDER_PATHS" android:resource="@xml/browser_file_paths"/>
        </provider>
        <service android:name="com.ryanheise.audioservice.AudioService" android:exported="true" android:foregroundServiceType="mediaPlayback">
            <intent-filter><action android:name="android.media.browse.MediaBrowserService"/></intent-filter>
        </service>
        <receiver android:name="com.ryanheise.audioservice.MediaButtonReceiver" android:exported="true">
            <intent-filter><action android:name="android.intent.action.MEDIA_BUTTON"/></intent-filter>
        </receiver>
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
        <intent><action android:name="android.intent.action.TTS_SERVICE"/></intent>
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\src\main\kotlin\com\cricketerspitch\drive\MainActivity.kt
````text
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
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.concurrent.Executors

class MainActivity : AudioServiceActivity() {
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

````

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\src\main\res\xml\automotive_app_desc.xml
````text
<?xml version="1.0" encoding="utf-8"?>
<automotiveApp>
    <uses name="media"/>
</automotiveApp>

````

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\src\main\res\xml\browser_file_paths.xml
````text
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-files-path name="browser_downloads" path="Download/"/>
</paths>

````

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\src\main\res\drawable\ic_audio_notification.xml
````text
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24">
    <path android:fillColor="#FFFFFFFF" android:pathData="M12,3C7,3 3,7 3,12v7c0,1.1 0.9,2 2,2h3v-9H5c0,-3.9 3.1,-7 7,-7s7,3.1 7,7h-3v9h3c1.1,0 2,-0.9 2,-2v-7C21,7 17,3 12,3z"/>
</vector>

````
