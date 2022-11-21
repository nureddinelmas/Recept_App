import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recept_app/utils/client.dart';

import 'package:recept_app/utils/firebaseprovider.dart';
import 'package:uuid/uuid.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final firebaseProvider = FirebaseProvider();
final client = Client();

class StreamBuilderToggle extends StatefulWidget {
  bool isFavorite = client.isFavorite;
  dynamic imageUrl;
  dynamic webAdress;
  dynamic label;
  dynamic source;
  dynamic cuisineType;
  StreamBuilderToggle({
    super.key,
    required this.isFavorite,
    required this.imageUrl,
    required this.webAdress,
    required this.label,
    required this.source,
    required this.cuisineType,
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
            if (doc.id == widget.label && widget.isFavorite == false) {
              widget.isFavorite = !widget.isFavorite;
            }
          }
          return IconButton(
              onPressed: () {
                if (widget.isFavorite == false) {
                  firebaseProvider.addToFavorite(
                    widget.imageUrl,
                    widget.webAdress,
                    widget.label,
                    widget.source,
                    widget.cuisineType,
                  );
                } else {
                  firebaseProvider.deleteFavorite(widget.label);
                }
                widget.isFavorite = false;
              },
              icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red));
        }
      },
    );
  }
}
