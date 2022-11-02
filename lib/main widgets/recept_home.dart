import 'package:flutter/material.dart';
import 'package:recept_app/main%20widgets/home.dart';

class ReceptHomeScreen extends StatefulWidget {
  const ReceptHomeScreen({super.key});

  @override
  State<ReceptHomeScreen> createState() => _ReceptHomeScreenState();
}

class _ReceptHomeScreenState extends State<ReceptHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const Center(
      child: Text("Favorite Screen"),
    ),
    const Center(
      child: Text("New Recipe Screen"),
    ),
    const Center(
      child: Text("Profile Screen"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded), label: "New Recipe"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
