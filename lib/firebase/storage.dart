// Function to get img url

import 'package:firebase_storage/firebase_storage.dart';

Future<String> getImgURL({
  required imgName,
  required imgPath,
  String directory = 'avatar',
}) async {
  // Upload image to firebase storage
  Reference storageRef = FirebaseStorage.instance.ref("$directory/$imgName");
  // use this code if u are using flutter web
  UploadTask uploadTask = storageRef.putData(imgPath);
  TaskSnapshot snap = await uploadTask;

  // Get img url
  String url = await snap.ref.getDownloadURL();

  return url;
}
