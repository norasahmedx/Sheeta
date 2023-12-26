import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/add_post_card.dart';
import 'package:sheeta/components/designs/global/is_loading.dart';
import 'package:sheeta/components/designs/images/sheeta_gallery.dart';
import 'package:sheeta/firebase/posts.dart';
import 'package:sheeta/screens/grand_screen.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class PublishPost extends StatefulWidget {
  const PublishPost({super.key});

  @override
  State<PublishPost> createState() => _PublishPostState();
}

class _PublishPostState extends State<PublishPost> {
  final descriptionController = TextEditingController();
  bool loaded = true;
  String? imgName;
  Uint8List? imgPath;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void updateImg(Uint8List? path, String? name) {
      setState(() {
        imgName = name;
        imgPath = path;
      });
    }

    uploadPostHandler() async {
      FocusManager.instance.primaryFocus?.unfocus();
      if (mounted) {
        setState(() {
          loaded = false;
        });
      }

      await Posts().create(
        context: context,
        description: descriptionController.text,
        imgName: imgName,
        imgPath: imgPath,
        likes: [],
        commentsIds: [],
      );

      if (!mounted) return;
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const GrandScreen()),
      );
    }

    return imgPath == null
        ? SheetaGallery(updateImg: updateImg)
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobBg,
              actions: [
                TextButton(
                    onPressed: uploadPostHandler,
                    child: const Text(
                      "Post",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: medium,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
            body: IsLoading(
              keepChild: true,
              type: 'linear',
              loaded: loaded,
              child: AddPostCard(
                updateImg: updateImg,
                imgPath: imgPath,
                imgName: imgName,
                descriptionController: descriptionController,
              ),
            ),
          );
  }
}
