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
  String get quickAccess => 'Quick access';

  @override
  String get quickWebsites => 'Websites';

  @override
  String get quickApp => 'In this app';

  @override
  String get music => 'Music';

  @override
  String get musicSongs => 'Songs';

  @override
  String get musicFolders => 'Folders';

  @override
  String get musicAllow => 'Allow music access';

  @override
  String get musicPermission =>
      'Allow CP Drive to read the music files on this phone so you can play them here and in Android Auto.';

  @override
  String get musicCarPermission =>
      'Open CP Drive on your phone and allow music access';

  @override
  String get musicEmpty => 'No music files found on this phone.';

  @override
  String get musicError => 'This song could not be played.';

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

  @override
  String get teamA => 'Team A';

  @override
  String get teamB => 'Team B';

  @override
  String get yetToBat => 'Yet to bat';

  @override
  String get testMatch => 'Test Match';

  @override
  String get hundred => 'Hundred';

  @override
  String get doubleWicket => 'Double Wicket';

  @override
  String get balls => 'balls';

  @override
  String get bat => 'bat';

  @override
  String get bowl => 'bowl';

  @override
  String oversFormat(String overs) {
    return '$overs overs';
  }

  @override
  String wonToss(String team) {
    return '$team won the toss';
  }

  @override
  String choseToss(String team, String action) {
    return '$team won the toss and chose to $action';
  }

  @override
  String get cloudMedia => 'Stored in iCloud';

  @override
  String get cloudDownloading => 'Downloading from iCloud';

  @override
  String get carLoading => 'Loading…';

  @override
  String get carNoMatches => 'No matches right now';

  @override
  String get carMatch => 'Match';

  @override
  String get carMatches => 'Matches';

  @override
  String get carMatchUnavailable => 'Match unavailable. Try again later.';

  @override
  String get carMatchesUnavailable => 'Matches unavailable. Try again later.';

  @override
  String get carAudioUnavailable => 'Audio unavailable. Try again later.';

  @override
  String get carHidden => 'CP Drive is hidden in car settings.';

  @override
  String get oversUnit => 'overs';

  @override
  String spokenInnings(String runs, String wickets, String overs, String unit) {
    return '$runs for $wickets after $overs $unit';
  }

  @override
  String matchTitle(String team1, String team2) {
    return '$team1 vs $team2';
  }

  @override
  String get speechAnd => ' and ';

  @override
  String scoreFor(String runs, String wickets) {
    return '$runs for $wickets';
  }

  @override
  String get upcomingAnnouncement => 'Upcoming match';

  @override
  String get finishedAnnouncement => 'Match finished';
}
