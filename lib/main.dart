import 'package:flutter/material.dart';

import 'package:recept_app/auth_page.dart';


void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Receply",
      home: AuthPage(),

    );
  }
}
