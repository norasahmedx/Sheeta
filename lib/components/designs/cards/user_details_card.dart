import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/texts/text_title.dart';
import 'package:sheeta/components/designs/texts/text_x_small.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/screens/profile_screens/profile_data.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class UserDetailsCard extends StatelessWidget {
  final int no;
  final String title;
  final UserData? user;
  final int initIndex;
  const UserDetailsCard({
    super.key,
    required this.no,
    required this.title,
    required this.user,
    required this.initIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfileData(user: user, initIndex: initIndex)));
      },
      child: Container(
        padding: const EdgeInsets.all(small + 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextTitle(txt: no.toString(), fontWeight: FontWeight.bold),
            const SizedBox(height: 5),
            TextXSmall(txt: title, color: whiteDarker),
          ],
        ),
      ),
    );
  }
}
