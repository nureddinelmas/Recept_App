import 'package:flutter/material.dart';

class RecipesModel extends StatelessWidget {
  const RecipesModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        constraints: const BoxConstraints(
                            minHeight: 100, maxHeight: 250),
                        child: const Image(
                            image: NetworkImage(
                                "https://gimmesomeoven.com/wp-content/uploads/2020/04/Easy-Meatball-Recipe-3-1.jpg")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Köttbullar",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.red,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
