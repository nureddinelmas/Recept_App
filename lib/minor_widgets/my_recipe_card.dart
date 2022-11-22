import 'package:flutter/material.dart';
import 'package:recept_app/models/my_recipes_model.dart';
import 'package:flutter/cupertino.dart';

class MyRecipeCard extends StatelessWidget {
  final MyRecipesModel _myRecipe;

  MyRecipeCard(this._myRecipe);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 162, 207, 219),
                  Color.fromARGB(255, 221, 227, 233)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 166, 193, 243),
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
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    _myRecipe.recipeTitle,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 35),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          '${_myRecipe.image}',
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 10, width: 30),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 209, 198, 191),
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 130, 93, 92),
                                offset: Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                              ),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0)
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Ingredients',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  '${_myRecipe.recipeIngredients}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: Text(
                      '${_myRecipe.recipeDescription}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
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
