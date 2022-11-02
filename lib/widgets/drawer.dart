import 'dart:ui';
import 'package:flutter/material.dart';

class DrawerItem extends StatefulWidget {
  const DrawerItem({super.key});

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool passwordIsHidden = false;
  bool confirmPasswordIsHidden = false;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPassController = TextEditingController();

  void _checkIfEmptyOrNot(BuildContext context) {
    String email, pass, confirm;
    final scaffold = ScaffoldMessenger.of(context);

    email = emailTextController.text;
    pass = passwordTextController.text;
    confirm = confirmPassController.text;

    if (email == "" && pass == "" && confirm == "") {
      scaffold.showSnackBar(
        SnackBar(
          content: const Text("Please fill the forms"),
          action: SnackBarAction(
              label: "Undo", onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
    } else {
      //!* implement write to firebase
    }

    void addNewUserToFb() {}
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
              SizedBox(
                width: 250,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: emailTextController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Email",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mail,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              SizedBox(
                width: 250,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: !passwordIsHidden,
                  controller: passwordTextController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordIsHidden = !passwordIsHidden;
                        });
                      },
                      icon: Icon(
                        passwordIsHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: passwordIsHidden ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              SizedBox(
                width: 250,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: !confirmPasswordIsHidden,
                  controller: confirmPassController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Confirm Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          confirmPasswordIsHidden = !confirmPasswordIsHidden;
                        });
                      },
                      icon: Icon(
                        confirmPasswordIsHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: confirmPasswordIsHidden
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
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
