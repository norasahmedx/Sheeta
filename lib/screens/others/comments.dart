import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheeta/components/bodies/comments_body.dart';
import 'package:sheeta/components/designs/cards/write_comment.dart';
import 'package:sheeta/components/designs/containers/screen_container.dart';
import 'package:sheeta/components/designs/texts/text_title.dart';
import 'package:sheeta/providers/user_provider.dart';
import 'package:sheeta/shared/show_toast.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  const CommentsScreen({super.key, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).getUser;
    TextEditingController commentController = TextEditingController();
    TextEditingController oldCommentId = TextEditingController();
    FocusNode commentFocus = FocusNode();

    replyOnUser(
      String commentId,
      String? grandCommentId,
      String username,
    ) {
      try {
        if (grandCommentId == null) {
          commentController.value = TextEditingValue(text: '@$username ');
          oldCommentId.value = TextEditingValue(text: commentId);
        } else {
          commentController.value = TextEditingValue(text: '@$username ');
          oldCommentId.value = TextEditingValue(text: grandCommentId);
        }
        commentFocus.requestFocus();
      } catch (e) {
        debugPrint(e.toString());
        showToast('Something went wrong, please try again later');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobBg,
        title: const TextTitle(txt: 'Comments'),
      ),
      body: ScreenContainer(
        paddingTop: medium - 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommentsBody(postId: widget.postId, replyOnUser: replyOnUser),
            WriteComment(
              postId: widget.postId,
              user: user,
              commentController: commentController,
              commentFocus: commentFocus,
              oldCommentId: oldCommentId,
            ),
          ],
        ),
      ),
    );
  }
}
