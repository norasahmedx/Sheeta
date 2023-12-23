import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/static/colors.dart';

class BottomNavbar extends StatefulWidget {
  final Function onPageChanged;
  final PageController pageController;
  final int index;
  const BottomNavbar({
    super.key,
    required this.onPageChanged,
    required this.pageController,
    required this.index,
  });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      currentIndex: widget.index,
      backgroundColor: mobBg,
      onTap: (idx) {
        // navigate to the taped page
        widget.pageController.jumpToPage(idx);
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(
          Icons.home,
          color: widget.index == 0 ? primaryColor : secondaryColor,
        )),
        BottomNavigationBarItem(
            icon: Icon(
          Icons.chat_bubble,
          color: widget.index == 1 ? primaryColor : secondaryColor,
        )),
        BottomNavigationBarItem(
            icon: Icon(
          Icons.search,
          color: widget.index == 2 ? primaryColor : secondaryColor,
        )),
        BottomNavigationBarItem(
            icon: Icon(
          Icons.person,
          color: widget.index == 3 ? primaryColor : secondaryColor,
        )),
      ],
    );
  }
}
