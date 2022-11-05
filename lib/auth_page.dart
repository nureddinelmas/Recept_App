import 'package:flutter/material.dart';
import 'package:recept_app/utils/firebaseprovider.dart';
import 'package:recept_app/widgets/drawer_signup.dart';
import 'package:recept_app/widgets/textformfield_email.dart';
import "package:recept_app/widgets/textformfield_pass.dart";
import 'package:recept_app/utils/utils.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool passwordIsHidden = false;
  final authHandler = FirebaseProvider();
  final snackbar = Utils();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void _checkIfEmptyOrNotAndSignInClient(BuildContext context) {
    String email, pass;

    email = emailTextController.text;
    pass = passwordTextController.text;

    if (email == "" && pass == "") {
      snackbar.snackbar(context, "Please fill in the forms");
    } else {
      authHandler.handleSignIn(email, pass, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      drawer: const Drawer(
        child: DrawerSignUpItem(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Foodly",
          style: TextStyle(fontFamily: "Times", fontSize: 35.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 500,
          color: Colors.grey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.only(top: 100),
                    child: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                            "https://png.pngtree.com/png-vector/20190917/ourlarge/pngtree-meal-icon-vectors-png-image_1737729.jpg"),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                  ),
                  TextFormFieldWidgetEmail(emailTextController),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  TextFormFieldPass(passwordTextController, passwordIsHidden),
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  GestureDetector(
                      child: const Text(
                        "Forgot Password?",
                        style:
                            TextStyle(color: Colors.white, fontFamily: "Times"),
                      ),
                      onTap: () {
                        authHandler.handleForgotPassword(
                            emailTextController.text, context);
                      }),
                  const Divider(
                    thickness: 2,
                    indent: 100,
                    endIndent: 100,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: SizedBox(
          width: 200,
          child: FloatingActionButton.extended(
            onPressed: () {

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceptHomeScreen(),
                  ));

              _checkIfEmptyOrNotAndSignInClient(context);

            },
            label: const Text("Log in"),
            icon: const Icon(Icons.login),
            backgroundColor: Colors.blueGrey,
            extendedTextStyle: const TextStyle(fontFamily: "Times"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
