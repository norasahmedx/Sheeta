import 'package:flutter/material.dart';

class Skelton extends StatelessWidget {
  final double? height, width;
  const Skelton({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}

class SkeltonUsername extends StatelessWidget {
  const SkeltonUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 20,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}
