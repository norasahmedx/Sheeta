import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 4),
    content: Text(text),
    action: SnackBarAction(label: "close", onPressed: () {}),
  ));
}

somethingWrong(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 4),
    content: const Text('Something went wrong, please try again later'),
    action: SnackBarAction(label: "close", onPressed: () {}),
  ));
}
