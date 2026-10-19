# CP Drive — Phase 1 complete source

Files are already saved in the workspace. Full Phase 1 text sources follow. Generated binary icons are in assets/images and platform resource directories. Xcode project settings are saved in ios/Runner.xcodeproj/project.pbxproj.

## Folder tree

```text
pubspec.yaml
l10n.yaml
analysis_options.yaml
README.md
lib\app.dart
lib\core\api\api_client.dart
lib\core\api\api_config.dart
lib\core\api\auth_interceptor.dart
lib\core\router\app_router.dart
lib\core\theme\app_theme.dart
lib\features\auth\auth_controller.dart
lib\features\auth\login_screen.dart
lib\features\matches\models\match.dart
lib\l10n\app_en.arb
lib\l10n\app_hi.arb
lib\l10n\app_localizations.dart
lib\l10n\app_localizations_en.dart
lib\l10n\app_localizations_hi.dart
lib\main.dart
test\auth_test.dart
test\match_test.dart
tool\create_logo.dart
android\app\build.gradle.kts
android\app\src\main\AndroidManifest.xml
android\app\src\main\kotlin\com\cricketerspitch\drive\MainActivity.kt
ios\Podfile
ios\Runner\Info.plist
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\l10n.yaml

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
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

## C:\Users\ADITYA\Desktop\CP DRIVE\README.md

```markdown
# CP Drive — Phase 1

Flutter 3.47.5 stable / Dart 3.13.4. Android and iPhone foundation only. Later phases implement matches, gallery, browser and car audio.

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

English and Hindi follow the phone locale; light/dark themes follow the system. Explicit preferences arrive in Phase 2. The signed-in landing screen intentionally marks that phase boundary.

## Structure

lib/main.dart and app.dart start the app. core/api holds configuration, Dio and auth interception; core/router handles startup/login/session redirects; core/theme holds Material 3 themes; features/auth holds secure sessions and login; features/matches/models holds defensive parsing; l10n contains ARB translations and generated delegates. Directories for core/utils, car, match_details, gallery, browser, settings and audio are reserved for later phases.
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\app.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

class CPDriveApp extends ConsumerWidget {
  const CPDriveApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
    theme: AppTheme.build(Brightness.light),
    darkTheme: AppTheme.build(Brightness.dark),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: ref.watch(routerProvider),
  );
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
import '../../features/auth/login_screen.dart';
import '../../l10n/app_localizations.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  final router = GoRouter(
    initialLocation: '/startup',
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

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(text.appTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(text.homeMessage),
              FilledButton(
                onPressed: ref.read(authProvider).signOut,
                child: Text(text.signOut),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
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

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_en.arb

```ruby
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
  "hidePassword": "Hide password"
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\l10n\app_hi.arb

```ruby
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
  "hidePassword": "पासवर्ड छिपाएँ"
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
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\lib\main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: CPDriveApp()));
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\test\auth_test.dart

```dart
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\test\match_test.dart

```dart
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\tool\create_logo.dart

```dart
import 'dart:io';

import 'package:image/image.dart' as img;

void main() {
  final image = img.Image(width: 512, height: 512);
  img.fill(image, color: img.ColorRgb8(11, 44, 84));
  img.fillCircle(
    image,
    x: 256,
    y: 256,
    radius: 192,
    color: img.ColorRgb8(255, 139, 45),
  );
  img.drawString(
    image,
    'CP',
    font: img.arial48,
    x: 222,
    y: 198,
    color: img.ColorRgb8(11, 44, 84),
  );
  img.drawString(
    image,
    'DRIVE',
    font: img.arial24,
    x: 221,
    y: 275,
    color: img.ColorRgb8(11, 44, 84),
  );
  File('assets/images/logo.png').writeAsBytesSync(img.encodePng(image));
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
```

## C:\Users\ADITYA\Desktop\CP DRIVE\android\app\src\main\AndroidManifest.xml

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <application
        android:label="CP Drive"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
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

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()
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
    end
  end
end
```

## C:\Users\ADITYA\Desktop\CP DRIVE\ios\Runner\Info.plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>CADisableMinimumFrameDurationOnPhone</key>
		<true/>
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
