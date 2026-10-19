# CP Drive — Phase 2 complete source

Phase 2 is saved in the workspace. This handoff includes complete current Dart sources, translations, dependency configuration, tests, and setup instructions. Native platform files from Phase 1 are unchanged.

## Validation

`flutter pub get` succeeded. `flutter analyze` passed. `flutter test` passed all 11 tests. No live backend or native device build was verified.

## Scope

Matches tabs, match cards and details, refresh controls, error/empty states, persisted settings and bottom navigation are implemented. Gallery, browser and audio remain explicitly marked by their scheduled phases. Voice discovery/selection will be implemented in Phase 5; this phase persists speech rate and uses the system voice default.

## Folder tree

```text
pubspec.yaml
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
test\phase2_test.dart
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
  shared_preferences_platform_interface: ^2.4.2

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

## C:\Users\ADITYA\Desktop\CP DRIVE\README.md

```markdown
# CP Drive — Phase 2

Flutter 3.47.5 stable / Dart 3.13.4. Android and iPhone app foundation, match browsing, details, and persisted settings. Later phases implement gallery, browser and car audio.

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

English and Hindi follow the phone locale; light/dark themes follow the system. Theme and language can be overridden in Settings. The phone has Matches, Gallery, Browser and Settings navigation; Gallery and Browser explain their future phase availability.

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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(text.galleryPhase),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(text.browserPhase),
                    ),
                  ),
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
  "unavailableMatch": "Match details are unavailable."
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
  "unavailableMatch": "मैच विवरण उपलब्ध नहीं है।"
}
```

## C:\Users\ADITYA\Desktop\CP DRIVE\test\phase2_test.dart

```dart
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
  testWidgets('details retry, combined score and live audio phase message', (
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
      find.text('Live audio will be available in Phase 5.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    settings.dispose();
    dio.close();
  });
}
```
