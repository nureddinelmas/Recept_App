import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recept_app/utils/firebaseprovider.dart';
import 'package:recept_app/widgets/recipe_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FavoriteRecipes(),
    );
  }
}

class FavoriteRecipes extends StatefulWidget {
  const FavoriteRecipes({super.key});

  @override
  State<FavoriteRecipes> createState() => _FavoriteRecipesState();
}

class _FavoriteRecipesState extends State<FavoriteRecipes> {
  final firebaseProvider = FirebaseProvider();
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List recipeImages = [];
  final List labels = [];
  final List sources = [];
  final List cuisineTypes = [];
  final List webAdresses = [];
  final List mock = [
    "https://png.pngtree.com/png-vector/20190917/ourlarge/pngtree-meal-icon-vectors-png-image_1737729.jpg",
    "https://static.vecteezy.com/system/resources/thumbnails/006/692/762/small/taco-icon-template-black-color-editable-taco-icon-symbol-flat-illustration-for-graphic-and-web-design-free-vector.jpg"
  ];
  String recipeTitle = "";

  late final listenForFavorites = db
      .collection("userFavorites")
      .doc(auth.currentUser?.uid)
      .collection("favorites")
      .snapshots()
      .listen((event) {
    for (var doc in event.docs) {
      final image = doc.data()["image"].toString();
      final label = doc.data()["label"].toString();
      final source = doc.data()["source"].toString();
      final cuisineType = doc.data()["cuisineType"].toString();
      final webAdress = doc.data()["web"].toString();
      setState(() {
        recipeImages.add(image);
        labels.add(label);
        sources.add(source);
        cuisineTypes.add(cuisineType);
        webAdresses.add(webAdress);
      });
    }
  });

  void launchWebsite(webAdress) async {
    final uri = Uri.parse(webAdress);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      print("ERROR");
    }
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightCarousel = height * 0.32;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          recipeTitle,
          style: const TextStyle(fontFamily: "times"),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width,
                height: heightCarousel,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: CarouselSlider.builder(
                    itemCount: recipeImages.isNotEmpty
                        ? recipeImages.length
                        : mock.length,
                    itemBuilder: (context, itemIndex, pageViewIndex) =>
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: GestureDetector(
                              onTap: () {
                                launchWebsite(webAdresses[itemIndex]);
                              },
                              child: recipeImages.isNotEmpty
                                  ? Image.network(recipeImages[itemIndex])
                                  : Image.network(mock[itemIndex]),
                            )),
                    options: CarouselOptions(
                      aspectRatio: height / 400,
                      viewportFraction: 0.5,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: true,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          recipeTitle = labels[index];
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 3)),
          SizedBox(
            width: width * 0.99,
            height: height * 0.50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: SingleChildScrollView(
                child: recipeImages.isEmpty
                    ? Column(children: [
                        Padding(padding: EdgeInsets.only(top: 100.0)),
                        Text(
                          "No Recipes Added Yet",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Times",
                              fontSize: 20.0),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        Container(
                          width: 200,
                          height: 200,
                          child: CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                  "https://b.thumbs.redditmedia.com/p6TgyVO21xdL_a9sWMqnLnpNcJniZ4ZTwoOTq_b8nVY.png"),
                            ),
                          ),
                        ),
                      ])
                    : Column(
                        children: List.generate(
                          recipeImages.length,
                          (index) => RecipeCard(
                            urlImage: recipeImages[index],
                            label: labels[index],
                            source: sources[index],
                            cuisineType: cuisineTypes[index],
                            webAdress: webAdresses[index],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
