import 'package:flutter/material.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class NormalImage extends StatelessWidget {
  final String src;
  const NormalImage({super.key, required this.src});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        src,
        loadingBuilder: (context, child, progress) {
          return progress == null
              ? child
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: const Center(
                      child: CircularProgressIndicator(color: primaryColor)),
                );
        },
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
      ),
    );
  }
}
