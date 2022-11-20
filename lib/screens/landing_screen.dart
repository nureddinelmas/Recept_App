import 'package:flutter/material.dart';
import 'package:recept_app/models/my_recipes_model.dart';

const Images = [
  {"image": "Snake1.jpeg", "name": "Snake"},
  {"image": "Snake2.jpeg", "name": "Snake"},
  {"image": "SnakeTurquose.jpg", "name": "Turquose snake"},
];

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
            child: Column(
          children: [
            Expanded(
                flex: 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: Colors.lightBlue,
                    ),
                    Image.network(
                      'https://picsum.photos/id/1074/400/400',
                    ),
                  ],
                )),
            Container(
              width: constraints.maxHeight,
              color: Colors.grey.shade200,
              height: 400,
            )
          ],
        ));
      }),
    );
  }
}
