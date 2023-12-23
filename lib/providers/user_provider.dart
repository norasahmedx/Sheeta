import 'package:flutter/material.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/models/user.dart';

class UserProvider with ChangeNotifier {
  UserData? _userData;
  UserData? get getUser => _userData;

  refreshUser() async {
    UserData userData = await Auth().get();
    _userData = userData;
    notifyListeners();
  }
}
