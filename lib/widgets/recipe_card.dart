import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String urlImage;
  final String label;
  final String source;
  final String cuisineType;

  const RecipeCard(
      {super.key,
      required this.urlImage,
      required this.label,
      required this.source,
      required this.cuisineType});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String modifyLabel(String label) {
    final string = label.substring(0, 20);
    if (string.length >= 20) {
      final newString = string.replaceAll(string, "$string ...");
      return newString;
    }
    return string;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double paddingLabel = width * 0.1;

    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 7.0)),
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
                  //!
                  child: Image.network(widget.urlImage),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: paddingLabel),
                    ),
                    Text(
                      modifyLabel(widget.label),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                    ),
                    Text(
                      "@${widget.source}",
                      style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                          fontFamily: "times"),
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
                          children: [
                            const Text(
                              "CusineType: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              widget.cuisineType,
                              style: const TextStyle(fontFamily: "times"),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 40.0),
                            ),
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
