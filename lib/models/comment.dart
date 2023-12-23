import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String uid;
  String postId;
  String body;
  DateTime createdTime;
  List<String> likes;
  List<String> replies;
  String? grandComment;

  Comment({
    required this.id,
    required this.uid,
    required this.postId,
    required this.body,
    required this.createdTime,
    required this.likes,
    required this.replies,
    required this.grandComment,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      uid: map['uid'],
      postId: map['postId'],
      body: map['body'],
      grandComment: map['grandComment'],
      createdTime: (map['createdTime'] as Timestamp).toDate(),
      likes: List.from(map['likes']),
      replies: List.from(map['replies']),
    );
  }

  Map<String, dynamic> convertToMap() {
    return {
      'id': id,
      'uid': uid,
      'postId': postId,
      'body': body,
      'grandComment': grandComment,
      'createdTime': createdTime,
      'likes': likes,
      'replies': replies,
    };
  }
}
