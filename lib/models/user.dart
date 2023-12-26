import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String username;
  String bio;
  String email;
  String avatar;
  String avatarName;
  String uid;

  UserData({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.avatar,
    required this.avatarName,
  });

  Map<String, dynamic> convertToMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'bio': bio,
      'avatar': avatar,
      'avatarName': avatarName,
    };
  }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User
  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserData(
      uid: snapshot['uid'],
      email: snapshot['email'],
      username: snapshot['username'],
      bio: snapshot['bio'],
      avatar: snapshot['avatar'],
      avatarName: snapshot['avatarName'],
    );
  }

  // Factory method to create UserData instance from DocumentSnapshot
  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UserData(
      uid: data['uid'],
      email: data['email'],
      username: data['username'],
      bio: data['bio'],
      avatar: data['avatar'],
      avatarName: data['avatarName'],
    );
  }
}
