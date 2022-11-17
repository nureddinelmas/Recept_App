import 'package:flutter/material.dart';
import 'package:recept_app/models/recipes.dart';

class MyRecipeCard extends StatelessWidget {
  final int index;
  MyRecipeCard(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(recipes[index].recipeImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          recipes[index].recipeName,
          style: TextStyle(
            fontSize: 30,
            color: Colors.amber,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          recipes[index].recipeDescription,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
