import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
