import 'package:flutter/material.dart';

class MyRecipesModel {
  MyRecipesModel({
    required this.recipeTitle,
    required this.recipeIngredients,
    required this.recipeDescription,
    required this.image,
  });
  String recipeTitle;
  String? recipeIngredients;
  String? recipeDescription;
  String? image;

  Map<String, dynamic> toJson() => {
        'recipeTitle': recipeTitle,
        'recipeIngredients': recipeIngredients,
        'recipeDescription': recipeDescription,
        'image': image,
      };

  MyRecipesModel.fromSnapshot(snapshot)
      : recipeTitle = snapshot.data()['recipeTitle'],
        recipeIngredients = snapshot.data()['recipeIngredients'],
        recipeDescription = snapshot.data()['recipeDescription'],
        image = snapshot.data()['image'];
}
