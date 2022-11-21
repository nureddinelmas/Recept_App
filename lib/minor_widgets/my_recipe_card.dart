import 'package:flutter/material.dart';
import 'package:recept_app/models/my_recipes_model.dart';

class MyRecipeCard extends StatelessWidget {
  final MyRecipesModel _myRecipe;

  MyRecipeCard(this._myRecipe);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                    colors: [Colors.pink, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: CustomPaint(
                size: Size(100, 150),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15),
                  Expanded(
                    child: Image.network(
                      '${_myRecipe.image}',
                      height: 150,
                      width: 150,
                    ),
                    flex: 2,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _myRecipe.recipeTitle,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Ingredients',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: 80,
                            child: Text(
                              '${_myRecipe.recipeIngredients}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Description: ${_myRecipe.recipeDescription}',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
