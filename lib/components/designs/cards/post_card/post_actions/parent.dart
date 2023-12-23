import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/post_card/small_heart.dart';
import 'package:sheeta/components/designs/cards/post_card/post_actions/add_comment.dart';
import 'package:sheeta/components/designs/cards/post_card/post_actions/share_post.dart';
import 'package:sheeta/models/post.dart';
import 'package:sheeta/static/sizes.dart';

class PostActionArea extends StatelessWidget {
  final Post post;
  const PostActionArea({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      // action area
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // left side
        Row(
          children: [
            SmallHeart(post: post),
            const SizedBox(width: 5),
            AddComment(postId: post.id),
            const SizedBox(width: 5),
            const SharePost(),
            const SizedBox(width: 5),
          ],
        ),
        // right side
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_outline,
              size: xl,
            )),
      ],
    );
  }
}
