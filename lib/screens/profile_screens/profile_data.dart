import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/texts/text_title.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/screens/profile_screens/followers.dart';
import 'package:sheeta/screens/profile_screens/following.dart';
import 'package:sheeta/screens/profile_screens/show_posts.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class ProfileData extends StatelessWidget {
  final UserData? user;
  final int initIndex;
  final int initialPostIndex;
  const ProfileData(
      {super.key,
      required this.user,
      required this.initIndex,
      this.initialPostIndex = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initIndex,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobBg,
          title: TextTitle(txt: user!.username),
        ),
        body: Column(
          children: [
            const TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(fontSize: medium),
              indicatorSize: TabBarIndicatorSize.tab, // Set the indicator size
              tabs: [
                Tab(child: Text('posts')),
                Tab(child: Text('followers')),
                Tab(child: Text('following')),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ShowPosts(uid: user!.uid, initialPostIndex: initialPostIndex),
                  Followers(uid: user!.uid),
                  Following(uid: user!.uid),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
