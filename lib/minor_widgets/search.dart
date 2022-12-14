import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recept_app/models/main_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchInput = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: CupertinoSearchTextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {
              searchInput = value.toLowerCase();
            });
          },
        ),
      ),
      body: MainModel(q: searchInput),
    );
  }
}
