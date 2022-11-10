import 'package:flutter/material.dart';
import 'package:recept_app/colors.dart';

class MyRecipes extends StatefulWidget {
  const MyRecipes({Key? key}) : super(key: key);

  @override
  State<MyRecipes> createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mrBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(33),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              height: 213,
              color: Colors.amber,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              'My recipes!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFf6925c),
                      Color(0xFFf37552),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}