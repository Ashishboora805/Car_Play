# CP Drive review fixes — 17 October 2026

All 13 reported findings have code changes. Production signing is configured but requires the owner's private upload keystore; native iOS and car behavior still require device validation.

| Finding | Implementation |
|---|---|
| iOS rejects valid HTTPS certificates | WKWebView uses default OS trust evaluation. Rejected certificates show the SSL warning; Android SSL challenges remain cancelled. |
| Structured scores missing | Parses innings by `team_id` and `inning`, validates numeric fields, handles Test/Hundred/Double Wicket and scheduled overs, preserves legacy scalar scores. Phone cards, details, car metadata and spoken summaries consume the scores. |
| Logout retains browsing data | Stops mounted browser views and downloads, drains queued database writes, clears cookies, website storage/cache, tabs/thumbnails, history, bookmarks and download records on both platforms. Exported files remain in Downloads/Files. Audio clears its match caches on authentication changes. |
| Too many live WebViews | Retains the four most recently selected views. Evicted tabs retain their URL, title and screenshot metadata and reload on selection. |
| Debug key signs releases | Release signing reads ignored local properties or private CI environment variables. Packaging without complete credentials fails with an explicit error. Debug builds remain available. |
| Android WebView remains paused | Serializes lifecycle pause/resume calls so returning to the active tab resumes after any outstanding pause completes. |
| Failed logout restores credentials | Persists a pending-logout marker. Restore retries deletion and browser cleanup; login remains blocked until cleanup succeeds. Normal cleanup shows a loading state, failures offer retry. |
| Android Auto artwork unreadable | Uses `content://com.cricketerspitch.drive.media_artwork/logo.png`. A read-only ContentProvider exposes only the bundled logo and works without a Flutter activity. |
| Pre-join commentary repeated | First successful commentary response establishes the baseline without speaking old balls. Empty baselines allow future balls; failed responses do not establish a false baseline. Queued future balls interrupted by pause remain eligible on resume. |
| Empty voice query plays a result | Empty/whitespace queries choose the first live match, regardless of folder order, while respecting authentication and Show in car. |
| Missing speech locale stops audio | Tries the preferred locale, English regional fallbacks where appropriate, and installed locales for the selected language. Removed saved voices fall back to the locale's default voice. |
| iCloud loading has no progress | Grid badges query availability without downloading originals. Active photo/video pages and sharing use progress handlers, cancellation and retry states. Inactive video controllers are disposed. |
| English text in Hindi mode | Match defaults, toss, format, titles and spoken scores use localization resources. CarPlay receives localized loading/empty/error strings and caches them for cold starts. Car browse labels use the same resources. Backend team names, results and commentary remain backend text. |

## Validation

- `flutter analyze --no-pub`: no issues.
- `flutter test --no-pub`: 88 tests pass, up from 71 before the review fixes.
- `flutter build apk --debug --no-pub`: succeeds. Artifact: `build/app/outputs/flutter-apk/app-debug.apk`.
- `flutter build apk --release --no-pub`: compiles release sources, then deliberately fails at `:app:packageRelease` with **Production signing is missing**, because no production credentials are configured. This verifies the protection, not a signed release build.
- Regression coverage includes score formats, malformed innings, failed logout and restart/retry, browser cleanup, 24 tabs with at most four live views, certificate callbacks, Android lifecycle ordering, commentary baselines/deduplication, empty car voice search, locale fallback, cloud progress/cancellation, video disposal and Hindi match defaults.

## Production signing

Copy `android/key.properties.example` to `android/key.properties` and supply your actual keystore path, store password, key alias and key password locally. Both the real properties file and keystores are ignored by version control. Do not paste secrets into the chat or source files.

CI can instead set `CP_DRIVE_KEYSTORE`, `CP_DRIVE_STORE_PASSWORD`, `CP_DRIVE_KEY_ALIAS` and `CP_DRIVE_KEY_PASSWORD`. Build with your production backend definitions, for example:

```powershell
flutter build appbundle --release --dart-define-from-file=backend.json
```

## Still requires hardware or external configuration

Windows cannot compile or sign Swift/iOS. On a Mac, build Runner, validate the archive and combined privacy manifests, then check valid/invalid HTTPS sites, iCloud-only photos/videos, locked-phone audio and CarPlay cold starts. Verify Android Auto browse artwork and voice playback with DHU/a car. Compare score fixtures with representative live backend responses. These checks and store approval are not claimed as complete.

The debug APK remains unconfigured for a real backend unless built with the project's backend definitions. Its existence does not imply production sign-in is available.
