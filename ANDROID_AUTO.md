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
