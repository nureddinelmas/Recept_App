import 'package:flutter/material.dart';
import 'package:recept_app/models/my_recipes_model.dart';

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
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    _myRecipe.recipeTitle,
                    style: TextStyle(
                        color: Colors.white,
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
                      Container(
                          height: 120,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 188, 245, 190),
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
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
                            child: Text(
                              '${_myRecipe.recipeIngredients}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Container(
                                height: 130,
                                width: width * 0.8,
                                child: Text(
                                  '${_myRecipe.recipeDescription}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
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
