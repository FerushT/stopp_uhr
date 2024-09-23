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
      debugShowCheckedModeBanner:
          false, // Ich will kein Debug-Banner oben sehen.
      title: "Stopp Uhr", // Der Titel meiner App.
      home: HomePage(), // Die Startseite.
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState(); // Ich erstelle den Zustand für die Seite.
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex =
      0; // Dies zeigt, welche Seite ich gerade ausgewählt habe.

  // Liste von Seiten für die untere Navigation.
  final List<Widget> _pages = [
    const StopwatchScreen(), // Die Stopp-Uhr-Seite.
    const TimerScreen(), // Die Timer-Seite, ich stelle sicher, dass es diese Klasse gibt.
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Ich ändere den ausgewählten Index.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Der Hintergrund.
      appBar: AppBar(
        backgroundColor: Colors.black, // Oben ist auch schwarz.
        iconTheme: const IconThemeData(color: Colors.white), // Die Iconsfarbe
        titleTextStyle:
            const TextStyle(color: Colors.white), // Die Titeltextfarbe.
        title: const SizedBox.shrink(), // Ich habe keinen Text im Titel.
      ),
      body: _pages[_selectedIndex], // Hier zeige ich die aktuelle Seite an.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.watch), // Uhr-Icon.
            label: "Stopp Uhr", // Label für die Stopp-Uhr.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer), // Timer-Icon.
            label: "Timer", // Label für den Timer
          ),
        ],
        currentIndex: _selectedIndex, // Ich zeige den aktuellen Index.
        selectedItemColor: Colors.orange, // Farbe der ausgewählten Icons.
        unselectedItemColor:
            Colors.grey, // Die nicht ausgewählten Icons sind grau.
        backgroundColor:
            Colors.black, // Der Hintergrund der Navigation ist schwarz.
        onTap:
            _onItemTapped, // Wenn ich auf ein Icon tippe, wird _onItemTapped aufgerufen.
      ),
    );
  }
}
