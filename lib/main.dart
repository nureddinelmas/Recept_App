import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recept_app/main_widgets/main_home.dart';
import 'package:recept_app/main_widgets/recept_home.dart';
import 'package:timetable/file_upload_firebase.dart';
import 'package:recept_app/screens/auth_screen.dart';

import 'main_widgets/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
    );
  }
}
