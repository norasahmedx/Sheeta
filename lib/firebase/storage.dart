import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/shared/show_toast.dart';

class Storage {
  Future<String> getImgURL(
    String? imgName,
    Uint8List? imgPath,
    String? directory,
  ) async {
    try {
      // Upload image to firebase storage
      Reference storageRef =
          FirebaseStorage.instance.ref("$directory/$imgName");
      // use this code if u are using flutter web
      UploadTask uploadTask = storageRef.putData(
          imgPath!, SettableMetadata(contentType: 'image/jpeg'));
      TaskSnapshot snap = await uploadTask;

      // Get img url
      String url = await snap.ref.getDownloadURL();

      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteImageFromStorage(String directory, String imgName) async {
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

// Function to compress the image
  Uint8List compressImage(Uint8List imageBytes, {int maxSizeInBytes = 1024}) {
    img.Image image = img.decodeImage(imageBytes)!;

    // Quality is between 0 and 100, adjust it according to your needs
    int quality = 100;

    // Compress the image until it's below the desired size
    while (imageBytes.length > maxSizeInBytes && quality > 0) {
      imageBytes = img.encodeJpg(image, quality: quality);
      quality -= 5;
    }

    return imageBytes;
  }
}
