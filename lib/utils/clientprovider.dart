import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recept_app/utils/client.dart';

class ClientProvider {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final client = Client();

  void clientProvider() {
    if (auth.currentUser != null) {
      print(auth.currentUser?.uid);
    }
  }
}
