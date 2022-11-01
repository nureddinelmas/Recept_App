import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Foodly",
          style: TextStyle(fontFamily: "Times", fontSize: 35.0),
        ),
      ),
      body: Container(
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
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Email",
                      hintText: "",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.mail),
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Password",
                      hintText: "",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                GestureDetector(
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white, fontFamily: "Times"),
                  ),
                ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: SizedBox(
          width: 200,
          child: FloatingActionButton.extended(
            onPressed: () {},
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
