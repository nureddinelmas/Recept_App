import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recept_app/main_widgets/recept_home.dart';
import 'package:recept_app/utils/client.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProvider {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var client = Client();

  Future<User> handleSignUp(
      String email, String password, String confirmPass) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;
    return user;
  }

  Future<User> handleSignIn(String email, String password, context) async {
    final scaffold = ScaffoldMessenger.of(context);
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ReceptHomeScreen()));
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        scaffold.showSnackBar(
          SnackBar(
            content: const Text("No user found for that email"),
            action: SnackBarAction(
              label: "Undo",
              onPressed: scaffold.hideCurrentSnackBar,
            ),
          ),
        );
      } else {
        if (e.code == 'wrong-password') {
          scaffold.showSnackBar(
            SnackBar(
              content: const Text("Password does not match that Email"),
              action: SnackBarAction(
                label: "Undo",
                onPressed: scaffold.hideCurrentSnackBar,
              ),
            ),
          );
        }
      }
    }
    return null!;
  }

  Future<User> handleForgotPassword(String email, context) async {
    final scaffold = ScaffoldMessenger.of(context);
    try {
      await auth.sendPasswordResetEmail(email: email);
      showAlertDialog(context, email);
    } on FirebaseAuthException catch (e) {
      scaffold.showSnackBar(
        SnackBar(
          content: const Text("Email does not exist"),
          action: SnackBarAction(
            label: "Undo",
            onPressed: scaffold.hideCurrentSnackBar,
          ),
        ),
      );
    }
    return null!;
  }
}

void showAlertDialog(context, email) {
  AlertDialog alert = AlertDialog(
    content: Text(
      "An reset email is sent to $email",
      style: const TextStyle(fontFamily: "Times"),
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
