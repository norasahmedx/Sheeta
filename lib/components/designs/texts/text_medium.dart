import 'package:flutter/material.dart';
import 'package:sheeta/static/sizes.dart';

class TextMedium extends StatelessWidget {
  final String txt;
  final FontWeight? fontWeight;
  const TextMedium({super.key, required this.txt, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(fontSize: xm, fontWeight: fontWeight),
    );
  }
}
