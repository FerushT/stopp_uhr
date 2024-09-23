import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  // Hier speichere ich den Zustand der Stoppuhr.
  int _elapsedTime =
      0; // Ich speichere die Zeit, die seit dem Start vergangen ist, in Millisekunden.
  bool _isRunning = false; // Ich halte fest, ob die Stoppuhr läuft oder nicht.
  Timer? _timer; // Hier speichere ich den Timer zur Zeitverfolgung.

  final int _fullDuration =
      120000; // Ich setze die Dauer für die vollständige Kreisanimation auf 2 Minuten (120.000 Millisekunden).

  void _startStopwatch() {
    // Hier definiere ich die Funktion zum Starten der Stoppuhr.
    if (_isRunning) return; // Wenn die Stoppuhr schon läuft, mache nichts.

    _isRunning = true; // Ich setze den Status der Stoppuhr auf "läuft".

    // Ich starte einen Timer, der alle 10 Millisekunden die Zeit erhöht und die Benutzeroberfläche aktualisiert.
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        // Ich sage der App, dass sich etwas geändert hat.
        _elapsedTime +=
            10; // Ich erhöhe die vergangene Zeit um 10 Millisekunden.
      });
    });
  }

  void _stopStopwatch() {
    // Hier definiere ich die Funktion zum Stoppen der Stoppuhr.
    setState(() {
      // Ich sage der App, dass sich etwas geändert hat.
      _isRunning = false; // Die Stoppuhr läuft jetzt nicht mehr.
    });
    _timer?.cancel(); // Ich stoppe den Timer, wenn er existiert.
  }

  void _resetStopwatch() {
    // Hier definiere ich die Funktion zum Zurücksetzen der Stoppuhr.
    setState(() {
      // Ich sage der App, dass sich etwas geändert hat.
      _elapsedTime = 0; // Ich setze die vergangene Zeit auf 0.
      _isRunning = false; // Die Stoppuhr läuft nicht.
    });
    _timer?.cancel(); // Ich stoppe den Timer, wenn er existiert.
  }

  @override
  Widget build(BuildContext context) {
    // Hier baue ich die Benutzeroberfläche.
    final minutes = (_elapsedTime ~/ 60000)
        .toString()
        .padLeft(2, "0"); // Ich berechne die Minuten.
    final seconds = ((_elapsedTime % 60000) ~/ 1000)
        .toString()
        .padLeft(2, "0"); // Ich berechne die Sekunden.
    final milliseconds = ((_elapsedTime % 1000) ~/ 10)
        .toString()
        .padLeft(2, "0"); // Ich berechne die Millisekunden.
    final double progress = _elapsedTime /
        _fullDuration; // Ich berechne den Fortschritt der Stoppuhr.

    return Center(
      // Ich zentriere den Inhalt.
      child: Padding(
        // Ich gebe etwas Platz um die Elemente.
        padding:
            const EdgeInsets.all(20.0), // Ich gebe 20 Pixel Abstand rundherum.
        child: Column(
          // Ich ordne die Elemente in einer Spalte an.
          mainAxisSize: MainAxisSize
              .min, // Die Spalte nimmt nur den Platz ein, den sie braucht.
          mainAxisAlignment:
              MainAxisAlignment.center, // Ich zentriere die Spalte.
          children: [
            // Ich füge die Überschrift "Stopp Uhr" hinzu.
            const Text(
              "Stopp Uhr",
              style: TextStyle(
                // Hier bestimme ich den Stil des Textes.
                fontSize: 32, // Die Schriftgröße.
                color: Colors.white, // Die Schriftfarbe.
                fontWeight: FontWeight.bold, // Der Text ist fett.
              ),
            ),
            const SizedBox(height: 70),

            Stack(
              // Ich erstelle einen Stapel für den Fortschrittskreis und die Zeit.
              alignment:
                  Alignment.center, // Ich zentriere die Kinder im Stapel.
              children: [
                SizedBox(
                  // Ich füge ein Feld für den Fortschrittskreis hinzu.
                  width: 260, // Der Fortschrittskreis ist 260 Pixel breit.
                  height: 260, // Der Fortschrittskreis ist 260 Pixel hoch.
                  child: CircularProgressIndicator(
                    // Ich füge einen Fortschrittskreis hinzu.
                    value: progress, // Ich zeige den Fortschritt an.
                    strokeWidth: 12, // Die Breite des Fortschrittskreises.
                    backgroundColor: const Color.fromARGB(
                        255, 218, 208, 208), // Der Hintergrund des Kreises.
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        // Die Farbe des Fortschritts.
                        Color.fromARGB(255, 224, 148, 25)),
                  ),
                ),
                Row(
                  // Ich erstelle eine Reihe für die Zeitanzeigen.
                  mainAxisSize: MainAxisSize
                      .min, // Die Reihe nimmt nur den Platz ein, den sie braucht.
                  children: [
                    SizedBox(
                      // Ich füge ein Feld für die Minuten hinzu.
                      width: 70,
                      child: Text(
                        // Ich zeige die Minuten an.
                        minutes,
                        style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white), // Stil für die Minuten.
                        textAlign: TextAlign.center, // Ich zentriere den Text.
                      ),
                    ),
                    const Text(
                      // Ich füge einen Doppelpunkt hinzu.
                      ":",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40), // Stil für den Doppelpunkt.
                    ),
                    SizedBox(
                      // Ich füge ein Feld für die Sekunden hinzu.
                      width: 70,
                      child: Text(
                        seconds,
                        style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white), // Stil für die Sekunden.
                        textAlign: TextAlign.center, // Ich zentriere den Text.
                      ),
                    ),
                    const Text(
                      // Ich füge einen Doppelpunkt hinzu.
                      ":",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40), // Stil für den Doppelpunkt.
                    ),
                    SizedBox(
                      // Ich füge ein Feld für die Millisekunden hinzu.
                      width: 70,
                      child: Text(
                        milliseconds,
                        style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white), // Stil für die Millisekunden.
                        textAlign: TextAlign.center, // Ich zentriere den Text.
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 100), // Ich füge Abstand nach unten hinzu.
            Row(
              // Ich erstelle eine Reihe für die Buttons.
              mainAxisAlignment:
                  MainAxisAlignment.center, // Ich zentriere die Buttons.
              children: [
                _isRunning // Wenn die Stoppuhr läuft.
                    ? ElevatedButton(
                        // Ich füge einen Button zum Stoppen hinzu.
                        onPressed:
                            _stopStopwatch, // Wenn gedrückt, stoppe die Stoppuhr.
                        style: ElevatedButton.styleFrom(
                          // Hier bestimme ich den Stil des Buttons.
                          backgroundColor: const Color.fromARGB(
                              255, 232, 114, 106), // Hintergrundfarbe.
                          foregroundColor: Colors.black, // Schriftfarbe.
                          shape: RoundedRectangleBorder(
                            // Ich bestimme die Form des Buttons.
                            borderRadius: BorderRadius.circular(
                                10), // Ich mache die Ecken rund.
                          ),
                          minimumSize:
                              const Size(100, 50), // Mindestgröße des Buttons.
                        ),
                        child: const Text("Stoppen"), // Text auf dem Button.
                      )
                    : ElevatedButton(
                        // Wenn die Stoppuhr nicht läuft.
                        onPressed:
                            _startStopwatch, // Wenn gedrückt, starte die Stoppuhr.
                        style: ElevatedButton.styleFrom(
                          // Hier bestimme ich den Stil des Buttons.
                          backgroundColor: Colors.green, // Hintergrundfarbe.
                          foregroundColor: Colors.black, // Schriftfarbe.
                          shape: RoundedRectangleBorder(
                            // Ich bestimme die Form des Buttons.
                            borderRadius: BorderRadius.circular(
                                10), // Ich mache die Ecken rund.
                          ),
                          minimumSize:
                              const Size(100, 50), // Mindestgröße des Buttons.
                        ),
                        child: const Text("Starten"), // Text auf dem Button.
                      ),
                const SizedBox(
                    width: 40), // Ich füge Abstand zwischen den Buttons hinzu.
                ElevatedButton(
                  // Ich füge einen Reset-Button hinzu.
                  onPressed:
                      _resetStopwatch, // Wenn gedrückt, setze die Stoppuhr zurück.
                  style: ElevatedButton.styleFrom(
                    // Hier bestimme ich den Stil des Reset-Buttons.
                    backgroundColor: Colors.grey, // Hintergrundfarbe.
                    foregroundColor: Colors.black, // Schriftfarbe.
                    shape: RoundedRectangleBorder(
                      // Ich bestimme die Form des Buttons.
                      borderRadius: BorderRadius.circular(
                          10), // Ich mache die Ecken rund.
                    ),
                    minimumSize:
                        const Size(100, 50), // Mindestgröße des Buttons.
                  ),
                  child: const Text("Reset"), // Text auf dem Button.
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
