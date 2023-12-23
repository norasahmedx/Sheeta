import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/user_details_card.dart';
import 'package:sheeta/models/user.dart';

class UserDetails extends StatelessWidget {
  final UserData? userInfo;
  final int followers;
  final int following;
  final int posts;
  final UserData? user;
  const UserDetails({
    super.key,
    required this.userInfo,
    required this.followers,
    required this.following,
    required this.posts,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserDetailsCard(
          no: posts,
          title: 'Posts',
          user: user,
          initIndex: 0,
        ),
        UserDetailsCard(
          no: followers,
          title: 'Followers',
          user: user,
          initIndex: 1,
        ),
        UserDetailsCard(
          no: following,
          title: 'Following',
          user: user,
          initIndex: 2,
        ),
      ],
    );
  }
}
