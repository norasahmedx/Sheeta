import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/shared/show_toast.dart';
import 'package:image/image.dart' as img;

class Storage {
  static bool isValidImage(Uint8List data) {
    try {
      img.decodeImage(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getImgURL(
    String imgName,
    Uint8List imgPath,
    String? directory,
  ) async {
    try {
      // Check this image is a valid image or not
      if (Storage.isValidImage(imgPath)) {
        // Upload image to firebase storage
        Reference storageRef =
            FirebaseStorage.instance.ref("$directory/$imgName");
        // use this code if u are using flutter web
        UploadTask uploadTask = storageRef.putData(
            imgPath, SettableMetadata(contentType: 'image/jpeg'));
        TaskSnapshot snap = await uploadTask;

        // Get img url
        String url = await snap.ref.getDownloadURL();

        return url;
      } else {
        showToast('This image is not valid, please try another one');
        return '';
      }
    } catch (e) {
      showWrongToast();
      return '';
    }
  }

  static Future<void> deleteImageFromStorage(
      String directory, String imgName) async {
    try {
      // Get reference to the image in Firebase Storage
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('$directory/$imgName');

      // Delete the image
      await storageReference.delete();
    } catch (e) {
      debugPrint('Error deleting image: $e');
      showToast('Something went wrong while deleting the image');
    }
  }
}
