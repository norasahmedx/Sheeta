import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/loadings/skelton.dart';
import 'package:sheeta/components/designs/texts/text_x_small.dart';
import 'package:sheeta/components/designs/texts/text_xx_small.dart';
import 'package:sheeta/models/comment.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class CommentCardDetails extends StatefulWidget {
  final UserData? user;
  final Comment comment;
  final String commentBody;
  final String createdTime;
  final String? grandCommentId;
  final Function replyOnUser;
  final Function openReps;

  const CommentCardDetails({
    super.key,
    required this.user,
    required this.comment,
    required this.commentBody,
    required this.createdTime,
    required this.grandCommentId,
    required this.replyOnUser,
    required this.openReps,
  });

  @override
  State<CommentCardDetails> createState() => _CommentCardDetailsState();
}

class _CommentCardDetailsState extends State<CommentCardDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.user != null
            ? TextXXSmall(
                txt: widget.user!.username, fontWeight: FontWeight.bold)
            : const SkeltonUsername(),
        const SizedBox(height: 2),
        TextXXSmall(txt: widget.commentBody),
        const SizedBox(height: xs - 3),
        Row(
          children: [
            TextXSmall(
              onTap: () {
                widget.openReps();
                widget.replyOnUser(
                  widget.comment.id,
                  widget.grandCommentId,
                  widget.user!.username,
                );
              },
              txt: 'Reply',
              color: whiteDarker900,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(width: medium),
            TextXSmall(
              txt: widget.createdTime,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        const SizedBox(height: xs + 3),
      ],
    );
  }
}
