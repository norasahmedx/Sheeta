import 'package:flutter/material.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class PostLikesCount extends StatelessWidget {
  final List likes;
  const PostLikesCount({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${likes.length} likes',
      style: const TextStyle(
        fontSize: xm,
        color: whiteMoreDarker,
      ),
    );
  }
}
