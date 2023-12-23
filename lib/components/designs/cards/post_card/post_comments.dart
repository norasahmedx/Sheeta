import 'package:flutter/material.dart';
import 'package:sheeta/models/post.dart';
import 'package:sheeta/screens/others/comments.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class PostComments extends StatelessWidget {
  final Post post;
  const PostComments({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CommentsScreen(postId: post.id)),
        );
      },
      child: Text(
        'view all ${post.commentsIds.length} comments',
        style: const TextStyle(
          fontSize: medium,
          color: whiteMoreDarker,
        ),
      ),
    );
  }
}
