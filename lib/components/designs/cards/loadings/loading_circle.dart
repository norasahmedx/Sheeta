import 'package:flutter/material.dart';
import 'package:sheeta/static/colors.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: primaryColor,
        strokeAlign: 6,
        strokeWidth: 6,
      ),
    );
  }
}
