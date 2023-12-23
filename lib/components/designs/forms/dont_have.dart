import 'package:flutter/material.dart';
import 'package:sheeta/static/sizes.dart';

class DontHave extends StatelessWidget {
  final String txt;
  final String txtButton;
  final Widget Function(BuildContext) goTo;
  const DontHave({
    super.key,
    required this.txt,
    required this.txtButton,
    required this.goTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(txt, style: const TextStyle(fontSize: 18)),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: goTo,
                ),
              );
            },
            child: Text(txtButton,
                style: const TextStyle(
                  fontSize: large,
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                ))),
      ],
    );
  }
}
