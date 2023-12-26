import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import 'package:sheeta/components/designs/cards/snackbar.dart';

class Picker {
  uploadImage2Screen(
    ImageSource source,
    BuildContext context,
    dynamic setState,
    void Function(Uint8List? path, String? name) updateImg,
  ) async {
    Navigator.pop(context);
    final XFile? pickedImg = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
    );
    try {
      if (pickedImg != null) {
        Uint8List path = await pickedImg.readAsBytes();
        setState(() {
          String name = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          name = "$random$name";

          //* Send data to the main variables
          updateImg(path, name);
        });
      } else {
        if (!context.mounted) return;
        showSnackBar(context, 'No image selected.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  showmodel(
    BuildContext context,
    dynamic setState,
    void Function(Uint8List? path, String? name) updateImg,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(
                      ImageSource.gallery, context, setState, updateImg);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(
                      ImageSource.gallery, context, setState, updateImg);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  openGallery() async {
    
  }
}
