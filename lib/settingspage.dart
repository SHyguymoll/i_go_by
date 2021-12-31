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

    void updateTextFields() {
      if (nomSettings == 'He' &&
              accSettings == 'Him' &&
              genSettings == 'His' &&
              refSettings == 'Himself' ||
          nomSettings == 'She' &&
              accSettings == 'Her' &&
              genSettings == 'Her' &&
              refSettings == 'Herself' ||
          nomSettings == 'They' &&
              accSettings == 'Them' &&
              genSettings == 'Their' &&
              refSettings == 'Themself') {
        checkEnabled = false;
      } else {
        checkEnabled = true;
      }
    }

    updateTextFields();

    const Divider myDiv = Divider(
      color: Colors.black,
      thickness: 1,
      indent: 15,
      endIndent: 15,
    );

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
                    nomSettings = 'He';
                    accSettings = 'Him';
                    genSettings = 'His';
                    refSettings = 'Himself';
                  });
                }),
            RadioListTile<RadioOptions>(
                title: const Text("Female"),
                value: RadioOptions.female,
                groupValue: radioPicked,
                onChanged: (RadioOptions? value) {
                  setState(() {
                    radioPicked = value;
                    nomSettings = 'She';
                    accSettings = 'Her';
                    genSettings = 'Her';
                    refSettings = 'Herself';
                  });
                }),
            RadioListTile<RadioOptions>(
                title: const Text("Nonbinary"),
                value: RadioOptions.nonbinary,
                groupValue: radioPicked,
                onChanged: (RadioOptions? value) {
                  setState(() {
                    radioPicked = value;
                    nomSettings = 'They';
                    accSettings = 'Them';
                    genSettings = 'Their';
                    refSettings = 'Themself';
                  });
                }),
            RadioListTile<RadioOptions>(
                title: const Text("Custom"),
                value: RadioOptions.custom,
                groupValue: radioPicked,
                onChanged: (RadioOptions? value) {
                  setState(() {
                    radioPicked = value;
                    nomSettings = '';
                    accSettings = '';
                    genSettings = '';
                    refSettings = '';
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
                    controller: TextEditingController(text: accSettings),
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
                    controller: TextEditingController(text: genSettings),
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
                    controller: TextEditingController(text: refSettings),
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
