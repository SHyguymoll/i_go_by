import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

import 'affirmpage.dart';
import 'settingspage.dart';
import 'credits.dart';

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
          title: 'Main Page', nom: '', acc: '', gen: '', ref: '', uses: 0),
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
      required this.ref,
      required this.uses})
      : super(key: key);

  final String title;
  final String nom;
  final String acc;
  final String gen;
  final String ref;
  final int uses;

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
  int usesfluid = 0;
  List<Widget> quick = [];
  bool firstInit = true;

  //File? pronounFile;

  Future<String> _getPath() async {
    final _dir = await getApplicationDocumentsDirectory();
    return _dir.path;
  }

  void _load() async {
    final _path = await _getPath();
    final pFile = File('$_path/pronouns.txt');
    if (!(await pFile.exists())) {
      pFile.writeAsString('He\nHim\nHis\nHimself\n0', mode: FileMode.writeOnly);
    }

    List<String> _loaded = await pFile.readAsLines();
    setState(() {
      getPronounsFromFile(_loaded);
      quick = <Widget>[
        OutlinedButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 30),
          ),
          onPressed: () {
            _speak(nomfluid!);
            setState(() {
              usesfluid++;
            });
          },
          child: Text(nomfluid!),
        ),
        OutlinedButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 30),
          ),
          onPressed: () {
            _speak(accfluid!);
          },
          child: Text(accfluid!),
        ),
        OutlinedButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 30),
          ),
          onPressed: () {
            _speak(genfluid!);
          },
          child: Text(genfluid!),
        ),
        OutlinedButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 30),
          ),
          onPressed: () {
            _speak(reffluid!);
          },
          child: Text(reffluid!),
        ),
      ];
    });
  }

  void getPronounsFromFile(List<String> data) {
    nomfluid = data[0];
    accfluid = data[1];
    genfluid = data[2];
    reffluid = data[3];
    usesfluid = int.parse(data[4]);
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
                  ref: reffluid!,
                  useCount: usesfluid,
                )));

    await File('${await _getPath()}/pronouns.txt').writeAsString(
        '${result[0]}\n${result[1]}\n${result[2]}\n${result[3]}\n${result[4]}');

    setState(() {
      nomfluid = result[0];
      accfluid = result[1];
      genfluid = result[2];
      reffluid = result[3];
      usesfluid = result[4];
    });
  }

  void _affirmScreenReturn(BuildContext context) async {
    final List result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AffirmPage(
                  title: "Affirm",
                  nom: nomfluid!,
                  acc: accfluid!,
                  gen: genfluid!,
                  ref: reffluid!,
                  grabbedUses: usesfluid,
                )));

    await File('${await _getPath()}/pronouns.txt').writeAsString(
        '${result[0]}\n${result[1]}\n${result[2]}\n${result[3]}\n${result[4]}');

    setState(() {
      nomfluid = result[0];
      accfluid = result[1];
      genfluid = result[2];
      reffluid = result[3];
      usesfluid = result[4];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (firstInit) {
      _load();
      firstInit = false;
    } else {
      quick = <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25),
          ),
          onPressed: () {
            _speak(nomfluid!);
            setState(() {
              usesfluid++;
            });
          },
          child: Text(nomfluid!),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25),
          ),
          onPressed: () {
            _speak(accfluid!);
            setState(() {
              usesfluid++;
            });
          },
          child: Text(accfluid!),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25),
          ),
          onPressed: () {
            _speak(genfluid!);
            setState(() {
              usesfluid++;
            });
          },
          child: Text(genfluid!),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25),
          ),
          onPressed: () {
            _speak(reffluid!);
            setState(() {
              usesfluid++;
            });
          },
          child: Text(reffluid!),
        ),
      ];
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text('I Go By',
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                )),
            myDiv,
            OutlinedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 55),
              ),
              onPressed: () {
                _affirmScreenReturn(context);
              },
              child: const Text('Affirm'),
            ),
            OutlinedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 45),
              ),
              onPressed: () {
                _settingsScreenReturn(context);
              },
              child: const Text('Settings'),
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.headline6,
            ),
            OutlinedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Credits()));
              },
              child: const Text('Credits'),
            ),
            myDiv,
            Text('Uses: $usesfluid',
                style: Theme.of(context).textTheme.headline6),
            Text(
              'Quick Use',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: quick,
            )
          ],
        ),
      ),
    );
  }
}
