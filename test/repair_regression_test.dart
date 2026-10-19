import 'dart:async';
import 'dart:io';

import 'package:drive/features/gallery/gallery_asset.dart';
import 'package:drive/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_manager/photo_manager.dart';

class DelayedAsset extends AssetEntity {
  DelayedAsset()
    : super(id: 'cloud-photo', typeInt: 1, width: 100, height: 100);
  final requests = [Completer<File?>()];
  Completer<File?> get request => requests.last;
  @override
  Future<File?> loadFile({
    bool isOrigin = true,
    bool withSubtype = false,
    PMProgressHandler? progressHandler,
    PMCancelToken? cancelToken,
    PMDarwinAVFileType? darwinFileType,
  }) => request.future;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'cancelled asset download cannot populate a later viewer request',
    () async {
      final asset = DelayedAsset();
      final transfer = GalleryAssetTransfer(asset);
      final pending = transfer.load();
      transfer.cancel();
      asset.request.complete(File('old-photo.jpg'));
      await pending;
      expect(transfer.file, isNull);
      asset.requests.add(Completer<File?>()..complete(File('new-photo.jpg')));
      await transfer.load();
      expect(transfer.file!.path, 'new-photo.jpg');
      transfer.dispose();
    },
  );

  testWidgets('cloud download shows progress and retry controls', (
    tester,
  ) async {
    final transfer = GalleryAssetTransfer(DelayedAsset())
      ..cloud = true
      ..progress = .42;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: GalleryTransferStatus(transfer: transfer)),
      ),
    );
    expect(find.text('Downloading from iCloud'), findsOneWidget);
    expect(find.text('42%'), findsOneWidget);
    expect(
      tester
          .widget<CircularProgressIndicator>(
            find.byType(CircularProgressIndicator),
          )
          .value,
      .42,
    );
    transfer.failed = true;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: GalleryTransferStatus(
            key: const ValueKey('retry'),
            transfer: transfer,
          ),
        ),
      ),
    );
    expect(find.text('Retry'), findsOneWidget);
    transfer.dispose();
  });
}
