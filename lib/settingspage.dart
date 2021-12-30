import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(
      {Key? key,
      required this.title,
      required this.nom,
      required this.acc,
      required this.gen,
      required this.ref})
      : super(key: key);

  final String nom;
  final String acc;
  final String gen;
  final String ref;
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

enum RadioOptions { male, female, nonbinary, custom }

class _SettingsPageState extends State<SettingsPage> {
  RadioOptions? radioPicked = RadioOptions.male;

  bool checkEnabled = false;
  bool firstInit = true;

  String? nomSettings;
  String? accSettings;
  String? genSettings;
  String? refSettings;

  @override
  Widget build(BuildContext context) {
    if (firstInit) {
      nomSettings = widget.nom;
      accSettings = widget.acc;
      genSettings = widget.gen;
      refSettings = widget.ref;
      firstInit = false;
    }

    void updateDropDown() {
      if (widget.nom == 'He' &&
          widget.acc == 'Him' &&
          widget.gen == 'His' &&
          widget.ref == 'Himself') {
        radioPicked = RadioOptions.male;
      } else if (widget.nom == 'She' &&
          widget.acc == 'Her' &&
          widget.gen == 'Her' &&
          widget.ref == 'Herself') {
        radioPicked = RadioOptions.female;
      } else if (widget.nom == 'They' &&
          widget.acc == 'Them' &&
          widget.gen == 'Their' &&
          widget.ref == 'Themself') {
        radioPicked = RadioOptions.nonbinary;
      } else {
        radioPicked = RadioOptions.custom;
        checkEnabled = true;
      }
    }

    updateDropDown();

    const Divider myDiv = Divider(
      color: Colors.black,
      thickness: 1,
      indent: 15,
      endIndent: 15,
    );

    String? labelDecide(int choice) {
      switch (choice) {
        case 0: //Nominative
          if (radioPicked == RadioOptions.male) {
            return 'He';
          } else if (radioPicked == RadioOptions.female) {
            return 'She';
          } else if (radioPicked == RadioOptions.nonbinary) {
            return 'They';
          }
          break;
        case 1: //Accusative
          if (radioPicked == RadioOptions.male) {
            return 'Him';
          } else if (radioPicked == RadioOptions.female) {
            return 'Her';
          } else if (radioPicked == RadioOptions.nonbinary) {
            return 'Them';
          }
          break;
        case 2: //Genitive
          if (radioPicked == RadioOptions.male) {
            return 'His';
          } else if (radioPicked == RadioOptions.female) {
            return 'Her';
          } else if (radioPicked == RadioOptions.nonbinary) {
            return 'Their';
          }
          break;
        case 3: //Reflexive
          if (radioPicked == RadioOptions.male) {
            return 'Himself';
          } else if (radioPicked == RadioOptions.female) {
            return 'Herself';
          } else if (radioPicked == RadioOptions.nonbinary) {
            return 'Themselves';
          }
          break;
      }
      return null;
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
                    controller: TextEditingController(text: labelDecide(0)),
                    onSubmitted: (value) {
                      nomSettings = value;
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
                    controller: TextEditingController(text: labelDecide(1)),
                    onSubmitted: (value) {
                      accSettings = value;
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
                    controller: TextEditingController(text: labelDecide(2)),
                    onSubmitted: (value) {
                      genSettings = value;
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
                    controller: TextEditingController(text: labelDecide(3)),
                    onSubmitted: (value) {
                      refSettings = value;
                    },
                  ),
                )
              ],
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
