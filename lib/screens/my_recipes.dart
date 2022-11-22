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
        title: Text(
          'My Recipes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            fontFamily: "Times",
          ),
        ),
        backgroundColor: Color.fromARGB(255, 216, 224, 230),
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
