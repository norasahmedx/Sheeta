import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/models/comment.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/shared/show_toast.dart';
import 'package:uuid/uuid.dart';

class Comments {
  final String table = 'comments';

  Future<void> likeSwitch({
    required String commentId,
    required String type,
  }) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection(table).doc(commentId).update({
        'likes': type == 'add'
            ? FieldValue.arrayUnion([uid])
            : FieldValue.arrayRemove([uid])
      });
    } catch (e) {
      showToast('Something went wrong, please try again later');
      debugPrint(e.toString());
    }
  }

  Future<void> likeComment(String commentId) async {
    // Get the auth user
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Retrieve the comment from Firebase
    Comment? comment = await getCommentById(commentId);

    // Check if the user has already liked the comment
    if (!comment!.likes.contains(uid)) {
      // Add the user's UID to the likes list
      comment.likes.add(uid);

      // Update the comment in Firebase
      await updateComment(commentId, comment);
    }
  }

  Future<void> updateComment(String commentId, Comment updatedComment) async {
    try {
      await FirebaseFirestore.instance
          .collection('comments')
          .doc(commentId)
          .update(updatedComment.convertToMap());
    } catch (e) {
      debugPrint('Error updating comment: $e');
      rethrow; // Throw the error again to notify the caller
    }
  }

  Future<Comment?> getCommentById(String commentId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('comments')
              .doc(commentId)
              .get();

      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data()!;
        return Comment(
          uid: data['uid'],
          postId: data['postId'],
          id: data['commentId'],
          body: data['body'],
          grandComment: data['grandComment'],
          createdTime: data['createdTime'].toDate(),
          likes: List<String>.from(data['likes']),
          replies: List<String>.from(data['replies']),
        );
      } else {
        debugPrint('Comment with ID $commentId does not exist.');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching comment: $e');
      return null;
    }
  }

  Stream<QuerySnapshot<Object?>> getCommentsByPostId(String postId) {
    return FirebaseFirestore.instance
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .where('grandComment', isNull: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> getRepliesByPostId(
      String postId, String grandCommentId) {
    return FirebaseFirestore.instance
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .where('grandComment', isEqualTo: grandCommentId)
        .snapshots();
  }

  Future<void> updateUserInfo(Map<String, dynamic> user) async {
    try {
      // Update the user's avatar in posts where uid is equal to the user's uid
      await FirebaseFirestore.instance
          .collection(table)
          .where('uid', isEqualTo: user['uid'])
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.update(user);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> create({
    required String postId,
    required String commentBody,
    required UserData? user,
    String? grandCommentId,
  }) async {
    try {
      //* Prepare the comment id
      final id = const Uuid().v1();

      //* Prepare the comment's body
      Comment comment = Comment(
        uid: user!.uid,
        postId: postId,
        id: id,
        body: commentBody,
        createdTime: DateTime.now(),
        likes: [],
        replies: [],
        grandComment: grandCommentId,
      );

      //* Publish data to firebase
      await FirebaseFirestore.instance
          .collection(table)
          .doc(id)
          .set(comment.convertToMap())
          .catchError((error) {
        showToast("Failed to add your comment: $error");
      });

      //* Update the grand comment & add this comment id in his replies property
      if (grandCommentId != null) {
        await FirebaseFirestore.instance
            .collection(table)
            .doc(grandCommentId)
            .update({
          'replies': FieldValue.arrayUnion([id]),
        });
      }
      //* Update the post is commentsIds & add this comment id
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'commentsIds': FieldValue.arrayUnion([id]),
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getByPostId(
      {required String postId}) async {
    var snapshot = await FirebaseFirestore.instance
        .collection(table)
        .where('postId', isEqualTo: postId)
        .get();

    return snapshot.docs;
  }

  Future<List<Comment>> getCommentReplies(String commentId) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(table)
          .doc(commentId)
          .collection('replies')
          .get();

      List<Comment> commentReplies =
          snapshot.docs.map((doc) => Comment.fromMap(doc.data())).toList();

      return commentReplies;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
