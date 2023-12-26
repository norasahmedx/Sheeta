import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/user_avatar.dart';
import 'package:sheeta/components/designs/cards/user_details.dart';
import 'package:sheeta/components/designs/images/form_image_picker.dart';
import 'package:sheeta/models/user.dart';

class ProfileDetails extends StatefulWidget {
  final UserData? userInfo;
  final int followers;
  final int following;
  final int posts;
  final bool isAvatarLoaded;
  final bool? isItMe;

  final Function(Uint8List?, String?) updateImg;
  const ProfileDetails({
    super.key,
    required this.userInfo,
    required this.followers,
    required this.following,
    required this.posts,
    required this.updateImg,
    required this.isAvatarLoaded,
    required this.isItMe,
  });

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget.isItMe!
            ? FormImagePicker(
                updateImg: widget.updateImg,
                defImage: widget.userInfo!.avatar,
                profile: true,
                isAvatarLoaded: widget.isAvatarLoaded,
              )
            : GestureDetector(
                onTap: () {},
                child: UserAvatar(
                  user: widget.userInfo,
                  clickable: false,
                  size: 'l',
                ),
              ),
        UserDetails(
          followers: widget.followers,
          following: widget.following,
          userInfo: widget.userInfo,
          posts: widget.posts,
          user: widget.userInfo,
        ),
      ],
    );
  }
}
