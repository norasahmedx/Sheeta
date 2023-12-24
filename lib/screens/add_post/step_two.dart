import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/add_post_card.dart';
import 'package:sheeta/components/designs/global/is_loading.dart';
import 'package:sheeta/firebase/posts.dart';
import 'package:sheeta/screens/grand_screen.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class StepTwo extends StatefulWidget {
  final Function updateImg;
  final Uint8List? imgPath;
  final String? imgName;

  const StepTwo({
    super.key,
    required this.updateImg,
    required this.imgName,
    required this.imgPath,
  });

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  final descriptionController = TextEditingController();
  bool loaded = true;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        imgName: widget.imgName,
        imgPath: widget.imgPath,
        likes: [],
        commentsIds: [],
      );

      if (!mounted) return;
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const GrandScreen()),
      );
    }

    return Scaffold(
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
        leading: IconButton(
            onPressed: () => widget.updateImg(null, null),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: IsLoading(
        keepChild: true,
        type: 'linear',
        loaded: loaded,
        child: AddPostCard(
          updateImg: widget.updateImg,
          imgPath: widget.imgPath,
          imgName: widget.imgName,
          descriptionController: descriptionController,
        ),
      ),
    );
  }
}
