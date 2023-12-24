import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/animation/cards/big_heart.dart';
import 'package:sheeta/components/designs/images/normal_image.dart';
import 'package:sheeta/firebase/posts.dart';
import 'package:sheeta/models/post.dart';

class PostImage extends StatefulWidget {
  final Post post;
  const PostImage({super.key, required this.post});

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final check = widget.post.likes.contains(uid);

    toggleLike() {
      if (mounted) {
        setState(() {
          isLikeAnimating = !isLikeAnimating;
        });
      }
    }

    doubleTapHandler() async {
      toggleLike();
      if (!check) {
        await Posts()
            .likeSwitch(context: context, postId: widget.post.id, type: 'add');
      }
    }

    return GestureDetector(
      onDoubleTap: doubleTapHandler,
      child: Stack(
        alignment: Alignment.center,
        children: [
          NormalImage(src: widget.post.post),
          BigHeart(isLikeAnimating: isLikeAnimating, toggleLike: toggleLike)
        ],
      ),
    );
  }
}
