import 'package:flutter/material.dart';
import 'package:sheeta/static/colors.dart';

class LoaderCircle extends StatelessWidget {
  const LoaderCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: primaryColor));
  }
}
