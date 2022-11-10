import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recept_app/main_widgets/recept_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recept_app/utils/utils.dart';
import 'package:recept_app/utils/client.dart';

class FirebaseProvider {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final utils = Utils();
  final client = Client();
  final String? foodSearch = "popular";
  late final api =
      "https://api.edamam.com/api/recipes/v2?type=public&q=$foodSearch&app_id=0cceac24&app_key=53899a67af0e3367cf30b5d85f5de4ac";

  Future<User> handleSignUp(
      String email, String password, String confirmPass) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;
    client.clientID = user.uid;
    connectClientWithApi(client);
    return user;
  }

  Future<User> handleSignIn(String email, String password, context) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ReceptHomeScreen()));
      //getUserFavorites();
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

  void connectClientWithApi(Client client) async {
    client.clientID = auth.currentUser?.uid as String;
    final mapOfClient = <String, dynamic>{
      "clientmail": auth.currentUser?.email,
      "clientID": client.clientID,
      "clientApi": api,
    };
    await db.collection("users").doc(client.clientID).set(mapOfClient);
  }

  String getClientApi(String collection) {
    auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await db.collection(collection).doc(user.uid).get().then((document) {
          if (document.exists) {
            client.clientApiKey = document.get("clientApi");
          }
        });
      }
    });
    return client.clientApiKey;
  }

  void addToFavorite(dynamic imageUrl, dynamic webAdress) {
    if (auth.currentUser?.uid != null) {
      final mapOfFavorites = <String, dynamic>{
        "image": imageUrl,
        "web": webAdress
      };
      db
          .collection("userFavorites")
          .doc(auth.currentUser?.uid)
          .collection("favorites")
          .doc()
          .set(mapOfFavorites);
    }
  }

   getUserFavorites() async {
    final userFavorites = [];
    auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await db
            .collection("userFavorites")
            .doc(user.uid)
            .collection("favorites")
            .get()
            .then((document) {
          if (document.docs.isNotEmpty) {
            userFavorites.add(document.docs);
            print(userFavorites);
          }
        });
      }
    });
   
  }
}

  // List listenForFavorites() {
  //   final favorite = [];
  //   db
  //       .collection("userFavorites")
  //       .doc(auth.currentUser?.uid)
  //       .collection("favorites")
  //       .snapshots()
  //       .listen((event) {
  //     for (var doc in event.docs) {
  //       favorite.clear();
  //       var image = doc.data()["image"].toString();
  //       image = image.replaceAll("[", "").replaceAll("]", "");
  //       favorite.add(image);
  //       print(favorite);
  //     }
  //   });
  //   return favorite;
  // }

}
