import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recept_app/utils/firebaseprovider.dart';
import 'package:recept_app/widgets/streambuilder_delete.dart';
import "dart:io";
import "package:flutter/cupertino.dart";
import 'package:url_launcher/url_launcher.dart';

class RecipeCard extends StatefulWidget {
  final String urlImage;
  final String label;
  final String source;
  final String cuisineType;
  final String webAdress;

  const RecipeCard(
      {super.key,
      required this.webAdress,
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
  final firebaseProvider = FirebaseProvider();

  String modifyLabel(String label) {
    final string = label.substring(0, label.characters.length);

    if (string.length >= 20) {
      final newString = string.replaceAll(
          string,
          string[0] +
              string[1] +
              string[2] +
              string[3] +
              string[4] +
              string[5] +
              string[6] +
              string[7] +
              string[8] +
              string[9] +
              "...");
      return newString;
    }
    return string;
  }

  void launchWebsite(webAdress) async {
    final uri = Uri.parse(webAdress);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      print("ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double paddingLabel = width * 0.2;

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
                  child: GestureDetector(
                    onTap: () {
                      launchWebsite(widget.webAdress);
                    },
                    child: Image.network(widget.urlImage),
                  ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Platform.isAndroid
                    ? Icon(
                        Icons.receipt,
                        color: Colors.white,
                      )
                    : Icon(
                        CupertinoIcons.rectangle_stack_fill_badge_person_crop,
                        color: CupertinoColors.white,
                      ),
                StreamBuilderDelete(
                  isFavorite: true,
                  label: widget.label,
                ),
                Platform.isAndroid
                    ? Icon(
                        Icons.comment,
                        color: Colors.white,
                      )
                    : Icon(
                        CupertinoIcons.text_bubble,
                        color: CupertinoColors.white,
                      )
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
