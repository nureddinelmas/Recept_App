import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRecipes extends StatefulWidget {
  const MyRecipes({super.key});

  @override
  State<MyRecipes> createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 163, 246, 216),
        title: Text(
          'My recipes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            fontFamily: "Times",
          ),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _fireStore
                .collection('MyRecipes')
                .orderBy('created', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              List<MessageBubble> recipeWidgets = [];
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final recipeLists = snapshot.data!.docs;

              for (var recipeList in recipeLists) {
                final recipeTitle =
                    (recipeList.data() as dynamic)['recipeTitle'];
                final recipeIngredients =
                    (recipeList.data() as dynamic)['recipeIngredients'];
                final loggedIn = (recipeList.data() as dynamic)['sender'];

                final currentUser = loggedInUser.email;
                print('Current User: $currentUser');
                print('logged user: $loggedIn');

                final messageWidget = MessageBubble(
                  recipeTitle: 'Hej jag heter Sanna',
                  recipeIngredients: 'Tre äpplen bland annat!',
                );

                recipeWidgets.add(messageWidget);
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(children: recipeWidgets),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.recipeTitle, required this.recipeIngredients});

  final String recipeTitle;
  final String recipeIngredients;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$recipeTitle',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ),
            ],
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30)),
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$recipeTitle',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$recipeIngredients',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
