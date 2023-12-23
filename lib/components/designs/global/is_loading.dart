import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/loadings/loading_circle.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class IsLoading extends StatelessWidget {
  final Widget child;
  final String type;
  final bool loaded;
  final bool keepChild;
  const IsLoading({
    super.key,
    required this.child,
    required this.loaded,
    this.type = 'circular',
    this.keepChild = false,
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
