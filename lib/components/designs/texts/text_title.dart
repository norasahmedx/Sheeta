import 'package:flutter/material.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class TextTitle extends StatelessWidget {
  final String txt;
  final Color? color;
  final FontWeight? fontWeight;
  const TextTitle({
    super.key,
    required this.txt,
    this.color = textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: xl,
      ),
    );
  }
}
