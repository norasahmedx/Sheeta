import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sheeta/components/bodies/home_screen.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/screens/others/publish_post.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: mobBg,
                floating: true,
                toolbarHeight: xxxl * 1.5,
                snap: true,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: medium),
                  child: SvgPicture.asset(
                    'assets/sheeta.svg',
                    height: xxxl * 1.45,
                  ),
                ),
                actions: [
                  Container(
                    padding:
                        const EdgeInsets.only(bottom: medium, left: medium),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PublishPost()),
                        );
                      },
                      icon: const Icon(Icons.add_a_photo_rounded, size: xxl),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(bottom: medium, left: medium),
                    child: IconButton(
                      onPressed: () async {
                        await Auth().logout(context);
                      },
                      icon: const Icon(Icons.logout, size: xxl),
                    ),
                  ),
                ],
              ),
            ];
          },
          body: const HomeScreen()),
    );
  }
}
