import 'package:flutter/material.dart';
import 'package:sheeta/screens/others/comments.dart';
import 'package:sheeta/static/sizes.dart';

class AddComment extends StatelessWidget {
  final String postId;
  const AddComment({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommentsScreen(postId: postId)),
          );
        },
        icon: const Icon(
          Icons.comment_outlined,
          size: xl,
        ));
  }
}
