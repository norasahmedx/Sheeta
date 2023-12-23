import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ImageUtils {
  static bool isValidImage(Uint8List data) {
    try {
      img.decodeImage(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
