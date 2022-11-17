import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recept_app/models/recipeModel.dart';
import 'package:recept_app/utils/firebaseprovider.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final firebaseProvider = FirebaseProvider();

class StreamBuilderToggle extends StatefulWidget {
  bool isFavorite = client.isFavorite;
  dynamic imageUrl;
  dynamic webAdress;
  dynamic label;
  dynamic source;
  dynamic cuisineType;
  dynamic modell;
  StreamBuilderToggle({
    super.key,
    required this.isFavorite,
    required this.imageUrl,
    required this.webAdress,
    required this.label,
    required this.source,
    required this.cuisineType,
    required this.modell,
  });

  @override
  _StreamBuilderToggleState createState() => _StreamBuilderToggleState();
}

class _StreamBuilderToggleState extends State<StreamBuilderToggle> {
  final Stream<QuerySnapshot> toggleHeart = FirebaseFirestore.instance
      .collection('userFavorites')
      .doc(auth.currentUser?.uid)
      .collection("favorites")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: toggleHeart,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text(
            'No Data...',
          );
        } else {
          for (var doc in snapshot.data!.docs) {
            if (doc.id == widget.modell["label"]) {
              widget.isFavorite = !widget.isFavorite;
            }
          }
          return IconButton(
              onPressed: () {
                // firebaseProvider.addToFavorite(
                //     widget.imageUrl,
                //     widget.webAdress,
                //     widget.label,
                //     widget.source,
                //     widget.source);
                firebaseProvider.toggleFavorite(widget.label);
              },
              icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red));
        }
      },
    );
  }
}
// return new ListView.builder(
//             itemCount: snapshot.data.documents.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot ds = snapshot.data.documents[index];
//               return new Lost_Card(
//                 headImageAssetPath : ds["url"];

// );