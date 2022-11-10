import 'package:flutter/material.dart';

class Recipe {
  Recipe(
      {this.recipeName = '',
      this.recipeImage = '',
      this.startColor,
      this.endColor});

  String recipeName;
  String recipeImage;
  Color? startColor;
  Color? endColor;
}

var recipes = [
  Recipe(
    recipeName: "Godaste fisken",
    recipeImage: 'CostaBlanca.jpg',
    startColor: const Color(0xFFF37552),
    endColor: const Color(0xFFF58B5A),
  ),
  Recipe(
    recipeName: "Godaste grytan",
    recipeImage: 'Snake1.jpeg',
    startColor: const Color(0xFF621e14),
    endColor: const Color(0xFFd13b10),
  ),
  Recipe(
    recipeName: 'Godaste riset',
    recipeImage: 'Snake2.jpeg',
    startColor: const Color(0xFFe18b41),
    endColor: const Color(0xFFc7c73d),
  ),
  Recipe(
    recipeName: 'Godaste tacos',
    recipeImage: 'SnakeTurquose.jpg',
    startColor: const Color(0xFFF37552),
    endColor: const Color(0xFFF58B5A),
  ),
  Recipe(
    recipeName: 'Godaste bönorna',
    recipeImage: 'CostaBlanca.jpg',
    startColor: const Color(0xFFF37552),
    endColor: const Color(0xFFF58B5A),
  ),
];
