import 'package:flutter/material.dart';
import 'package:recept_app/utils/firebaseprovider.dart';
import 'package:recept_app/widgets/textformfield_email.dart';
import "package:recept_app/widgets/textformfield_pass.dart";
import "package:recept_app/widgets/textformfield_confirm.dart";
import 'package:recept_app/utils/utils.dart';

class DrawerSignUpItem extends StatefulWidget {
  const DrawerSignUpItem({Key? key}) : super(key: key);

  @override
  State<DrawerSignUpItem> createState() => _DrawerSignUpItemState();
}

class _DrawerSignUpItemState extends State<DrawerSignUpItem> {
  bool passwordIsHidden = false;
  bool confirmPasswordIsHidden = false;

  final authHandler = FirebaseProvider();
  final snackbar = Utils();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPassController = TextEditingController();

  void _checkIfEmptyOrNot(BuildContext context) {
    String email, pass, confirmPass;

    email = emailTextController.text;
    pass = passwordTextController.text;
    confirmPass = confirmPassController.text;

    if (email == "" && pass == "" && confirmPass == "") {
      snackbar.snackbar(context, "Please fill in the forms");
    } else {
      authHandler.handleSignUp(email, pass, confirmPass);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 250),
              ),
              const Text(
                "Create Account",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Times", fontSize: 20),
              ),
              Container(
                height: 50,
                width: 70,
                padding: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2.0, 4.0),
                        blurRadius: 20.0,
                        spreadRadius: 5.0),
                  ],
                ),
                child: CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                        "https://static.vecteezy.com/system/resources/thumbnails/006/692/762/small/taco-icon-template-black-color-editable-taco-icon-symbol-flat-illustration-for-graphic-and-web-design-free-vector.jpg"),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            endIndent: 30,
            indent: 30,
            color: Colors.white,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Column(
            children: [
              TextFormFieldWidgetEmail(emailTextController),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              TextFormFieldPass(passwordTextController, passwordIsHidden),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              TextFormFieldConfirmPass(
                  confirmPassController, confirmPasswordIsHidden)
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          const Divider(
            indent: 30.0,
            endIndent: 30.0,
            color: Colors.white,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 100.0),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _checkIfEmptyOrNot(context);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.local_pizza),
            style: ElevatedButton.styleFrom(
              elevation: 20,
              shape: const StadiumBorder(),
              backgroundColor: Colors.grey,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(fontSize: 20.0, fontFamily: "Times"),
            ),
            label: const Text("GO!"),
          ),
        ],
      ),
    );
  }
}
