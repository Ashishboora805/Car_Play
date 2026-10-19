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
