import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/user_avatar.dart';
import 'package:sheeta/components/designs/loadings/skelton.dart';
import 'package:sheeta/components/designs/texts/text_medium.dart';
import 'package:sheeta/models/post.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

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
            const SizedBox(width: medium),
            user != null
                ? TextMedium(txt: user!.username)
                : const SkeltonUsername(),
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
