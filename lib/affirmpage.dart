import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AffirmPage extends StatefulWidget {
  const AffirmPage(
      {Key? key,
      required this.title,
      required this.nom,
      required this.acc,
      required this.gen,
      required this.ref,
      required this.grabbedUses})
      : super(key: key);

  final String nom;
  final String acc;
  final String gen;
  final String ref;
  final String title;
  final int grabbedUses;

  @override
  State<AffirmPage> createState() => _AffirmPageState();
}

enum TtsState { playing, stopped, paused, continued }

class _AffirmPageState extends State<AffirmPage> {
  int _counter = 0;
  bool firstInit = true;

  final Divider myDiv = const Divider(
    color: Colors.black,
    thickness: 1,
    indent: 15,
    endIndent: 15,
  );

  FlutterTts tts = FlutterTts();

  Future _speak(String phrase) async {
    await tts.speak(phrase);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (firstInit) {
      _counter = widget.grabbedUses;
      firstInit = false;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text('Affirm',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Please respect my pronouns,\nthey are ${widget.nom}/${widget.acc}',
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.volume_up_sharp),
                  tooltip: 'Play sound',
                  onPressed: () {
                    _speak(
                        'Please respect my pronouns, they are ${widget.nom}/${widget.acc}');
                    _incrementCounter();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sorry, I go by ${widget.nom}/${widget.acc}',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.volume_up_sharp),
                  tooltip: 'Play sound',
                  onPressed: () {
                    _speak('Sorry, I go by ${widget.nom}/${widget.acc}');
                    _incrementCounter();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Please use ${widget.nom}/${widget.acc}',
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.volume_up_sharp),
                  tooltip: 'Play sound',
                  onPressed: () {
                    _speak('Please use ${widget.nom}/${widget.acc}');
                    _incrementCounter();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('I go by ${widget.nom}/${widget.acc}',
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.volume_up_sharp),
                  tooltip: 'Play sound',
                  onPressed: () {
                    _speak('I go by ${widget.nom}/${widget.acc}');
                    _incrementCounter();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Use ${widget.nom}/${widget.acc}',
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.volume_up_sharp),
                  tooltip: 'Play sound',
                  onPressed: () {
                    _speak('Use ${widget.nom}/${widget.acc}');
                    _incrementCounter();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.nom}/${widget.acc}',
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )),
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.volume_up_sharp),
                  tooltip: 'Play sound',
                  onPressed: () {
                    _speak('${widget.nom}/${widget.acc}');
                    _incrementCounter();
                  },
                ),
              ],
            ),
            Text(
              'Uses: $_counter',
              style: const TextStyle(fontSize: 30),
            ),
            myDiv,
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 25),
              ),
              onPressed: () {
                Navigator.pop(context, [
                  widget.nom,
                  widget.acc,
                  widget.gen,
                  widget.ref,
                  _counter,
                ]);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
