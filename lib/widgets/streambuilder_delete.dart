import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recept_app/utils/client.dart';

import 'package:recept_app/utils/firebaseprovider.dart';
import 'package:recept_app/utils/utils.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final firebaseProvider = FirebaseProvider();
final client = Client();
final utils = Utils();

class StreamBuilderDelete extends StatefulWidget {
  bool isFavorite = client.isFavorite;
  dynamic label;
  StreamBuilderDelete({
    super.key,
    required this.isFavorite,
    required this.label,
  });

  @override
  _StreamBuilderDeleteState createState() => _StreamBuilderDeleteState();
}

class _StreamBuilderDeleteState extends State<StreamBuilderDelete> {
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
          return IconButton(
              onPressed: () {
                firebaseProvider.deleteFavorite(widget.label);
                utils.snackbar(context, "Deleted Recipe");
              },
              icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red));
        }
      },
    );
  }
}
