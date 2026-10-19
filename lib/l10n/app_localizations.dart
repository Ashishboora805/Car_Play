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

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick access'**
  String get quickAccess;

  /// No description provided for @quickWebsites.
  ///
  /// In en, this message translates to:
  /// **'Websites'**
  String get quickWebsites;

  /// No description provided for @quickApp.
  ///
  /// In en, this message translates to:
  /// **'In this app'**
  String get quickApp;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @musicSongs.
  ///
  /// In en, this message translates to:
  /// **'Songs'**
  String get musicSongs;

  /// No description provided for @musicFolders.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get musicFolders;

  /// No description provided for @musicAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow music access'**
  String get musicAllow;

  /// No description provided for @musicPermission.
  ///
  /// In en, this message translates to:
  /// **'Allow CP Drive to read the music files on this phone so you can play them here and in Android Auto.'**
  String get musicPermission;

  /// No description provided for @musicCarPermission.
  ///
  /// In en, this message translates to:
  /// **'Open CP Drive on your phone and allow music access'**
  String get musicCarPermission;

  /// No description provided for @musicEmpty.
  ///
  /// In en, this message translates to:
  /// **'No music files found on this phone.'**
  String get musicEmpty;

  /// No description provided for @musicError.
  ///
  /// In en, this message translates to:
  /// **'This song could not be played.'**
  String get musicError;

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

  /// No description provided for @teamA.
  ///
  /// In en, this message translates to:
  /// **'Team A'**
  String get teamA;

  /// No description provided for @teamB.
  ///
  /// In en, this message translates to:
  /// **'Team B'**
  String get teamB;

  /// No description provided for @yetToBat.
  ///
  /// In en, this message translates to:
  /// **'Yet to bat'**
  String get yetToBat;

  /// No description provided for @testMatch.
  ///
  /// In en, this message translates to:
  /// **'Test Match'**
  String get testMatch;

  /// No description provided for @hundred.
  ///
  /// In en, this message translates to:
  /// **'Hundred'**
  String get hundred;

  /// No description provided for @doubleWicket.
  ///
  /// In en, this message translates to:
  /// **'Double Wicket'**
  String get doubleWicket;

  /// No description provided for @balls.
  ///
  /// In en, this message translates to:
  /// **'balls'**
  String get balls;

  /// No description provided for @bat.
  ///
  /// In en, this message translates to:
  /// **'bat'**
  String get bat;

  /// No description provided for @bowl.
  ///
  /// In en, this message translates to:
  /// **'bowl'**
  String get bowl;

  /// No description provided for @oversFormat.
  ///
  /// In en, this message translates to:
  /// **'{overs} overs'**
  String oversFormat(String overs);

  /// No description provided for @wonToss.
  ///
  /// In en, this message translates to:
  /// **'{team} won the toss'**
  String wonToss(String team);

  /// No description provided for @choseToss.
  ///
  /// In en, this message translates to:
  /// **'{team} won the toss and chose to {action}'**
  String choseToss(String team, String action);

  /// No description provided for @cloudMedia.
  ///
  /// In en, this message translates to:
  /// **'Stored in iCloud'**
  String get cloudMedia;

  /// No description provided for @cloudDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading from iCloud'**
  String get cloudDownloading;

  /// No description provided for @carLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get carLoading;

  /// No description provided for @carNoMatches.
  ///
  /// In en, this message translates to:
  /// **'No matches right now'**
  String get carNoMatches;

  /// No description provided for @carMatch.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get carMatch;

  /// No description provided for @carMatches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get carMatches;

  /// No description provided for @carMatchUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Match unavailable. Try again later.'**
  String get carMatchUnavailable;

  /// No description provided for @carMatchesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Matches unavailable. Try again later.'**
  String get carMatchesUnavailable;

  /// No description provided for @carAudioUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Audio unavailable. Try again later.'**
  String get carAudioUnavailable;

  /// No description provided for @carHidden.
  ///
  /// In en, this message translates to:
  /// **'CP Drive is hidden in car settings.'**
  String get carHidden;

  /// No description provided for @oversUnit.
  ///
  /// In en, this message translates to:
  /// **'overs'**
  String get oversUnit;

  /// No description provided for @spokenInnings.
  ///
  /// In en, this message translates to:
  /// **'{runs} for {wickets} after {overs} {unit}'**
  String spokenInnings(String runs, String wickets, String overs, String unit);

  /// No description provided for @matchTitle.
  ///
  /// In en, this message translates to:
  /// **'{team1} vs {team2}'**
  String matchTitle(String team1, String team2);

  /// No description provided for @speechAnd.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get speechAnd;

  /// No description provided for @scoreFor.
  ///
  /// In en, this message translates to:
  /// **'{runs} for {wickets}'**
  String scoreFor(String runs, String wickets);

  /// No description provided for @upcomingAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Upcoming match'**
  String get upcomingAnnouncement;

  /// No description provided for @finishedAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Match finished'**
  String get finishedAnnouncement;
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
