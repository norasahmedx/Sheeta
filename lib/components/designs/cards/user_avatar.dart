import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/loadings/skelton.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/screens/profile.dart';
import 'package:sheeta/static/sizes.dart';

class UserAvatar extends StatelessWidget {
  final UserData? user;
  final String size;
  final bool clickable;
  final bool roundedBorder;
  const UserAvatar({
    super.key,
    this.user,
    this.size = 'm',
    this.clickable = true,
    this.roundedBorder = false,
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
                  child: Avatar(
                      size: size, user: user, roundedBorder: roundedBorder),
                )
              : Avatar(size: size, user: user, roundedBorder: roundedBorder)
          : size == 's'
              ? const Skelton(width: 44, height: 42)
              : size == 'm'
                  ? const Skelton(width: 64, height: 44)
                  : const Skelton(width: 72, height: 52),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.size,
    required this.user,
    required this.roundedBorder,
  }) : super(key: key);

  final String size;
  final UserData? user;
  final bool roundedBorder;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: roundedBorder
              ? Border.all(
                  color: Colors.white, // Change the color as needed
                  width: 1.1, // Adjust the border width as needed
                )
              : null,
        ),
        child: CircleAvatar(
          radius: size == 's'
              ? xm
              : size == 'm'
                  ? large
                  : xxxxl,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(user!.avatar),
        ),
      ),
    );
  }
}
