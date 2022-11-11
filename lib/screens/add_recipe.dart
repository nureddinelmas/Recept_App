import 'package:flutter/material.dart';
import 'package:recept_app/colors.dart';

class AddRecipe extends StatelessWidget {
  const AddRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mrBackgroundColor,
        title: Text(
          'Add recipe',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
              child: TextField(
            expands: true,
            maxLines: null,
          ));
        },
      ),
    );
  }
}
