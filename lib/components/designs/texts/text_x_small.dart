import 'package:flutter/material.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class TextXSmall extends StatelessWidget {
  final String txt;
  final Color? color;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  const TextXSmall({
    super.key,
    required this.txt,
    this.color = whiteDarker,
    this.fontWeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget text = Text(
      txt,
      style: TextStyle(
        fontSize: ss + 2,
        color: color,
        fontWeight: fontWeight,
      ),
    );

    if (onTap == null) {
      return text;
    } else {
      return GestureDetector(
        onTap: onTap,
        child: text,
      );
    }
  }
}
