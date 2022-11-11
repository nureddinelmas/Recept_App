import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recept_app/widgets/recipe_card.dart';

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
  final image =
      "https://png.pngtree.com/png-vector/20190917/ourlarge/pngtree-meal-icon-vectors-png-image_1737729.jpg";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightCarousel = height * 0.32;

    return Scaffold(
      body: Column(
        children: [
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
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(image),
                    ),
                    options: CarouselOptions(
                      aspectRatio: height / 400,
                      viewportFraction: 0.5,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: true,
                      enlargeCenterPage: true,
                      // onPageChanged: (callbackFunction),
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
                    10,
                    (index) => const RecipeCard(),
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
