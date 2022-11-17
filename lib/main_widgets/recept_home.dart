import 'package:flutter/material.dart';
import 'package:recept_app/main_widgets/profile_screen.dart';

import 'package:recept_app/models/main_model.dart';
import 'package:recept_app/main_widgets/main_home.dart';
import 'package:recept_app/screens/add_recipe_screen.dart';
import 'package:recept_app/screens/favorite_screen.dart';
import 'package:recept_app/screens/my_recipes.dart';

class ReceptHomeScreen extends StatefulWidget {
  const ReceptHomeScreen({Key? key}) : super(key: key);

  @override
  State<ReceptHomeScreen> createState() => _ReceptHomeScreenState();
}

class _ReceptHomeScreenState extends State<ReceptHomeScreen> {
  int selectedIndex = 0;

  final List<Widget> tabs = const [
    MainHome(),
    FavoriteScreen(),
    AddRecipe(),
    MyRecipes(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        selectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded), label: "New Recipe"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "MyRecipes")
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
