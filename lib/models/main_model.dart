import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:recept_app/minor_widgets/recipe_details.dart';
import 'package:recept_app/utils/firebaseprovider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'recipeModel.dart';

class MainModel extends StatefulWidget {
  final String q;
  const MainModel({Key? key, required this.q}) : super(key: key);

  @override
  State<MainModel> createState() => _MainModelState();
}

class _MainModelState extends State<MainModel> {
  @override
  Widget build(BuildContext context) {
    Future<List> recipeFuture = getRecipes(widget.q);
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<List>(
          future: recipeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                    child: CircularProgressIndicator(
                  semanticsLabel: "Loading...",
                )),
              );
            } else if (snapshot.hasData) {
              final modell = snapshot.data!;
              return Build(model: modell);
            } else {
              return const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                    child: Text(
                  "There is no data",
                  style: TextStyle(fontSize: 30),
                )),
              );
            }
          },
        ),
      ),
    );
  }
}

class Build extends StatefulWidget {
  final List model;
  const Build({Key? key, required this.model}) : super(key: key);

  @override
  State<Build> createState() => _BuildState();
}

class _BuildState extends State<Build> {
  final firebaseProvider = FirebaseProvider();
  var isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.model.length,
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        final modell = widget.model[index];
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetailsScreen(recipe: modell),
                              ));
                        },
                        child: Container(
                          constraints: const BoxConstraints(
                              minHeight: 100, maxHeight: 250),
                          child: Image(
                              image: NetworkImage(modell['images']['REGULAR']
                                      ['url']
                                  .toString())),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                modell['label'].toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  firebaseProvider.addToFavorite(
                                      modell['images']['REGULAR']['url'],
                                      modell['url'],
                                      modell['label'].toString(),
                                      modell['source'],
                                      modell["cuisineType"]);
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
    );
  }
}
