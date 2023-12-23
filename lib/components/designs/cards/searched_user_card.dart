import 'package:flutter/material.dart';
import 'package:sheeta/screens/profile.dart';
import 'package:sheeta/static/sizes.dart';

class SearchedUserCard extends StatelessWidget {
  final List users;
  const SearchedUserCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              const SizedBox(height: large),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Profile(uid: users[index]['uid'])));
                },
                title: Text(users[index]["username"]),
                leading: CircleAvatar(
                  radius: 33,
                  backgroundImage: NetworkImage(users[index]["avatar"]),
                ),
              ),
            ],
          );
        });
  }
}
