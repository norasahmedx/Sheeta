import 'package:flutter/material.dart';
import 'package:sheeta/static/sizes.dart';

class TextSmall extends StatelessWidget {
  final String txt;
  final Color? color;
  final FontWeight? fontWeight;
  const TextSmall({super.key, required this.txt, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: ss,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
