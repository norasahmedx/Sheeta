import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/user_avatar.dart';
import 'package:sheeta/components/designs/loadings/skelton.dart';
import 'package:sheeta/components/designs/texts/text_x_small.dart';
import 'package:sheeta/components/designs/texts/text_xx_small.dart';
import 'package:sheeta/models/post.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/static/colors.dart';

class PostHeadline extends StatelessWidget {
  final Post post;
  final UserData? user;
  const PostHeadline({
    super.key,
    required this.post,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            UserAvatar(user: user),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                user != null
                    ? TextXXSmall(txt: user!.username)
                    : const SkeltonUsername(),
                user != null
                    ? TextXSmall(txt: user!.bio)
                    : const Skelton(width: 140, height: 20)
              ],
            )
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: textColor,
            )),
      ],
    );
  }
}
