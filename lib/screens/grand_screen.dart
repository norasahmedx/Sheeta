import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheeta/components/designs/global/bottom_navbar.dart';
import 'package:sheeta/components/designs/global/is_loading.dart';
import 'package:sheeta/providers/user_provider.dart';
import 'package:sheeta/screens/chats/chats.dart';
import 'package:sheeta/screens/home.dart';
import 'package:sheeta/screens/profile.dart';
import 'package:sheeta/screens/search.dart';

class GrandScreen extends StatefulWidget {
  const GrandScreen({super.key});

  @override
  State<GrandScreen> createState() => _GrandScreenState();
}

class _GrandScreenState extends State<GrandScreen> {
  final PageController pageController = PageController();
  bool loaded = false;
  String uid = '';
  int index = 0;

  onPageChanged(int idx) {
    setState(() {
      index = idx;
    });
  }

  // To get data from DB using provider
  getDataFromDB() async {
    // data doesn't loaded yet.
    setState(() {
      loaded = false;
    });

    // Provider Work
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();

    if (mounted) {
      setState(() {
        // add the user id to the global user id
        uid = userProvider.getUser!.uid;
        // data was delivered
        loaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return IsLoading(
        loaded: loaded,
        child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomNavbar(
                onPageChanged: onPageChanged,
                pageController: pageController,
                index: index),
            body: PageView(
              controller: pageController,
              onPageChanged: (index) {
                log('index: $index');
                onPageChanged(index);
              },
              children: [
                const Home(),
                const Chats(),
                const Search(),
                Profile(uid: uid),
              ],
            ),
          ),
        ));
  }
}
