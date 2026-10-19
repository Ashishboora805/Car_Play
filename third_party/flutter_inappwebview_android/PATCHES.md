# Local Android compatibility patch

Upstream: flutter_inappwebview_android 1.1.3 from pub.dev, used by flutter_inappwebview 6.1.5. Upstream license is retained in LICENSE. Android and Dart library sources are copied unchanged; examples and upstream tests are not needed to build the application.

Only change: android/build.gradle uses proguard-android-optimize.txt instead of proguard-android.txt in both build types. AGP 9.1 rejects the removed non-optimizing default. There are no browser-runtime changes in this fork.

The app uses a path dependency override so the compatibility fix is reproducible and does not modify the shared pub cache. Remove the override and vendored package when an upstream stable Android release includes AGP 9 compatibility, then rerun Android builds and browser device checks.
