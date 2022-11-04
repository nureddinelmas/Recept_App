import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recept_app/main_widgets/recept_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recept_app/utils/utils.dart';

class FirebaseProvider {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final utils = Utils();

  Future<User> handleSignUp(
      String email, String password, String confirmPass) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;
    return user;
  }

  Future<User> handleSignIn(String email, String password, context) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ReceptHomeScreen()));
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        utils.snackbar(context, "No user found for that email");
      } else {
        if (e.code == 'wrong-password') {
          utils.snackbar(context, "Password does not match that Email");
        }
      }
    }
    return null!;
  }

  Future<User> handleForgotPassword(String email, context) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      utils.showAlertDialog(context, email);
    } on FirebaseAuthException catch (e) {
      utils.snackbar(context, "Email does not exist");
    }
    return null!;
  }
}
