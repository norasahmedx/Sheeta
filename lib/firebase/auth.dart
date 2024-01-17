import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheeta/components/designs/cards/snackbar.dart';
import 'package:sheeta/firebase/comments.dart';
import 'package:sheeta/firebase/posts.dart';
import 'package:sheeta/firebase/storage.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/providers/user_provider.dart';
import 'package:sheeta/screens/auth/login.dart';
import 'dart:developer';
import 'package:sheeta/shared/show_toast.dart';

class Auth {
  final table = 'users';

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCollection(
      {required String collection, required String uid}) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(table)
          .doc(uid)
          .collection(collection)
          .get();

      return snapshot.docs;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<int> getCollectionLength(
      {required String collection, required String uid}) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(table)
          .doc(uid)
          .collection(collection)
          .get();

      return snapshot.size;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }

  Future<bool> uniqueField(String field, String value) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .where(field, isEqualTo: value)
          .get();
      return result.docs.isEmpty;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  bool amIFollow({required BuildContext context, required List followers}) {
    try {
      final auth = Provider.of<UserProvider>(context, listen: false).getUser;
      bool followedHim =
          followers.any((follower) => follower['username'] == auth!.username);
      return followedHim;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// switch me in his followers
  /// Which means:
  /// adding me in his followers
  /// adding him in my following
  /// and vice versa
  followSwitch(
      {required BuildContext context,
      required UserData? user,
      required String type}) async {
    try {
      UserData auth =
          Provider.of<UserProvider>(context, listen: false).getUser!;

      //* switch me in his followers
      if (type == 'add') {
        await FirebaseFirestore.instance
            .collection(table)
            .doc(user!.uid)
            .collection('followers')
            .doc(auth.uid)
            .set({
          'uid': auth.uid,
          'username': auth.username,
          'avatar': auth.avatar,
          'bio': auth.bio,
        });
      } else {
        await FirebaseFirestore.instance
            .collection(table)
            .doc(user!.uid)
            .collection('followers')
            .doc(auth.uid)
            .delete();
      }
      //* switch him in my following
      if (type == 'add') {
        await FirebaseFirestore.instance
            .collection(table)
            .doc(auth.uid)
            .collection('following')
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'username': user.username,
          'avatar': user.avatar,
          'bio': user.bio,
        });
      } else {
        await FirebaseFirestore.instance
            .collection(table)
            .doc(auth.uid)
            .collection('following')
            .doc(user.uid)
            .delete();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> update({
    required BuildContext context,
    required String bio,
    required String username,
  }) async {
    try {
      final auth = Provider.of<UserProvider>(context, listen: false).getUser;
      final user = {
        'uid': auth!.uid,
        'bio': bio,
        'username': username,
      };

      // update the user's data
      await FirebaseFirestore.instance
          .collection(table)
          .doc(auth.uid)
          .update(user);
      // update the user's data in every single post
      await Posts().updateUserInfo(user);
      // update the user's data in every single comment
      await Comments().updateUserInfo(user);

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<UserData> updateAvatar({
    required UserData? oldUser,
    required imgName,
    required imgPath,
  }) async {
    try {
      if (imgName != null || imgPath != null) {
        // delete the old avatar from storage if the user already published an avatar
        if (oldUser!.avatarName != 'default.png') {
          Storage.deleteImageFromStorage('avatar', oldUser.avatarName);
        }

        // upload photo to storage
        String url = await Storage.getImgURL(imgName, imgPath, 'avatar');

        final user = {'avatar': url, 'avatarName': imgName};

        // update the user's data
        await FirebaseFirestore.instance
            .collection(table)
            .doc(oldUser.uid)
            .update(user);
        // update the user's data in every single post
        await Posts().updateUserInfo(user);
        // update the user's data in every single comment
        await Comments().updateUserInfo(user);

        // Success Message
        showToast('Your avatar updated successfully');

        //* Get the updated user data
        var userDocument = await FirebaseFirestore.instance
            .collection(table)
            .doc(oldUser.uid)
            .get();

        // Convert DocumentSnapshot to UserData
        UserData updatedUserData = UserData.fromSnapshot(userDocument);

        // Return the updated user data
        return updatedUserData;
      } else {
        showToast('Something wrong happened, please try again later');
        // Return some default user data or handle the error accordingly
        return UserData(
          uid: '',
          email: '',
          username: '',
          bio: '',
          avatar: '',
          avatarName: '',
        );
      }
    } catch (e) {
      showToast('Something wrong happened, please try again later');
      log(e.toString());
      return UserData(
        uid: '',
        email: '',
        username: '',
        bio: '',
        avatar: '',
        avatarName: '',
      );
    }
  }

  isItMe({required String uid}) {
    try {
      return uid == FirebaseAuth.instance.currentUser!.uid;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UserData> getById({required String uid}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      return UserData.convertSnap2Model(snapshot);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<DocumentSnapshot<Object?>>? getStreamById(
      {required String uid}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      return snapshot;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  searchBy({required String val, required String prop}) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(table)
          .orderBy(prop)
          .startAt([val]).endAt(['$val\uf8ff']).get();

      return snapshot;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  get() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      return UserData.convertSnap2Model(snapshot);
    } catch (e) {
      log(e.toString());
    }
  }

  refresh(BuildContext context) async {
    try {
      UserProvider userProvider = Provider.of(context, listen: false);
      await userProvider.refreshUser();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> register({
    required BuildContext ctx,
    required username,
    required email,
    required bio,
    required password,
    required imgName,
    required imgPath,
  }) async {
    try {
      if (!Storage.isValidImage(imgPath)) {
        showToast('The image is not valid, please try another one');
        return false;
      }

      if (!await Auth().uniqueField('username', username)) {
        showToast('The username is already taken. Please choose another one.');
        return false;
      }

      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (FirebaseAuth.instance.currentUser != null) {
        // Registration successful, now upload the image
        String url = await Storage.getImgURL(imgName, imgPath, 'avatar');

        //* Check if the image is a valid image or not
        if (url.isEmpty) {}

        // Send user data to Firestore
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        UserData user = UserData(
          email: email,
          bio: bio,
          username: username,
          avatar: url.isEmpty
              ? 'https://firebasestorage.googleapis.com/v0/b/sheeta-noras.appspot.com/o/avatar%2Fdefault.png?alt=media&token=ff23e64b-8a7f-4303-86ce-228107085438'
              : url,
          avatarName: imgName ?? 'default.png',
          uid: credential.user!.uid,
        );

        await users.doc(credential.user!.uid).set(user.convertToMap());

        // Show success message
        if (ctx.mounted) {
          showToast('Your account was created successfully!');
        }

        return true;
      } else {
        showToast('Registration failed. Please try again.');
        return false;
      }
    } catch (e) {
      showToast('Something went wrong. Please try again later.');
      debugPrint(e.toString());
      return false;
    }
  }

  login({
    required BuildContext ctx,
    required emailAddress,
    required password,
  }) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        log(e.code);
        showSnackBar(
            ctx, 'Email address or password is incorrect, try again ❤');
      } else {
        log(e.code);
        showSnackBar(ctx, 'Something went wrong, try refresh the app');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
    showSnackBar(context, 'We will missing you 😥');
  }
}
