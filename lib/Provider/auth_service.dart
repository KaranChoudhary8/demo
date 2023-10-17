import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:expense/Settings/user_model.dart';
import 'package:flutter/foundation.dart';


class AuthService extends ChangeNotifier{
  final auth.FirebaseAuth _firebasAuth = auth.FirebaseAuth.instance;

  MyUser? _firebaseUser(auth.User? user){
    if (user == null){
      return null;
    }
    return MyUser(user.uid, user.phoneNumber);

  }

  Stream<MyUser?>? get user{
    return _firebasAuth.authStateChanges().map(_firebaseUser);
  }


}