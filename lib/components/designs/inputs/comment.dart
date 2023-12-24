import 'package:flutter/material.dart';
import 'package:sheeta/firebase/comments.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/shared/constants.dart';
import 'package:sheeta/shared/show_toast.dart';

class CommentInput extends StatefulWidget {
  final String postId;
  final UserData? user;
  final TextEditingController commentController;
  final FocusNode commentFocus;
  final TextEditingController oldCommentId;
  const CommentInput({
    super.key,
    required this.postId,
    required this.user,
    required this.commentController,
    required this.commentFocus,
    required this.oldCommentId,
  });

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  @override
  void dispose() {
    super.dispose();
    widget.commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    commentHandler() async {
      // if it a reply
      if (widget.commentController.value.text.contains('@')) {
        if (widget.oldCommentId.text.isNotEmpty) {
          await Comments().create(
            postId: widget.postId,
            grandCommentId: widget.oldCommentId.text,
            commentBody: widget.commentController.text,
            user: widget.user,
          );
        } else {
          showToast('Something went wrong, please try again');
          widget.commentFocus.requestFocus();
          widget.commentController.clear();
        }
      } // if it a comment
      else {
        await Comments().create(
          postId: widget.postId,
          commentBody: widget.commentController.text,
          user: widget.user,
        );
      }

      widget.commentFocus.unfocus();
      widget.commentController.clear();
      
    }

    return TextField(
      keyboardType: TextInputType.text,
      controller: widget.commentController,
      focusNode: widget.commentFocus,
      obscureText: false,
      decoration: decorationTextfield.copyWith(
        hintText: "Comment as  ${widget.user!.username}  ",
        suffixIcon: IconButton(
          onPressed: commentHandler,
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }
}
