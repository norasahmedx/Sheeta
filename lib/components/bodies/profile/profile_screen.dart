import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/profile/bio.dart';
import 'package:sheeta/components/designs/cards/profile/profile_action_area.dart';
import 'package:sheeta/components/designs/cards/profile/profile_details.dart';
import 'package:sheeta/components/designs/grids/photos_grid.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/static/sizes.dart';

class ProfileScreen extends StatefulWidget {
  final UserData? userInfo;
  final bool? isItMe;
  final bool follow;
  final bool followback;
  final bool isAvatarLoaded;
  final int followers;
  final int following;
  final int posts;
  final Function updateFollowers;
  final Function updateUserInfo;
  final Function(Uint8List?, String?) updateImg;

  const ProfileScreen({
    super.key,
    required this.userInfo,
    required this.isItMe,
    required this.follow,
    required this.followback,
    required this.followers,
    required this.following,
    required this.posts,
    required this.updateFollowers,
    required this.updateUserInfo,
    required this.updateImg,
    required this.isAvatarLoaded,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool editMode = false;
  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocus = FocusNode();
  String? usernameError;

  addUsernameError(String? msg) {
    if (!mounted) return;
    setState(() {
      usernameError = msg;
    });
  }

  switchEditMode() {
    if (!mounted) return;
    setState(() {
      editMode = !editMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Profile details
          ProfileDetails(
            userInfo: widget.userInfo,
            followers: widget.followers,
            following: widget.following,
            posts: widget.posts,
            updateImg: widget.updateImg,
            isAvatarLoaded: widget.isAvatarLoaded,
            isItMe: widget.isItMe,
          ),
          const SizedBox(height: medium + 5),

          //* Bio section
          Bio(
            userInfo: widget.userInfo,
            editMode: editMode,
            bioController: bioController,
            usernameController: usernameController,
            usernameFocus: usernameFocus,
            usernameError: usernameError,
          ),

          const SizedBox(height: medium),

          //* action area
          ProfileActionArea(
            userInfo: widget.userInfo,
            isItMe: widget.isItMe,
            updateFollowers: widget.updateFollowers,
            follow: widget.follow,
            followback: widget.followback,
            editMode: editMode,
            bioController: bioController,
            usernameController: usernameController,
            usernameFocus: usernameFocus,
            addUsernameError: addUsernameError,
            switchEditMode: switchEditMode,
            updateUserInfo: widget.updateUserInfo,
          ),
          const SizedBox(height: xl),

          //* photos grid
          PhotosGrid(user: widget.userInfo),
        ],
      ),
    );
  }
}
