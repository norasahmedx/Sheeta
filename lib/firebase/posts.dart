import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheeta/components/designs/cards/snackbar.dart';
import 'package:sheeta/firebase/storage.dart';
import 'package:sheeta/models/post.dart';
import 'package:sheeta/providers/user_provider.dart';
import 'package:sheeta/shared/show_toast.dart';
import 'package:uuid/uuid.dart';

class Posts {
  final String table = 'posts';
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot<Map<String, dynamic>>> get() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdTime', descending: true)
        .snapshots();
  }

  updateUserInfo(Map<String, dynamic> user) async {
    try {
      // Update the user's avatar in posts where uid is equal to the user's uid
      await FirebaseFirestore.instance
          .collection(table)
          .where('uid', isEqualTo: user['uid'])
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.update(user);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  likeSwitch({
    required BuildContext context,
    required String postId,
    required String type,
  }) async {
    try {
      await FirebaseFirestore.instance.collection(table).doc(postId).update({
        'likes': type == 'add'
            ? FieldValue.arrayUnion([uid])
            : FieldValue.arrayRemove([uid])
      });
    } catch (e) {
      if (!context.mounted) return;
      somethingWrong(context);
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> create({
    required BuildContext context,
    required String description,
    required String? imgName,
    required Uint8List? imgPath,
    required List<String> likes,
    required List<String> commentsIds,
  }) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false).getUser;
      final id = const Uuid().v1();
      final String postBody =
          await Storage.getImgURL(imgName!, imgPath!, '$table/$uid');

      // send data to Firestore
      CollectionReference posts = FirebaseFirestore.instance.collection(table);

      Post post = Post(
        // user data
        uid: user!.uid,
        // post data
        id: id,
        description: description,
        post: postBody,
        createdTime: DateTime.now(),
        likes: [],
        commentsIds: [],
      );

      await posts
          .doc(id)
          .set(post.convertToMap())
          .then((value) => showToast('Your post published successfully'))
          .catchError((error) => showToast("Failed to create post: $error"));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getAllBy({required String prop, required String val}) async {
    try {
      var snapshots = await FirebaseFirestore.instance
          .collection(table)
          .where(prop, isEqualTo: val)
          .get();

      return snapshots.docs;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
