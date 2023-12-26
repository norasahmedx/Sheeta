import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<String> getImgURL({
  required imgName,
  required imgPath,
  String directory = 'avatar',
}) async {
  try {
    // Upload image to firebase storage
    Reference storageRef = FirebaseStorage.instance.ref("$directory/$imgName");
    // use this code if u are using flutter web
    UploadTask uploadTask = storageRef.putData(imgPath);
    TaskSnapshot snap = await uploadTask;

    // Get img url
    String url = await snap.ref.getDownloadURL();

    return url;
  } catch (e) {
    return '';
  }
}

Future<void> deleteImageFromStorage(String directory, String imgName) async {
  try {
    // Get reference to the image in Firebase Storage
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('$directory/$imgName');

    // Delete the image
    await storageReference.delete();

    debugPrint('Image deleted successfully');
  } catch (e) {
    debugPrint('Error deleting image: $e');
    // Handle the error as needed
  }
}
