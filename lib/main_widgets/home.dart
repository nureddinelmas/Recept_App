import 'package:flutter/material.dart';

import 'package:recept_app/minor_widgets/fake_search.dart';
import 'package:recept_app/utils/firebaseprovider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../models/recipeModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List> recipeFuture = getUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch()),
      body: SingleChildScrollView(
        child: FutureBuilder<List>(
          future: recipeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final modell = snapshot.data!;
              return Build(model: modell);
            } else {
              return const Text("There is no data");
            }
          },
        ),
      ),
    );
  }
}

class Build extends StatelessWidget {
  final List model;
  final firebaseProvider = FirebaseProvider();
  Build({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: model.length,
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        final modell = model[index];
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
                        onTap: () {},
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
                                firebaseProvider.addToFavorite(modell['image']);
                              },
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.red),
                            ),
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
