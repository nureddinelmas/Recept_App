import 'package:flutter/material.dart';
import 'package:recept_app/utils/firebaseprovider.dart';
// import 'package:recept_app/models/recipes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/';
import 'package:timetable/file_upload_firebase.dart';

class AddRecipe extends StatelessWidget {
  const AddRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    String recipeTitle = '';
    String recipeIngredients = '';
    String recipeDescription = '';

    var _controller = TextEditingController();

    CollectionReference MyRecipes =
        FirebaseFirestore.instance.collection('MyRecipes');

    Future addRecipe() async {
      await MyRecipes.add({
        'recipeTitle': recipeTitle,
        'recipeIngredients': recipeIngredients,
        'recipeDescription': recipeDescription,
      })
          .then((value) => print('New recipe added!'))
          .catchError((error) => print('Failed to add recipe : $error'));
    }

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          'Add recipe',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  color: Colors.amber,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _controller,
                          showCursor: true,
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            recipeTitle = value;
                            print(recipeTitle);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.abc,
                              color: Colors.amberAccent,
                            ),
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          showCursor: true,
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            recipeIngredients = value;
                            print(recipeIngredients);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.apple_rounded,
                              color: Colors.amberAccent,
                            ),
                            hintText: 'Ingredients',
                            hintStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          showCursor: true,
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            recipeDescription = value;
                            print(recipeDescription);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.book,
                              color: Colors.amberAccent,
                            ),
                            hintText: 'Description',
                            hintStyle: TextStyle(color: Colors.amberAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          addRecipe();
                          _controller.clear();
                        },
                        icon: const Icon(Icons.book_online),
                        style: ElevatedButton.styleFrom(
                          elevation: 20,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          textStyle: const TextStyle(
                              fontSize: 20.0, fontFamily: "Times"),
                        ),
                        label: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
