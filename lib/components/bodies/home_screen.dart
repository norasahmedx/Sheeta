import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/post_card/post_card.dart';
import 'package:sheeta/components/designs/cards/snackbar.dart';
import 'package:sheeta/firebase/posts.dart';
import 'package:sheeta/models/post.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Posts().get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Using addPostFrameCallback to ensure the context is still valid
            showSnackBar(
                context, 'Something went wrong, please try again later.');
          });
          return Container(); // You might want to return an empty container or loading indicator here
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            Post post = Post.fromMap(data);

            // data['username']
            return PostCard(post: post);
          }).toList(),
        );
      },
    );
  }
}
