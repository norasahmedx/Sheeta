import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/searched_user_card.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/static/colors.dart';

class Followers extends StatelessWidget {
  final String uid;
  const Followers({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Auth().getCollection(collection: 'followers', uid: uid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return SearchedUserCard(users: snapshot.data!);
        }

        return const Center(
            child: CircularProgressIndicator(color: primaryColor));
      },
    );
  }
}
