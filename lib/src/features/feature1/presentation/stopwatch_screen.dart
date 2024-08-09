import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  int _elapsedTime = 0;
  bool _isRunning = false;
  Timer? _timer; // Variabler Timer zur Steuerung der Uhr

  // Dauer für die vollstänidge Kreisanimation
  final int _fullDuration = 120000; // 2 Minuten in Millisekunden

  _startStopwatch() async {
    if (_isRunning) return;

    _isRunning = true;

    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedTime += 10; // verstreichte Zeit erhöhen
      });
    });
  }

  _stopStopwatch() async {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  _resetStopwatch() async {
    setState(() {
      _elapsedTime = 0;
      _isRunning = false;
    });
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_elapsedTime ~/ 60000).toString().padLeft(2, "0");
    final seconds = ((_elapsedTime % 60000) ~/ 1000).toString().padLeft(2, "0");
    final milliseconds =
        ((_elapsedTime % 1000) ~/ 10).toString().padLeft(2, "0");

    // Berechnung des Fortschritts als Bruchteil der vollständigen Dauer
    final double progress = _elapsedTime / _fullDuration;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                //Kreisförmiger Fortschrittsindikator
                SizedBox(
                  width: 260,
                  height: 260,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: const Color.fromARGB(255, 218, 208, 208),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 224, 144, 25)),
                  ),
                ),
                // Zeit in der Mitte des kreisförmigen Indikators

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
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isRunning
                    ? ElevatedButton(
                        onPressed:
                            !_isRunning ? null : () async => _stopStopwatch(),
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
                        onPressed: _isRunning
                            ? null
                            : () async => await _startStopwatch(),
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
