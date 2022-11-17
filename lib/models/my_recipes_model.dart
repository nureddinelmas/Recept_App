import 'package:flutter/material.dart';

class MyRecipesModel {
  MyRecipesModel({
    required this.recipeTitle,
    required this.recipeIngredients,
    required this.recipeDescription,
    required this.created,
  });
  String recipeTitle;
  String? recipeIngredients;
  String? recipeDescription;
  DateTime? created;

  Map<String, dynamic> toJson() => {
        'recipeTitle': recipeTitle,
        'recipeIngredients': recipeIngredients,
        'recipeDescription': recipeDescription,
        'created': created
      };

  MyRecipesModel.fromSnapshot(snapshot)
      : recipeTitle = snapshot.data()['recipeTitle'],
        recipeIngredients = snapshot.data()['recipeIngredients'],
        recipeDescription = snapshot.data()['recipeDescription'];
  // created = snapshot.data()['create'].toDate();
}
