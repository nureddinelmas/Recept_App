import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List recipeImages = [];

  late final listenForFavorites = db
      .collection("userFavorites")
      .doc(auth.currentUser?.uid)
      .collection("favorites")
      .snapshots()
      .listen((event) {
    var tmpList = [];
    for (var doc in event.docs) {
      tmpList.add(doc.data()["image"].toString());
    }
    setState(() {
      recipeImages.clear();
      recipeImages.addAll(tmpList);
    });
  });

  Widget? getImages(List<dynamic> images) {
    for (var i = 0; i < recipeImages.length; i++) {
      recipeImages.add(Image.network(recipeImages[i]));

      return Image.network(recipeImages[i]);
    }
    return null;
  }

  @override
  initState() {
    super.initState();
    listenForFavorites;
  }

  @override
  void dispose() {
    listenForFavorites.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 5.0)),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
            ),
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
              child: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: getImages(recipeImages), //!
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 60.0),
                    ),
                    Text(
                      "recipe name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                    ),
                    Text(
                      "@Type of dish",
                      style: TextStyle(fontSize: 10.0, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                            ),
                            Text("'Short comment of the recipe'"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.receipt,
                  color: Colors.white,
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.deepOrange,
                ),
                Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
        const Divider(
          color: Colors.white,
          thickness: 1,
          endIndent: 8,
          indent: 8,
        )
      ],
    );
  }
}
