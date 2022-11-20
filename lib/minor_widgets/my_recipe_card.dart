import 'package:flutter/material.dart';
import 'package:recept_app/models/my_recipes_model.dart';

class MyRecipeCard extends StatelessWidget {
  final MyRecipesModel _myRecipe;

  MyRecipeCard(this._myRecipe);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                    colors: [Colors.pink, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: CustomPaint(
                size: Size(100, 150),
              ),
            ),
            Row(
              children: <Widget>[
                Image.network(
                  '${_myRecipe.image}',
                  height: 64,
                  width: 64,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _myRecipe.recipeTitle,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Ingredients: ${_myRecipe.recipeIngredients}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Description: ${_myRecipe.recipeDescription}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


//  @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Card(
//         child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Stack(
//               children: [
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 10.0),
//                       child: Text(_myRecipe.recipeTitle),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('Ingredients: ${_myRecipe.recipeIngredients}')
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('Description: ${_myRecipe.recipeDescription}'),
//                     Container(
//                     child: Image.network('${_myRecipe.image}'),
//                     ),
//                     //   Image.network(
//                     //   'https://picsum.photos/id/1074/400/400',
//                     // ),
//                   ],
//                 )
//               ],
//             )),
//       ),
//     );
//   }