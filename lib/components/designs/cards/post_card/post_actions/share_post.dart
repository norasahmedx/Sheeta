import 'package:flutter/material.dart';
import 'package:sheeta/static/sizes.dart';

class SharePost extends StatelessWidget {
  const SharePost({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.send,
          size: xl,
        ));
  }
}
