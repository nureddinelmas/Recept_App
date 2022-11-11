import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recept_app/utils/firebaseprovider.dart';
import 'package:recept_app/widgets/recipe_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseProvider = FirebaseProvider();

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
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List recipeImages = [];

  late final listenForFavorites = db
      .collection("userFavorites")
      .doc(auth.currentUser?.uid)
      .collection("favorites")
      .snapshots()
      .listen((event) {
    for (var doc in event.docs) {
      final image = doc.data()["image"].toString();
      setState(() {
        recipeImages.add(image);
      });
    }
  });

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
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 50),
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
                  itemCount: recipeImages.length,
                  itemBuilder: (context, itemIndex, pageViewIndex) => ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(recipeImages[itemIndex])),
                  options: CarouselOptions(
                    aspectRatio: height / 400,
                    viewportFraction: 0.5,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: true,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
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
              child: Column(
                children: List.generate(
                  recipeImages.length,
                  (index) => const RecipeCard(),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
