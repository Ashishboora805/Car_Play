# CP Drive — Phase 7


Login is temporarily disabled by default. The app opens directly in guest mode, without restoring or inventing credentials. Sign out and My Matches are hidden; public match/audio requests remain available, subject to backend access rules. To restore the existing login flow, build or run with `--dart-define=CP_LOGIN_ENABLED=true` alongside your backend configuration.

Flutter 3.47.5 stable / Dart 3.13.4. The phone gallery, browser, shared commentary engine, Android Auto media integration and native CarPlay integration are implemented. See [Android Auto setup and review guide](ANDROID_AUTO.md) and [CarPlay simulator, entitlement and review guide](CARPLAY.md). CarPlay Swift compilation, simulator discovery and physical-device behavior remain unverified on this Windows host.

## Run

The original Phase 7 validation passed 71 tests and built a debug APK. The subsequent review fixes and current validation are documented in [REVIEW_FIXES.md](REVIEW_FIXES.md). CarPlay bridge tests cover snapshots, selections, visibility, sign-out, account changes and error recovery. Plists, Xcode source/signing registrations and CarPlay icon dimensions were checked on Windows; Swift compilation, iOS signing, simulator discovery and real CarPlay playback still require a Mac and device. See CARPLAY.md before enabling the device entitlement.

From this directory run `flutter pub get`, `flutter gen-l10n`, `flutter analyze`, and `flutter test`.
Create a local `backend.json` containing CP_API_BASE_URL (your actual HTTPS API base URL), CP_LOGIN_ENDPOINT (relative login path), and CP_COMMENTARY_ENDPOINT (relative commentary path). Run `flutter run --dart-define-from-file=backend.json`. These values are configuration, not credentials. When login is enabled with `CP_LOGIN_ENABLED=true`, its form stays disabled until a valid HTTPS base URL and relative login path are set. Do not put tokens or passwords in this file.

Login sends JSON username/password and expects a nonempty `token` plus `user_id`, `id`, or `user.id`. Confirm this contract with your backend. Credentials are never logged. Session token and user id share one secure-storage record; authenticated 401/403 responses clear it and redirect to login. Stale responses from a previous session cannot sign out a newer session. Storage failures show a retry screen.

Scores accept the structured `score` innings array (`team_id`, `inning`, `r`, `w`, `over`), `mtype` and `overs`, while retaining legacy scalar score fields. Innings are sorted by number and matched to each team. Test, Hundred and Double Wicket labels and scoring are covered by regression tests; empty or invalid team scores display Yet to bat. Validate representative responses against the live backend before release.

## Platforms

Android uses Kotlin DSL, minSdk 24 and compile/target SDK 36. Install Android SDK 36 through Android Studio > Tools > SDK Manager > SDK Platforms > Android 16 > Apply. INTERNET allows backend HTTPS requests; it has no runtime prompt. Release packaging requires your own upload keystore and fails clearly when signing is missing. Copy `android/key.properties.example` to the ignored `android/key.properties`, fill it locally, and build with `flutter build appbundle --release --dart-define-from-file=backend.json`. Alternatively supply `CP_DRIVE_KEYSTORE`, `CP_DRIVE_STORE_PASSWORD`, `CP_DRIVE_KEY_ALIAS` and `CP_DRIVE_KEY_PASSWORD` in a private CI environment. Relative keystore paths resolve from `android/`. Debug builds work without production credentials; no release build falls back to the debug key.

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


## Review fixes

See [REVIEW_FIXES.md](REVIEW_FIXES.md) for the 13 findings, implemented fixes, validation and remaining device checks. Sign-out clears browser cookies, website storage/cache, tab thumbnails, history, bookmarks and download-list records; files already exported to Downloads/Files remain user-owned. A pending logout blocks login and retries cleanup instead of restoring old credentials. Browsing tabs preserve metadata while keeping at most four WebViews alive. Android Auto artwork is served by the read-only `content://com.cricketerspitch.drive.media_artwork/logo.png` provider, which exposes only the bundled logo.

Live speech starts with one score summary. The first successful commentary response establishes a baseline; only later deliveries are spoken, including the first future delivery after an empty baseline. A failed initial response is retried without replaying historical balls. When speech locales or saved voices are unavailable, compatible installed locales and default voices are tried.

On iOS, gallery grid badges check local availability without downloading full assets. The active viewer/share action downloads cloud media with progress and retry/cancel handling. Full-size downloads are cancelled when their page closes or becomes inactive. Real iCloud, locked-phone audio, CarPlay and native TLS behavior still require iPhone validation on a Mac.
#   C a r _ P l a y  
 