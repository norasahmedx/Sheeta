import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String uid;
  String id;
  String description;
  String post;
  DateTime createdTime;
  List likes;
  List commentsIds;

  Post({
    required this.uid,
    required this.id,
    required this.description,
    required this.post,
    required this.createdTime,
    required this.likes,
    required this.commentsIds,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      uid: map['uid'],
      id: map['id'],
      description: map['description'],
      post: map['post'],
      createdTime: (map['createdTime'] as Timestamp).toDate(),
      likes: List.from(map['likes']),
      commentsIds: map['commentsIds'],
    );
  }

  Map<String, dynamic> convertToMap() {
    return {
      'uid': uid,
      'id': id,
      'description': description,
      'post': post,
      'createdTime': createdTime,
      'likes': likes,
      'commentsIds': commentsIds,
    };
  }
}
