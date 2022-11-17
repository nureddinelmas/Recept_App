import 'package:flutter/material.dart';
import 'package:recept_app/models/my_recipes_model.dart';

class MyRecipeCard extends StatelessWidget {
  final MyRecipesModel _myRecipe;

  MyRecipeCard(this._myRecipe);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(_myRecipe.recipeTitle),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Ingredients: ${_myRecipe.recipeIngredients}')
                  ],
                ),
                Row(
                  children: [
                    Text('Description: ${_myRecipe.recipeDescription}')
                  ],
                )
              ],
            )),
      ),
    );
  }
}
