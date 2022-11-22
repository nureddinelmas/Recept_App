import 'package:flutter/material.dart';
import 'package:recept_app/models/my_recipes_model.dart';
import 'package:recept_app/screens/my_recipes.dart';

class ShowRecipe extends StatefulWidget {
  final String chosenRecipe;

  const ShowRecipe({Key? key, required this.chosenRecipe}) : super(key: key);

  @override
  _ShowRecipeState createState() => _ShowRecipeState();
}

class _ShowRecipeState extends State<ShowRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chosenrecipe.title'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 470,
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
                        // Expanded(
                        //   child: Image.network(
                        //     '${_myRecipe.image}',
                        //     height: 150,
                        //     width: 150,
                        //   ),
                        //   flex: 2,
                        // ),
                        SizedBox(width: 15),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Här ska titeln stå',
                                // _myRecipe.recipeTitle,
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
                                    'Här ska rubrik ingrediens',
                                    // '${_myRecipe.recipeIngredients}',
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
                                'Description',
                                // 'Description: ${_myRecipe.recipeDescription}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
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
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Back to my recipes',
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepOrange),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
