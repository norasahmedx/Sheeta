import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/images/picker.dart';

class AddPostImage extends StatefulWidget {
  final Function updateImg;
  final Uint8List? imgPath;
  final String? imgName;

  const AddPostImage({
    super.key,
    required this.updateImg,
    required this.imgName,
    required this.imgPath,
  });

  @override
  State<AddPostImage> createState() => _AddPostImageState();
}

class _AddPostImageState extends State<AddPostImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Picker().showmodel(context, setState, widget.updateImg);
      },
      child: Container(
        width: 66,
        height: 74,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: MemoryImage(widget.imgPath!),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
