import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/images/sheeta_gallery.dart';
import 'package:sheeta/models/image.dart';
import 'package:sheeta/static/sizes.dart';

class FormImagePicker extends StatefulWidget {
  final Function(Uint8List?, String?) updateImg;
  final Uint8List? imgPath;
  final String? imgName;
  final String defImage;
  final bool profile;
  final bool isAvatarLoaded;

  const FormImagePicker({
    super.key,
    required this.updateImg,
    this.imgName,
    this.imgPath,
    this.defImage = 'assets/default.png',
    this.profile = false,
    this.isAvatarLoaded = true,
  });

  @override
  State<FormImagePicker> createState() => _FormImagePickerState();
}

class _FormImagePickerState extends State<FormImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(125, 78, 91, 110),
      ),
      child: GestureDetector(
        onTap: () async {
          final Photo? img = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SheetaGallery()));
          img != null ? widget.updateImg(img.imgPath, img.imgName) : null;
        },
        child: !widget.profile
            ? Stack(
                children: [
                  widget.imgPath == null
                      ? CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 225, 225, 225),
                          radius: 71,
                          // backgroundImage: AssetImage("assets/img/avatar.png"),
                          backgroundImage: AssetImage(widget.defImage),
                        )
                      : CircleAvatar(
                          radius: 71,
                          // backgroundImage: AssetImage("assets/img/avatar.png"),
                          backgroundImage: MemoryImage(widget.imgPath!),
                        ),
                  const Positioned(
                    left: 99,
                    bottom: 0,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Color.fromARGB(255, 208, 218, 224),
                    ),
                  ),
                ],
              )
            : CircleAvatar(
                radius: xxxxl,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(widget.defImage),
              ),
      ),
    );
  }
}
