import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  int _elapsedTime =
      0; // ist die Zeit die seit dem Start der Stoppuhr vergangen ist.
  bool _isRunning = false; // Gibt an, ob die Stoppuhr gerade läuft.
  Timer? _timer; // Variabler Timer der die Zeit trackt.

  // Dauer für die vollstänidge Kreisanimation, (2 Minuten in Millisekunden)
  final int _fullDuration = 120000;

  // Startet die Stoppuhr, wenn die Stoppuhr bereits läuft, tut diese Methode nichts.
  _startStopwatch() async {
    if (_isRunning) return;

    _isRunning = true;

    // Das ist ein Timer, der alle 10 Millisekunden die Zeit erhöht und durch das setState das UI aktualisiert.
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedTime += 10;
      });
    });
  }

  // Stoppt die Stoppuhr und beendet den Timer.
  _stopStopwatch() async {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  // Setzt die Zeit zurück und stoppt den Timer.
  _resetStopwatch() async {
    setState(() {
      _elapsedTime = 0;
      _isRunning = false;
    });
    _timer?.cancel();
  }

  //Berechnet die Anzahl der Minuten aus der Zeitdifferenz _elapsedTime in Millisekunden und
  //wandelt die Minutenzahl in einen String um. Er stellt sicher,
  //dass dieser String immer mindestens zwei Ziffern hat, indem er eventuell führende Nullen hinzufügt.
  @override
  Widget build(BuildContext context) {
    final minutes = (_elapsedTime ~/ 60000).toString().padLeft(2, "0");
    final seconds = ((_elapsedTime % 60000) ~/ 1000).toString().padLeft(2, "0");
    final milliseconds =
        ((_elapsedTime % 1000) ~/ 10).toString().padLeft(2, "0");

    // _elapsedTime/_fullduration bedeutet, dass die bereits verstrichene Zeit durch die Gesamtdauer teilt.
    final double progress = _elapsedTime / _fullDuration;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              //"Stack" überlagert die UI-Elemente.
              alignment: Alignment.center,
              children: [
                //Kreisförmiger Fortschrittsindikator
                SizedBox(
                  width: 260,
                  height: 260,
                  child: CircularProgressIndicator(
                    //ist ein kreisförmiger Fortschritssbalken.
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: const Color.fromARGB(255, 218, 208, 208),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 224, 148, 25)),
                  ),
                ),

                // Die Zeiten (Minuten, Sekunden, Millisekunden) wird in der Mitte des CircularProgressIndicator angezeigt.
                // Ich habe für jeden einzelnen Zeitwert (Minunten, Sekunden, Millisekunden) eine Sized Box angewendet
                // damit die Zeitangabe konstant in seinem Bereich bleibt und nicht "wackelt", wenn die Stoppuhr läuft.
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        minutes,
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Text(
                      ":",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        seconds,
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Text(
                      ":",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        milliseconds,
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            ),
            // Eine Reihe mit den Steuerungsknöpfen, welche durch mainAxisAlignment.center mittig platziert wird.
            // (Start,Stopp und Reset).
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dieser Block zeigt verschiedene ElevatedButton´s für "Starten", "Stoppen" u. "Zurücksetzen" der Stoppuhr an.
                // _is Running ändert den Stil und ihre Funktion der Buttons je nach Zustand.
                _isRunning
                    ? ElevatedButton(
                        onPressed: () {
                          _stopStopwatch();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 232, 114, 106),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(100, 50),
                        ),
                        child: const Text("Stoppen"),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _startStopwatch();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(100, 50),
                        ),
                        child: const Text("Starten"),
                      ),
                const SizedBox(width: 40),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(100, 50),
                  ),
                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
