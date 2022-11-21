import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recept_app/models/my_recipes_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  MyRecipesModel _myRecipes = MyRecipesModel(
      image: '', recipeDescription: '', recipeIngredients: '', recipeTitle: '');

  late TextEditingController recipeTitleTextController;
  late TextEditingController recipeIngredientsTextController;
  late TextEditingController recipeDescriptionTextController;

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    recipeTitleTextController = TextEditingController();
    recipeIngredientsTextController = TextEditingController();
    recipeDescriptionTextController = TextEditingController();
  }

  @override
  void dispose() {
    recipeTitleTextController.dispose();
    recipeIngredientsTextController.dispose();
    recipeDescriptionTextController.dispose();
    super.dispose();
  }

  @override
  void saveRecipe() async {
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(this.context)
          .showSnackBar(SnackBar(content: Text('Please upload image')));
    }
    _myRecipes.recipeTitle = recipeTitleTextController.text.toString();
    _myRecipes.recipeIngredients =
        recipeIngredientsTextController.text.toString();
    _myRecipes.recipeDescription =
        recipeDescriptionTextController.text.toString();
    _myRecipes.image = imageUrl;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('MyRecipes')
        .add(_myRecipes.toJson())
        .then((value) => print('New recipe added!'))
        .catchError((error) => print('Failed to add recipe : $error'));
  }

  String imageUrl = '';

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
        print('Picked file is: ${pickedFile.path}');
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
        print('Picked file is: ${pickedFile.path}');
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 163, 246, 216),
        title: Text(
          'Add recipe',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            fontFamily: "Times",
          ),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Color.fromARGB(255, 247, 246, 244),
                        child: _photo != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _photo!,
                                  width: 350,
                                  height: 350,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 350,
                                height: 350,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                  size: 60,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    color: Color.fromARGB(255, 182, 247, 225),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: recipeTitleTextController,
                            showCursor: true,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (value) {
                              _myRecipes.recipeTitle = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Title',
                              hintStyle: TextStyle(color: Colors.amber),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 200, 226, 228),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: recipeIngredientsTextController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            showCursor: true,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (value) {
                              _myRecipes.recipeIngredients = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Ingredients',
                              hintStyle: TextStyle(color: Colors.amber),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 200, 226, 228),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: recipeDescriptionTextController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            showCursor: true,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (value) {
                              _myRecipes.recipeDescription = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Description',
                              hintStyle: TextStyle(color: Colors.amberAccent),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 200, 226, 228),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            saveRecipe();
                            uploadFile();
                            recipeTitleTextController.clear();
                            recipeIngredientsTextController.clear();
                            recipeDescriptionTextController.clear();
                          },
                          icon: const Icon(Icons.thumb_up),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 246, 226, 165),
                            shadowColor: Color.fromARGB(255, 247, 202, 117),
                            foregroundColor: Color.fromARGB(255, 102, 99, 90),
                            elevation: 20,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Times",
                            ),
                          ),
                          label: const Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
