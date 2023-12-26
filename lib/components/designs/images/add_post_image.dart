import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/images/sheeta_gallery.dart';
import 'package:sheeta/models/image.dart';

class AddPostImage extends StatefulWidget {
  final void Function(Uint8List? path, String? name) updateImg;
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
        final Photo? img = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SheetaGallery()));
        img != null ? widget.updateImg(img.imgPath, img.imgName) : null;
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
