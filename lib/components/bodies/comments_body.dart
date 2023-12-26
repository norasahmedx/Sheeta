import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/comment/comment_card.dart';
import 'package:sheeta/components/designs/loadings/circle.dart';
import 'package:sheeta/components/designs/texts/text_medium.dart';
import 'package:sheeta/components/designs/texts/text_title.dart';
import 'package:sheeta/firebase/comments.dart';
import 'package:sheeta/models/comment.dart';
import 'package:sheeta/shared/show_toast.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class CommentsBody extends StatelessWidget {
  final String postId;
  final Function replyOnUser;
  const CommentsBody(
      {super.key, required this.postId, required this.replyOnUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Comments().getCommentsByPostId(postId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          showToast('Something went wrong, please try again later.');
          debugPrint(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: LoaderCircle());
        }

        return Expanded(
          child: snapshot.data!.size > 0
              ? ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    Comment comment = Comment.fromMap(data);
                    return CommentCard(
                        comment: comment, replyOnUser: replyOnUser);
                  }).toList(),
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextTitle(
                        txt: 'No comments yet!', color: primaryAccentColor),
                    SizedBox(height: small),
                    TextMedium(txt: 'Be the first one commented!'),
                  ],
                ),
        );
      },
    );
  }
}
