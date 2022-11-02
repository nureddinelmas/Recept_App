import 'package:flutter/material.dart';
import 'package:recept_app/main%20widgets/recept_home.dart';
import 'package:recept_app/models/recept_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecipesModel(),
    );
  }
}
