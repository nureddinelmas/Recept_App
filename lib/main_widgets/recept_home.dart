import 'package:flutter/material.dart';
import 'package:recept_app/main_widgets/profile_screen.dart';

import 'package:recept_app/models/main_model.dart';
import 'package:recept_app/main_widgets/main_home.dart';
import 'package:recept_app/screens/add_recipe_screen.dart';
import 'package:recept_app/screens/favorite_screen.dart';
import 'package:recept_app/screens/my_recipes.dart';
import 'package:recept_app/screens/favorite_screen.dart';
import "dart:io";
import "package:flutter/cupertino.dart";

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
    ProfileScreen(),
    MyRecipes()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: Platform.isAndroid
          ? BottomNavigationBar(
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: "MyRecipes")
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            )
          : CupertinoTabBar(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              currentIndex: selectedIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.heart),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.add_circled),
                  label: 'New Recipe',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book),
                  label: 'MyRecipes',
                ),
              ],
              onTap: ((index) {
                setState(() {
                  selectedIndex = index;
                });
              }),
            ),
    );
  }
}
