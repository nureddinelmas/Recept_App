import 'package:flutter/material.dart';

class Recipe {
  Recipe(
      {this.recipeName = '',
      this.recipeImage = '',
      this.recipeDescription = ''});

  String recipeName;
  String recipeImage;
  String recipeDescription;
}

var recipes = [
  Recipe(
      recipeName: "Godaste fisken",
      recipeImage: 'CostaBlanca.jpg',
      recipeDescription:
          'Häll i fisken och massa vatten, låt koka i 200 minuter'),
  Recipe(
      recipeName: "Godaste grytan",
      recipeImage: 'Snake1.jpeg',
      recipeDescription:
          'Häll i alla ingredienser, rör runt ordentligt och krydda sen. Ät med ris'),
  Recipe(
      recipeName: 'Godaste riset',
      recipeImage: 'Snake2.jpeg',
      recipeDescription:
          'Stek riset, krydda med kryddor och koka sedan under lock'),
  Recipe(
      recipeName: 'Godaste tacos',
      recipeImage: 'SnakeTurquose.jpg',
      recipeDescription:
          'Stek kött, lök och vitlök. Gör salsa verde och salsa roja och ha vid sidan av tillsammans med majstortillas'),
  Recipe(
      recipeName: 'Godaste bönorna',
      recipeImage: 'CostaBlanca.jpg',
      recipeDescription:
          'Stek tillsammans med lök och lite vitlök. Mixa sedan med koriander, chili, paprika och ha i lite vatten'),
];
