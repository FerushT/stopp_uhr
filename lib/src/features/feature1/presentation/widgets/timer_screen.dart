import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // Hier speichere ich den Zustand des Timers.
  int _totalSeconds =
      0; // Ich definiere die gesamte Zeit, die ich für den Timer eingestellt habe, in Sekunden.
  int _currentSeconds =
      0; // Ich speichere die Anzahl der Sekunden, die noch übrig sind.
  bool _isRunning =
      false; // Ich halte fest, ob der Timer gerade läuft oder nicht.
  final TextEditingController _controller =
      TextEditingController(); // Ich verwende einen Controller für das Textfeld.

  void _startTimer() {
    // Hier starte ich die Funktion zum Starten des Timers.
    if (_totalSeconds > 0 && !_isRunning) {
      // Wenn ich eine Zeit eingegeben habe und der Timer nicht läuft.
      setState(() {
        // Ich sage der App, dass sich etwas geändert hat.
        _isRunning = true; // Der Timer läuft jetzt.
      });
      _countdown(); // Ich beginne, die Zeit runterzuzählen.
    }
  }

  void _pauseTimer() {
    // Hier definiere ich die Funktion zum Pausieren des Timers.
    setState(() {
      // Ich sage der App, dass sich etwas geändert hat.
      _isRunning = false; // Der Timer pausiert.
    });
  }

  void _countdown() {
    // Ich erstelle die Funktion für den Countdown.
    Future.delayed(const Duration(seconds: 1), () {
      // Ich warte 1 Sekunde.
      if (_isRunning && _currentSeconds > 0) {
        // Wenn der Timer läuft und noch Zeit übrig ist.
        setState(() {
          // Ich sage der App, dass sich etwas geändert hat.
          _currentSeconds--; // Ich verringere die verbleibenden Sekunden um 1.
        });
        _countdown(); // Ich rufe die Countdown-Funktion erneut auf.
      } else if (_currentSeconds == 0) {
        // Wenn keine Sekunden mehr übrig sind.
        setState(() {
          // Ich sage der App, dass sich etwas geändert hat.
          _isRunning = false; // Der Timer ist jetzt gestoppt.
        });
      }
    });
  }

  void _setTimer(int minutes) {
    // Hier definiere ich die Funktion zum Einstellen des Timers.
    setState(() {
      // Ich sage der App, dass sich etwas geändert hat.
      _totalSeconds = minutes * 60; // Ich setze die gesamte Zeit in Sekunden.
      _currentSeconds =
          _totalSeconds; // Ich setze die aktuelle Zeit auf die Gesamtdauer.
    });
  }

  String _formatTime(int seconds) {
    // Hier formatiere ich die Zeit leserlich.
    final minutes =
        (seconds ~/ 60); // Ich berechne die Minuten aus den Sekunden.
    final secs = seconds % 60; // Ich berechne die verbleibenden Sekunden.
    return '${minutes.toString().padLeft(2, "0")}:${secs.toString().padLeft(2, '0')}'; // Ich gebe die Zeit im Format "MM:SS" zurück.
  }

  double get _progress {
    // Hier berechne ich den Fortschritt.
    return _totalSeconds > 0
        ? _currentSeconds / _totalSeconds
        : 1; // Ich berechne, wie viel Zeit noch übrig ist.
  }

  @override
  Widget build(BuildContext context) {
    // Hier baue ich die Benutzeroberfläche.
    return Scaffold(
      // Das ist die grundlegende Struktur für meine Seite.
      backgroundColor: Colors.black, // Ich setze den Hintergrund auf schwarz.
      body: Center(
        // Ich zentriere den Inhalt der Seite.
        child: Padding(
          // Ich gebe etwas Platz um die Elemente.
          padding: const EdgeInsets.all(
              20.0), // Ich gebe 20 Pixel Abstand rundherum.
          child: Column(
            // Ich ordne die Elemente in einer Spalte an.
            mainAxisSize: MainAxisSize
                .min, // Die Spalte nimmt nur den Platz ein, den sie braucht.
            mainAxisAlignment:
                MainAxisAlignment.center, // Ich zentriere die Spalte.
            children: [
              const Text(
                // Ich füge ein Textfeld für den Titel hinzu.
                "Timer",
                style: TextStyle(
                  // Hier bestimme ich den Stil des Textes.
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                // Ich erstelle einen Container für das Eingabefeld.
                width: 225,
                child: TextField(
                  // Ich füge ein Eingabefeld für die Minuten hinzu.
                  controller:
                      _controller, // Ich verwende meinen Text-Controller.
                  keyboardType:
                      TextInputType.number, // Ich lasse nur Zahlen zu.
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    // Das Aussehen des Eingabefeldes.
                    labelText: "Zeit in Minuten eingeben",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      // Das ist die Umrandung, wenn das Feld aktiv ist.
                      borderSide:
                          BorderSide(color: Colors.white), // Weiße Umrandung.
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Das ist die Umrandung, wenn das Feld ausgewählt ist.
                      borderSide:
                          BorderSide(color: Colors.green), // Grüne Umrandung.
                    ),
                  ),
                  onChanged: (value) {
                    // Wenn sich der Text im Eingabefeld ändert.
                    int minutes = int.tryParse(value) ??
                        0; // Ich versuche, den Text in Minuten umzuwandeln.
                    _setTimer(
                        minutes); // Ich setze den Timer mit der eingegebenen Zeit.
                  },
                ),
              ),
              const SizedBox(height: 40),
              Stack(
                // Ich erstelle einen Stapel für den Fortschrittsindikator und die Zeit.
                alignment:
                    Alignment.center, // Ich zentriere die Kinder im Stapel.
                children: [
                  SizedBox(
                    // Ich füge ein Feld für den Fortschrittskreis hinzu.
                    width: 260, // Der Fortschrittskreis ist 260 Pixel breit.
                    height: 260, // Der Fortschrittskreis ist 260 Pixel hoch.
                    child: CircularProgressIndicator(
                      // Ich füge einen Fortschrittskreis hinzu.
                      value: _totalSeconds > 0
                          ? _progress
                          : 1, // Ich zeige den Fortschritt an.
                      strokeWidth: 12, // Die Breite des Fortschrittskreises.
                      backgroundColor: const Color.fromARGB(255, 218, 208,
                          208), // Der Hintergrund des Kreises ist grau.
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          // Die Farbe des Fortschritts ist orange.
                          Color.fromARGB(255, 224, 148, 25)),
                    ),
                  ),
                  Padding(
                    // Ich platziere den Zeittext.
                    padding: const EdgeInsets.only(
                        bottom: 20), // Ich gebe Abstand nach unten.
                    child: Text(
                      // Ich zeige die verbleibende Zeit an.
                      _formatTime(
                          _currentSeconds), // Ich formatiere die aktuelle Zeit.
                      style: const TextStyle(
                        // Hier bestimme ich den Stil des Zeittextes.
                        fontSize: 40, // Die Schriftgröße.
                        color: Colors.white, // Die Farbe.
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Row(
                // Ich erstelle eine Reihe für die Buttons.
                mainAxisAlignment:
                    MainAxisAlignment.center, // Ich zentriere die Buttons.
                children: [
                  ElevatedButton(
                    // Ich füge einen Start-/Pause-Button hinzu.
                    onPressed: _isRunning
                        ? _pauseTimer
                        : _startTimer, // Wenn der Timer läuft, pausiere ich, sonst starte ich.
                    style: ElevatedButton.styleFrom(
                      // Hier bestimme ich den Stil des Buttons.
                      backgroundColor:
                          _isRunning // Ich setze die Hintergrundfarbe.
                              ? const Color.fromARGB(255, 232, 114,
                                  106) // Rot, wenn der Timer pausiert.
                              : Colors.green, // Grün, wenn der Timer startet.
                      foregroundColor: Colors.black, // Die Schriftfarbe.
                      shape: RoundedRectangleBorder(
                        // Ich bestimme die Form des Buttons.
                        borderRadius: BorderRadius.circular(
                            10), // Ich mache die Ecken rund.
                      ),
                      minimumSize: const Size(
                          100, 50), // Ich setze die Mindestgröße des Buttons.
                    ),
                    child: Text(
                      // Der Text auf dem Button.
                      _isRunning
                          ? "Pause"
                          : "Starten", // Text ändert sich je nach Status.
                      style: const TextStyle(
                          color: Colors.black), // Die Schriftfarbe.
                    ),
                  ),
                  const SizedBox(width: 40),
                  ElevatedButton(
                    // Ich füge einen Reset-Button hinzu.
                    onPressed: () {
                      // Wenn der Button gedrückt wird.
                      setState(() {
                        // Ich sage der App, dass sich etwas geändert hat.
                        _isRunning = false; // Der Timer wird gestoppt.
                        _currentSeconds =
                            _totalSeconds; // Die aktuelle Zeit wird zurückgesetzt.
                        _controller.clear(); // Das Eingabefeld wird geleert.
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      // Hier bestimme ich den Stil des Reset-Buttons.
                      backgroundColor: Colors.grey, // Hintergrundfarbe.
                      foregroundColor: Colors.black, // Schriftfarbe.
                      shape: RoundedRectangleBorder(
                        // Ich bestimme die Form des Buttons.
                        borderRadius: BorderRadius.circular(
                            10), // Ich mache die Ecken rund.
                      ),
                      minimumSize: const Size(
                          100, 50), // Ich setze die Mindestgröße des Buttons.
                    ),
                    child: const Text("Reset"), // Text auf dem Button.
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
