import 'package:flutter/material.dart';
import 'package:recept_app/models/recipeModel.dart';
import 'package:recept_app/models/recipes.dart';
import 'package:recept_app/widgets/my_recipe_card.dart';

class PageViewMyRecipes extends StatefulWidget {
  const PageViewMyRecipes({super.key});

  @override
  State<PageViewMyRecipes> createState() => _PageViewMyRecipesState();
}

class _PageViewMyRecipesState extends State<PageViewMyRecipes> {
  final PageController pageController = PageController(viewportFraction: 0.75);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 410,
      child: PageView.builder(
        padEnds: false,
        controller: PageController(),
        itemCount: recipes.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          bool active = index == currentPage;
          return MyRecipeCard(
            active: active,
            index: index,
            recipe: recipes[index],
          );
        },
      ),
    );
  }
}
