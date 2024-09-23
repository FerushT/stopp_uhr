import 'package:flutter/material.dart';
import 'package:stopp_uhr/src/features/feature1/presentation/stopwatch_screen.dart';
import 'package:stopp_uhr/src/features/feature1/presentation/widgets/timer_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Stopp Uhr",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Index der aktuell ausgewählten Seite

  // Liste der Seiten für die Bottom Navigation
  final List<Widget> _pages = [
    const StopwatchScreen(), // Stopp Uhr
    const TimerScreen(), // Timer, stelle sicher, dass diese Klasse existiert
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Aktualisiere den Index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white),
        title: const SizedBox.shrink(), // Leeres Widget anstelle von Text
      ),
      body: _pages[_selectedIndex], // Aktuell ausgewählte Seite
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.watch),
            label: 'Stopp Uhr',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange, // Icons in Orange
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black, // Hintergrundfarbe auf Schwarz setzen
        onTap: _onItemTapped,
      ),
    );
  }
}
