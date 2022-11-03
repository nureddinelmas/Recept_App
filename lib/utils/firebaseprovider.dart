import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recept_app/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProvider {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var user = NewUser();

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;
    return user;
  }

  Future<User> handleSignIn(String email, String password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;
    return user;
  }
}
