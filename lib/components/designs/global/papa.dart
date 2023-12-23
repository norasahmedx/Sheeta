import 'package:flutter/material.dart';
import 'package:sheeta/static/sizes.dart';

class Papa extends StatelessWidget {
  final Widget child;
  const Papa({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: medium),
      child: child,
    );
  }
}
