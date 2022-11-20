import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:recept_app/minor_widgets/my_recipe_card.dart';
import 'package:recept_app/models/my_recipes_model.dart';
import 'package:recept_app/models/recipeModel.dart';
import 'package:recept_app/utils/firebaseprovider.dart';

class MyRecipes extends StatefulWidget {
  const MyRecipes({super.key});

  @override
  State<MyRecipes> createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('MyRecipes');
  final auth = FirebaseAuth.instance;

  late User loggedInUser;

  List<Object> _recipeList = [];

  @override
  initState() {
    super.initState();
    getRecipesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipes'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _recipeList.length,
          itemBuilder: (context, index) {
            return MyRecipeCard(_recipeList[index] as MyRecipesModel);
          },
        ),
      ),
    );
  }

  Future getRecipesList() async {
    final uid = auth.currentUser?.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('MyRecipes')
        .get();

    setState(() {
      _recipeList =
          List.from(data.docs.map((doc) => MyRecipesModel.fromSnapshot(doc)));
      print('$_recipeList');
    });
  }
}

  



// class MessageBubble extends StatelessWidget {
//   MessageBubble({required this.recipeTitle, required this.recipeIngredients});

//   final String recipeTitle;
//   final String recipeIngredients;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 '$recipeTitle',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontSize: 30.0, color: Colors.black),
//               ),
//             ],
//           ),
//           Material(
//             elevation: 5.0,
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30.0),
//                 bottomRight: Radius.circular(30.0),
//                 bottomLeft: Radius.circular(30)),
//             color: Colors.lightBlueAccent,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('$recipeTitle',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           color: Colors.black,
//                         )),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('$recipeIngredients',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           color: Colors.black,
//                         )),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

  // appBar: AppBar(
  //       backgroundColor: Color.fromARGB(255, 163, 246, 216),
  //       title: Text(
  //         'My recipes',
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontSize: 30,
  //           fontWeight: FontWeight.w600,
  //           fontFamily: "Times",
  //         ),
  //       ),
  //     ),
  //     body: Column(
  //       children: [
  //         StreamBuilder<QuerySnapshot>(
  //           stream: getRecipesFromFirestore(),
  //           builder: (context, snapshot) {
  //             List<MessageBubble> recipeWidgets = [];
  //             if (!snapshot.hasData) {
  //               return Center(
  //                 child: CircularProgressIndicator(
  //                   backgroundColor: Colors.lightBlueAccent,
  //                 ),
  //               );
  //             }
  //             final recipeLists = snapshot.data!.docs;

  //             for (var recipeList in recipeLists) {
  //               final recipeTitle =
  //                   (recipeList.data() as dynamic)['recipeTitle'];
  //               final recipeIngredients =
  //                   (recipeList.data() as dynamic)['recipeIngredients'];
  //               final loggedIn = (recipeList.data() as dynamic)['sender'];

  //               final currentUser = loggedInUser.email;
  //               print('Current User: $currentUser');
  //               print('logged user: $loggedIn');

  //               final messageWidget = MessageBubble(
  //                 recipeTitle: 'Hej jag heter Sanna',
  //                 recipeIngredients: 'Tre äpplen bland annat!',
  //               );

  //               recipeWidgets.add(messageWidget);
  //             }

  //             return Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: ListView(children: recipeWidgets),
  //               ),
  //             );
  //           },
  //         )
  //       ],
  //     ),

