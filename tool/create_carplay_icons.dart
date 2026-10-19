import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart' as img;

void main() {
  const directory = 'ios/Runner/Assets.xcassets/AppIcon.appiconset';
  final source = img.decodePng(
    File('assets/images/logo.png').readAsBytesSync(),
  )!;
  final contents = File('$directory/Contents.json');
  final data = jsonDecode(contents.readAsStringSync()) as Map<String, dynamic>;
  final images = data['images'] as List<dynamic>;
  images.removeWhere((dynamic item) => item is Map && item['idiom'] == 'car');
  for (final scale in [2, 3]) {
    final filename = 'Icon-CarPlay-60x60@${scale}x.png';
    final resized = img.copyResize(
      source,
      width: 60 * scale,
      height: 60 * scale,
      interpolation: img.Interpolation.cubic,
    );
    File('$directory/$filename').writeAsBytesSync(img.encodePng(resized));
    images.add({
      'idiom': 'car',
      'size': '60x60',
      'scale': '${scale}x',
      'filename': filename,
    });
  }
  contents.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(data)}\n',
  );
}
