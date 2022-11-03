import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recept_app/main_widgets/recept_home.dart';
import 'package:recept_app/utils/client.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProvider {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var client = Client();

  Future<User> handleSignUp(email, password, confirmPass) async {
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
        print("No user found for that email");
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
}
