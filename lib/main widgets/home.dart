import 'package:flutter/material.dart';
import 'package:recept_app/minor%20widgets/fake_search.dart';
import 'package:recept_app/my_home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const MyHomePage(),
      ),
    );
  }
}
