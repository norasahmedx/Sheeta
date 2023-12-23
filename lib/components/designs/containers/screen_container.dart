import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  final Widget child;
  final double paddingTop;
  const ScreenContainer({super.key, required this.child, this.paddingTop = 30});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: paddingTop),
      child: child,
    );
  }
}
