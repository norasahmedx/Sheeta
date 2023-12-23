import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/animation/like.dart';
import 'package:sheeta/firebase/posts.dart';
import 'package:sheeta/models/post.dart';
import 'package:sheeta/static/sizes.dart';

class SmallHeart extends StatefulWidget {
  final Post post;
  const SmallHeart({super.key, required this.post});

  @override
  State<SmallHeart> createState() => _SmallHeartState();
}

class _SmallHeartState extends State<SmallHeart> {
  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final check = widget.post.likes.contains(uid);

    return LikeAnimation(
      isAnimating:
          widget.post.likes.contains(FirebaseAuth.instance.currentUser!.uid),
      smallLike: true,
      child: IconButton(
        onPressed: () async {
          if (check) {
            await Posts().likeSwitch(
                context: context,
                postId: widget.post.id,
                type: 'remove');
          } else {
            await Posts().likeSwitch(
                context: context, postId: widget.post.id, type: 'add');
          }
        },
        icon: widget.post.likes
                .contains(FirebaseAuth.instance.currentUser!.uid)
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
                size: xl,
              )
            : const Icon(
                Icons.favorite_border,
                size: xl,
              ),
      ),
    );
  }
}
