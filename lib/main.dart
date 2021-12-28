import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

import 'affirmpage.dart';
import 'settingspage.dart';

Future<String> getlocalFilePath() async {
  return (await getApplicationDocumentsDirectory()).path + '/pronouns.txt';
}

File get _localFile {
  var path = getlocalFilePath();
  if (!File('$path').existsSync()) {
    File('$path').createSync();
  }
  return File('$path');
}

void writePronouns(String nom, String acc, String gen, String ref) {
  final file = _localFile;
  // Write the file
  file.writeAsString('$nom\n$acc\n$gen\n$ref');
}

//String getNom() {
//  String decode = readPronouns(); //Pretend decode = he(\n)him(\n)his(\n)himself
//  return decode.substring(0, decode.indexOf('\n')); //nom = he
//}
//String getAcc() {
//  String decode = readPronouns(); //Pretend decode = he(\n)him(\n)his(\n)himself
//  decode = decode
//      .substring(decode.indexOf('\n') + 1); //decode = him(\n)his(\n)himself
//  return decode.substring(0, decode.indexOf('\n')); //acc = him
//}
//String getGen() {
//  String decode = readPronouns(); //Pretend decode = he(\n)him(\n)his(\n)himself
//  for (int i = 0; i < 2; i++) {
//    decode = decode.substring(decode.indexOf('\n') + 1);
//  } //decode = his(\n)himself
//  return decode.substring(0, decode.indexOf('\n')); //gen = his
//}
//String getRef() {
//  String decode = readPronouns(); //Pretend decode = he(\n)him(\n)his(\n)himself
//  for (int i = 0; i < 3; i++) {
//    decode = decode.substring(decode.indexOf('\n') + 1);
//  } //decode = himself
//  return decode;
//}

String getNom() {
  return 'they';
}

String getAcc() {
  return 'them';
}

String getGen() {
  return 'their';
}

String getRef() {
  return 'themselves';
}

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
          title: 'Main Page',
          nom: 'He',
          acc: 'Him',
          gen: 'His',
          ref: 'Himself'),
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
  FlutterTts tts = FlutterTts();

  Future _speak(String phrase) async {
    await tts.speak(phrase);
  }

  void _affirmScreenReturn(BuildContext context, String nomgiven,
      String accgiven, String gengiven, String refgiven) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AffirmPage(
                title: "Affirm",
                nom: nomgiven,
                acc: accgiven,
                gen: gengiven,
                ref: refgiven)));
    setState(() {
      nomgiven = result[0];
      accgiven = result[1];
      gengiven = result[2];
      refgiven = result[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    String nomfluid = widget.nom;
    String accfluid = widget.acc;
    String genfluid = widget.gen;
    String reffluid = widget.ref;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
                _affirmScreenReturn(
                    context, nomfluid, accfluid, genfluid, reffluid);
              },
              child: const Text('Affirm'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(
                          title: "Settings",
                          nom: getNom(),
                          acc: getAcc(),
                          gen: getGen(),
                          ref: getRef())),
                );
              },
              child: const Text('Settings'),
            ),
            Text(
              ' ',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Quick Use',
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                  onPressed: () => _speak(getNom()),
                  child: Text(getNom()),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                  onPressed: () => _speak(getAcc()),
                  child: Text(getAcc()),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                  onPressed: () => _speak(getGen()),
                  child: Text(getGen()),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                  onPressed: () => _speak(getRef()),
                  child: Text(getRef()),
                ),
              ],
            ),
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton(
      //  onPressed: _incrementCounter,
      //  tooltip: 'Increment',
      //  child: const Icon(Icons.add),
      //), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
