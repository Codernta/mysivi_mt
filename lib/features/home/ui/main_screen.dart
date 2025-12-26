import 'package:flutter/material.dart';
import 'package:mysivi_mt/features/home/ui/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  int bottomIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: bottomIndex,
        children: const [
          HomeScreen(),
          PlaceholderScreen(title: 'Tab 2 Placeholder'),
          PlaceholderScreen(title: 'Tab 3 Placeholder'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        onTap: (i) => setState(() => bottomIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Tab 2'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Tab 3'),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}



