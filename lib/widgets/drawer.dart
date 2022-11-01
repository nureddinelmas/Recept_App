import 'dart:ui';

import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key});

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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility_off,
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Confirm Password",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility_off,
                        color: Colors.blueGrey,
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
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.food_bank),
            label: const Text("GO!"),
          ),
        ],
      ),
    );
  }
}
