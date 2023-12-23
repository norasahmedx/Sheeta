import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/loadings/skelton.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class PostTitle extends StatelessWidget {
  final UserData? user;
  final String description;

  const PostTitle({Key? key, required this.user, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        user != null
            ? Text(
                user!.username.toUpperCase(),
                style: const TextStyle(
                  fontSize: xm,
                  fontWeight: FontWeight.bold,
                  color: whiteDarker,
                ),
              )
            : const SkeltonUsername(),
        const SizedBox(width: small + 2),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: medium,
              color: whiteDarker,
            ),
            overflow:
                TextOverflow.ellipsis, // Adjust this based on your preference
          ),
        ),
      ],
    );
  }
}
