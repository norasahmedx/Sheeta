import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/loadings/loading_circle.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class IsLoading extends StatelessWidget {
  final String type;
  final bool loaded;
  final bool keepChild;
  final Widget child;
  const IsLoading({
    super.key,
    required this.loaded,
    this.type = 'circular',
    this.keepChild = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return loaded
        ? type == 'linear'
            ? Column(children: [const Divider(thickness: 1, height: 30), child])
            : child
        : type == 'circular'
            ? const LoadingCircle()
            : keepChild
                ? Column(
                    children: [
                      const LinearProgressIndicator(color: primaryColor),
                      const SizedBox(height: large * 1.5),
                      child,
                    ],
                  )
                : const LinearProgressIndicator(color: primaryColor);
  }
}
