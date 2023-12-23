import 'package:flutter/material.dart';
import 'package:sheeta/static/sizes.dart';

class TextXXSmall extends StatelessWidget {
  final String txt;
  final Color? color;
  final FontWeight? fontWeight;
  const TextXXSmall(
      {super.key, required this.txt, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: medium,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
