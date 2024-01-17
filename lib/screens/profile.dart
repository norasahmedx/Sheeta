import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheeta/components/bodies/profile/profile_screen.dart';
import 'package:sheeta/components/designs/containers/screen_container.dart';
import 'package:sheeta/components/designs/global/is_loading.dart';
import 'package:sheeta/components/designs/texts/text_title.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/firebase/posts.dart';
import 'package:sheeta/firebase/storage.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/providers/user_provider.dart';
import 'package:sheeta/shared/show_toast.dart';
import 'package:sheeta/static/colors.dart';

class Profile extends StatefulWidget {
  final String uid;
  const Profile({super.key, required this.uid});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loaded = false;
  bool isAvatarLoaded = true;
  UserData? userInfo;
  bool? isItMe;
  bool follow = false;
  bool followback = false;
  int posts = 0;
  int followers = 0;
  int following = 0;

  void updateImg(Uint8List? path, String? name) async {
    setState(() {
      isAvatarLoaded = false;
    });
    if (path == null || name == null) {
      // Handle null inputs
      showToast('The image was not found');
      setState(() {
        isAvatarLoaded = true;
      });
      return;
    }

    //* Check if the image is valid
    if (Storage.isValidImage(path)) {
      //* delete the old image from the db
      final oldUser = await Auth().getById(uid: widget.uid);
      Storage.deleteImageFromStorage('avatar', oldUser.avatar);

      //* send the image to db
      final user = await Auth()
          .updateAvatar(oldUser: oldUser, imgName: name, imgPath: path);

      //* Update userInfo data
      setState(() {
        userInfo = user;
        Provider.of<UserProvider>(context, listen: false).refreshUser();
      });
    } else {
      // Handle invalid image
      showToast('You selected an invalid image');
    }
    setState(() {
      isAvatarLoaded = true;
    });
  }

  Future<void> updateFollowers() async {
    int fls = followers = await Auth()
        .getCollectionLength(collection: 'followers', uid: userInfo!.uid);
    if (mounted) {
      setState(() {
        follow = !follow;
        followers = fls;
      });
    }
  }

  Future<void> updateUserInfo() async {
    UserData? user = await Auth().getById(uid: widget.uid);

    setState(() {
      userInfo = user;
    });
  }

  fetch() async {
    try {
      UserData? user = await Auth().getById(uid: widget.uid);
      bool check = Auth().isItMe(uid: widget.uid);
      List fls =
          await Auth().getCollection(collection: 'followers', uid: widget.uid);
      int flg = followers = await Auth()
          .getCollectionLength(collection: 'following', uid: widget.uid);
      bool amIFollow = false;
      // if the user is NOT me then do these functionalities
      if (!check) {
        if (!mounted) return;
        amIFollow = Auth().amIFollow(context: context, followers: fls);
      }

      List p = await Posts().getAllBy(prop: 'uid', val: widget.uid);

      setState(() {
        loaded = false;
        userInfo = user;
        isItMe = check;
        follow = amIFollow;
        loaded = true;
        followers = fls.length;
        following = flg;
        posts = p.length;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return IsLoading(
      loaded: loaded,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobBg,
          title: userInfo != null ? TextTitle(txt: userInfo!.username) : null,
        ),
        body: SingleChildScrollView(
          child: ScreenContainer(
            paddingTop: 15,
            child: ProfileScreen(
              followers: followers,
              following: following,
              posts: posts,
              userInfo: userInfo,
              isItMe: isItMe,
              follow: follow,
              followback: followback,
              updateFollowers: updateFollowers,
              updateUserInfo: updateUserInfo,
              updateImg: updateImg,
              isAvatarLoaded: isAvatarLoaded,
            ),
          ),
        ),
      ),
    );
  }
}
