import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class PostDate extends StatelessWidget {
  final DateTime datePublished;
  const PostDate({super.key, required this.datePublished});

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('yMMMd').format(datePublished),
      style: const TextStyle(
        fontSize: medium,
        color: whiteMoreDarker,
      ),
    );
  }
}
