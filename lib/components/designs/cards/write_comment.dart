import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/user_avatar.dart';
import 'package:sheeta/components/designs/inputs/comment.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/static/sizes.dart';

class WriteComment extends StatelessWidget {
  final UserData? user;
  final String postId;
  final TextEditingController commentController;
  final FocusNode commentFocus;
  final TextEditingController oldCommentId;
  const WriteComment({
    super.key,
    required this.user,
    required this.postId,
    required this.commentController,
    required this.commentFocus,
    required this.oldCommentId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: medium),
      child: Row(
        children: [
          UserAvatar(size: 's', user: user, clickable: false),
          const SizedBox(width: xs),
          Expanded(
              child: CommentInput(
            postId: postId,
            user: user,
            commentController: commentController,
            commentFocus: commentFocus,
            oldCommentId: oldCommentId,
          )),
          const SizedBox(width: xs),
        ],
      ),
    );
  }
}
