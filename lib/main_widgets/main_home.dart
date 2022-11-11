import 'package:flutter/material.dart';
import 'package:recept_app/models/main_model.dart';
import 'package:recept_app/minor_widgets/fake_search.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.amber,
            indicatorWeight: 6,
            tabs: [
              RepeatedTab(
                label: "Popular",
              ),
              RepeatedTab(
                label: "Swedish",
              ),
              RepeatedTab(
                label: "Turkish",
              ),
              RepeatedTab(
                label: "Mexico",
              ),
              RepeatedTab(
                label: "Italian",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MainModel(
              q: "Popular",
            ),
            MainModel(
              q: "Swedish",
            ),
            MainModel(
              q: "Turkish",
            ),
            MainModel(
              q: "Mexico",
            ),
            MainModel(
              q: "Italian",
            )
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
