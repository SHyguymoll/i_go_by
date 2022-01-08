import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
    required this.title,
    required this.nom,
    required this.acc,
    required this.gen,
    required this.ref,
    required this.useCount,
  }) : super(key: key);

  final String nom;
  final String acc;
  final String gen;
  final String ref;
  final int useCount;
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

enum RadioOptions { male, female, nonbinary, custom }

RadioOptions? radioPicked;

class _SettingsPageState extends State<SettingsPage> {
  bool checkEnabled = false;
  bool firstInit = true;

  int determineRadio() {
    if (nomSettings == 'He' &&
        accSettings == 'Him' &&
        genSettings == 'His' &&
        refSettings == 'Himself') {
      return 0;
    } else if (nomSettings == 'She' &&
        accSettings == 'Her' &&
        genSettings == 'Her' &&
        refSettings == 'Herself') {
      return 1;
    } else if (nomSettings == 'They' &&
        accSettings == 'Them' &&
        genSettings == 'Their' &&
        refSettings == 'Themself') {
      return 2;
    } else {
      return 3;
    }
  }

  String? nomSettings;
  String? accSettings;
  String? genSettings;
  String? refSettings;
  int? useNumber;

  @override
  Widget build(BuildContext context) {
    if (firstInit) {
      nomSettings = widget.nom;
      accSettings = widget.acc;
      genSettings = widget.gen;
      refSettings = widget.ref;
      useNumber = widget.useCount;
      firstInit = false;
    }

    const Divider myDiv = Divider(
      color: Colors.black,
      thickness: 1,
      indent: 15,
      endIndent: 15,
    );

    switch (determineRadio()) {
      case 0:
        radioPicked = RadioOptions.male;
        break;
      case 1:
        radioPicked = RadioOptions.female;
        break;
      case 2:
        radioPicked = RadioOptions.nonbinary;
        break;
      case 3:
        radioPicked = RadioOptions.custom;
        break;
    }

    if (determineRadio() == 3) {
      checkEnabled = true;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text('Settings',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                )),
            RadioListTile<RadioOptions>(
                title: const Text("Male"),
                value: RadioOptions.male,
                groupValue: radioPicked,
                onChanged: (RadioOptions? value) {
                  setState(() {
                    nomSettings = 'He';
                    accSettings = 'Him';
                    genSettings = 'His';
                    refSettings = 'Himself';
                    radioPicked = value;
                    checkEnabled = false;
                  });
                }),
            RadioListTile<RadioOptions>(
                title: const Text("Female"),
                value: RadioOptions.female,
                groupValue: radioPicked,
                onChanged: (RadioOptions? value) {
                  setState(() {
                    nomSettings = 'She';
                    accSettings = 'Her';
                    genSettings = 'Her';
                    refSettings = 'Herself';
                    radioPicked = value;
                    checkEnabled = false;
                  });
                }),
            RadioListTile<RadioOptions>(
                title: const Text("Nonbinary"),
                value: RadioOptions.nonbinary,
                groupValue: radioPicked,
                onChanged: (RadioOptions? value) {
                  setState(() {
                    nomSettings = 'They';
                    accSettings = 'Them';
                    genSettings = 'Their';
                    refSettings = 'Themself';
                    radioPicked = value;
                    checkEnabled = false;
                  });
                }),
            RadioListTile<RadioOptions>(
                title: const Text("Custom"),
                value: RadioOptions.custom,
                groupValue: radioPicked,
                onChanged: (RadioOptions? value) {
                  setState(() {
                    if (determineRadio() != 3) {
                      nomSettings = '';
                      accSettings = '';
                      genSettings = '';
                      refSettings = '';
                    }
                    radioPicked = value;
                    checkEnabled = true;
                  });
                }),
            myDiv,
            Row(
              //Nom
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Nominative (He):',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    enabled: checkEnabled,
                    controller: TextEditingController(text: nomSettings),
                    onSubmitted: (value) {
                      setState(() {
                        nomSettings = value;
                      });
                    },
                  ),
                )
              ],
            ),
            Row(
              //Acc
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Accusative (Her):',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    enabled: checkEnabled,
                    controller: TextEditingController(text: accSettings),
                    onSubmitted: (value) {
                      setState(() {
                        accSettings = value;
                      });
                    },
                  ),
                )
              ],
            ),
            Row(
              //Gen
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Genitive (Their):',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    enabled: checkEnabled,
                    controller: TextEditingController(text: genSettings),
                    onSubmitted: (value) {
                      setState(() {
                        genSettings = value;
                      });
                    },
                  ),
                )
              ],
            ),
            Row(
              //Ref
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Reflexive (Himself):',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    enabled: checkEnabled,
                    controller: TextEditingController(text: refSettings),
                    onSubmitted: (value) {
                      setState(() {
                        refSettings = value;
                      });
                    },
                  ),
                )
              ],
            ),
            myDiv,
            OutlinedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  useNumber = 0;
                });
              },
              child: Text('Reset Uses (Uses: $useNumber)'),
            ),
            myDiv,
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 25),
              ),
              onPressed: () {
                Navigator.pop(context, [
                  nomSettings,
                  accSettings,
                  genSettings,
                  refSettings,
                  useNumber,
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
