import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

import 'affirmpage.dart';
import 'settingspage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(
          title: 'Main Page', nom: '', acc: '', gen: '', ref: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.nom,
      required this.acc,
      required this.gen,
      required this.ref})
      : super(key: key);

  final String title;
  final String nom;
  final String acc;
  final String gen;
  final String ref;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  String? nomfluid;
  String? accfluid;
  String? genfluid;
  String? reffluid;
  bool firstInit = true;

  //File? pronounFile;

  Future<String> _getPath() async {
    final _dir = await getApplicationDocumentsDirectory();
    return _dir.path;
  }

  void _load() async {
    final _path = await _getPath();
    final pFile = File('$_path/pronouns.txt');

    pFile.writeAsString('He\nHim\nHis\nHimself', mode: FileMode.writeOnly);

    final List<String> _loaded = await pFile.readAsLines();
    setState(() {
      getPronounsFromFile(_loaded);
    });
  }

  void getPronounsFromFile(List<String> data) {
    //nomfluid = data.substring(0, data.indexOf('\n'));
    //data = data.substring(data.indexOf('\n') + 1);
    //accfluid = data.substring(0, data.indexOf('\n'));
    //data = data.substring(data.indexOf('\n') + 1);
    //genfluid = data.substring(0, data.indexOf('\n'));
    //data = data.substring(data.indexOf('\n') + 1);
    //reffluid = data.substring(0, data.indexOf('\n'));
    nomfluid = data[0];
    accfluid = data[1];
    genfluid = data[2];
    reffluid = data[3];
  }

  void _settingsScreenReturn(BuildContext context) async {
    final List result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingsPage(
                title: "Settings",
                nom: nomfluid!,
                acc: accfluid!,
                gen: genfluid!,
                ref: reffluid!)));

    final _path = await _getPath();
    final pFile = File('$_path/pronouns.txt');
    await pFile.writeAsString('$result[0]\n$result[1]\n$result[2]\n$result[3]');

    setState(() {
      nomfluid = result[0];
      accfluid = result[1];
      genfluid = result[2];
      reffluid = result[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (firstInit) {
      _load();
      //nomfluid = widget.nom;
      //accfluid = widget.acc;
      //genfluid = widget.gen;
      //reffluid = widget.ref;
      firstInit = false;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text('I Go By',
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                )),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AffirmPage(
                            title: "Affirm",
                            nom: nomfluid!,
                            acc: accfluid!,
                            gen: genfluid!,
                            ref: reffluid!)));
              },
              child: const Text('Affirm'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
              ),
              onPressed: () {
                _settingsScreenReturn(context);
              },
              child: const Text('Settings'),
            ),
            Text(
              ' ',
              style: Theme.of(context).textTheme.headline4,
            ),
            myDiv,
            Text(
              'Quick Use',
              style: Theme.of(context).textTheme.headline5,
            ),
            //quickAccess, //broken due to file loading errors, fix later
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton(
      //  onPressed: _incrementCounter,
      //  tooltip: 'Increment',
      //  child: const Icon(Icons.add),
      //), // This trailing comma makes auto-formatting nicer for build methods.
    );

    Row quickAccess = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25),
          ),
          onPressed: () => _speak(nomfluid!),
          child: Text(nomfluid!),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25),
          ),
          onPressed: () => _speak(accfluid!),
          child: Text(accfluid!),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25),
          ),
          onPressed: () => _speak(genfluid!),
          child: Text(genfluid!),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25),
          ),
          onPressed: () => _speak(reffluid!),
          child: Text(reffluid!),
        ),
      ],
    );
  }
}
