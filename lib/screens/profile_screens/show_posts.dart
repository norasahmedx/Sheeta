import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/post_card/post_card.dart';
import 'package:sheeta/components/designs/loadings/circle.dart';
import 'package:sheeta/models/post.dart';

class ShowPosts extends StatelessWidget {
  final String uid;
  final int initialPostIndex;

  const ShowPosts({
    Key? key,
    required this.uid,
    required this.initialPostIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          // Handle error
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Handle loading
          return const LoaderCircle();
        }

        // Use WidgetsBinding.instance.addPostFrameCallback to ensure the ListView has been built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Scroll to the initial post index
          scrollController.jumpTo(initialPostIndex * 480);
        });

        return ListView.builder(
          controller: scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data =
                snapshot.data!.docs[index].data()! as Map<String, dynamic>;

            Post post = Post.fromMap(data);

            return PostCard(post: post);
          },
        );
      },
    );
  }
}
