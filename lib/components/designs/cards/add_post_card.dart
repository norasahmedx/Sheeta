import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:sheeta/components/designs/cards/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/images/add_post_image.dart';
import 'package:sheeta/components/designs/inputs/caption.dart';
import 'package:sheeta/providers/user_provider.dart';

class AddPostCard extends StatelessWidget {
  final void Function(Uint8List? path, String? name)  updateImg;
  final Uint8List? imgPath;
  final String? imgName;
  final TextEditingController descriptionController;

  const AddPostCard({
    super.key,
    required this.updateImg,
    required this.imgName,
    required this.imgPath,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(user: user),
          CaptionInput(descriptionController: descriptionController),
          AddPostImage(
            updateImg: updateImg,
            imgPath: imgPath,
            imgName: imgName,
          ),
        ]);
  }
}
