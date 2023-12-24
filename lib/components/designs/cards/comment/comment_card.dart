import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheeta/components/designs/cards/comment/card_details.dart';
import 'package:sheeta/components/designs/cards/comment/small_heart.dart';
import 'package:sheeta/components/designs/cards/comment/small_heart_replies.dart';
import 'package:sheeta/components/designs/cards/user_avatar.dart';
import 'package:sheeta/components/designs/texts/text_x_small.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/firebase/comments.dart';
import 'package:sheeta/models/comment.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/static/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheeta/shared/show_toast.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final String? grandCommentId;
  final Function replyOnUser;
  const CommentCard({
    super.key,
    required this.comment,
    required this.replyOnUser,
    this.grandCommentId,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool showReps = false;
  UserData? user;

  fetchUser() async {
    var u = await Auth().getById(uid: widget.comment.uid);
    if (mounted) {
      setState(() {
        user = u;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    openReps() {
      if (mounted) {
        setState(() {
          showReps = true;
        });
      }
    }

    // if this is the grand comment (Not a Reply)
    if (widget.grandCommentId == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAvatar(user: user),

                // Use Expanded to make CommentCardDetails take remaining space
                Expanded(
                  child: CommentCardDetails(
                    user: user,
                    openReps: openReps,
                    comment: widget.comment,
                    commentBody: widget.comment.body,
                    createdTime:
                        DateFormat('yMMMd').format(widget.comment.createdTime),
                    replyOnUser: widget.replyOnUser,
                    grandCommentId: widget.grandCommentId,
                  ),
                ),
                widget.grandCommentId == null
                    ? CommentSmallHeart(comment: widget.comment)
                    : RepliesSmallHeart(
                        comment: widget.comment,
                        grandCommentId: widget.grandCommentId!),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Comments()
                  .getRepliesByPostId(widget.comment.postId, widget.comment.id),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  showToast('Something went wrong, please try again later.');
                }

                return snapshot.data != null && snapshot.data!.docs.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.only(left: xxxxl * 1.25),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextXSmall(
                                txt: showReps
                                    ? 'Hide ${snapshot.data!.docs.length} replies'
                                    : 'View ${snapshot.data!.docs.length} replies',
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      showReps = !showReps;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: xl),
                              showReps
                                  ? Column(
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                        Map<String, dynamic> data = document
                                            .data()! as Map<String, dynamic>;
                                        Comment reply = Comment.fromMap(data);
                                        return CommentCard(
                                          comment: reply,
                                          replyOnUser: widget.replyOnUser,
                                          grandCommentId: widget.comment.id,
                                        );
                                      }).toList(),
                                    )
                                  : Container(),
                            ]),
                      )
                    : Container();
              },
            )
          ],
        ),
      );
    } else {
      // if this is a reply not a comment
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(
                size: 's',
                user: user,
              ),

              // Use Expanded to make CommentCardDetails take remaining space
              Expanded(
                child: CommentCardDetails(
                  user: user,
                  comment: widget.comment,
                  openReps: openReps,
                  commentBody: widget.comment.body,
                  createdTime:
                      DateFormat('yMMMd').format(widget.comment.createdTime),
                  replyOnUser: widget.replyOnUser,
                  grandCommentId: widget.grandCommentId,
                ),
              ),
              RepliesSmallHeart(
                  comment: widget.comment,
                  grandCommentId: widget.grandCommentId!),
            ],
          ),
        ],
      );
    }
  }
}
