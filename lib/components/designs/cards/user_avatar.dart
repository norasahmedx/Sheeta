import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/loadings/circle.dart';
import 'package:sheeta/components/designs/loadings/skelton.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/screens/profile.dart';
import 'package:sheeta/static/sizes.dart';

class UserAvatar extends StatelessWidget {
  final UserData? user;
  final String size;
  final bool clickable;
  const UserAvatar({
    super.key,
    this.user,
    this.size = 'm',
    this.clickable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: ss),
      child: user != null
          ? clickable
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(uid: user!.uid)));
                  },
                  child: CircleAvatar(
                    radius: size == 's'
                        ? large
                        : size == 'm'
                            ? xxl
                            : xxxxl,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        user != null ? NetworkImage(user!.avatar) : null,
                  ),
                )
              : CircleAvatar(
                  radius: size == 's'
                      ? large
                      : size == 'm'
                          ? xxl
                          : xxxxl,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      user != null ? NetworkImage(user!.avatar) : null,
                  child: user == null ? const LoaderCircle() : null,
                )
          : size == 's'
              ? const Skelton(width: 44, height: 42)
              : size == 'm'
                  ? const Skelton(width: 64, height: 44)
                  : const Skelton(width: 72, height: 52),
    );
  }
}
