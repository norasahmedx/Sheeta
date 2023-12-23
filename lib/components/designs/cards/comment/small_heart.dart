import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/animation/like.dart';
import 'package:sheeta/components/designs/texts/text_small.dart';
import 'package:sheeta/firebase/comments.dart';
import 'package:sheeta/models/comment.dart';
import 'package:sheeta/static/sizes.dart';

class CommentSmallHeart extends StatefulWidget {
  final Comment comment;
  const CommentSmallHeart({super.key, required this.comment});

  @override
  State<CommentSmallHeart> createState() => _CommentSmallHeartState();
}

class _CommentSmallHeartState extends State<CommentSmallHeart> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    bool check = widget.comment.likes.contains(uid);
    int comments = widget.comment.likes.length;

    return LikeAnimation(
      isAnimating:
          widget.comment.likes.contains(FirebaseAuth.instance.currentUser!.uid),
      smallLike: true,
      child: Column(
        children: [
          IconButton(
            onPressed: () async {
              if (check) {
                await Comments().likeSwitch(
                    commentId: widget.comment.id, type: 'remove');
              } else {
                await Comments().likeSwitch(
                    commentId: widget.comment.id, type: 'add');
              }
            },
            icon: widget.comment.likes
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
          TextSmall(txt: "$comments likes"),
        ],
      ),
    );
  }
}
