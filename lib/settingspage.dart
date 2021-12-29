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

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String? dropdownValue;

    bool checkEnabled = false;

    String nomSettings = widget.nom;
    String accSettings = widget.acc;
    String genSettings = widget.gen;
    String refSettings = widget.ref;

    void updateDropDown() {
      if (widget.nom == 'He' &&
          widget.acc == 'Him' &&
          widget.gen == 'His' &&
          widget.ref == 'Himself') {
        dropdownValue = 'Male';
      } else if (widget.nom == 'She' &&
          widget.acc == 'Her' &&
          widget.gen == 'Her' &&
          widget.ref == 'Herself') {
        dropdownValue = 'Female';
      } else if (widget.nom == 'They' &&
          widget.acc == 'Them' &&
          widget.gen == 'Their' &&
          widget.ref == 'Themself') {
        dropdownValue = 'Nonbinary';
      } else {
        dropdownValue = 'Custom';
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
          if (dropdownValue == 'Male') {
            return 'He';
          } else if (dropdownValue == 'Female') {
            return 'She';
          } else if (dropdownValue == 'Nonbinary') {
            return 'They';
          }
          break;
        case 1: //Accusative
          if (dropdownValue == 'Male') {
            return 'Him';
          } else if (dropdownValue == 'Female') {
            return 'Her';
          } else if (dropdownValue == 'Nonbinary') {
            return 'Them';
          }
          break;
        case 2: //Genitive
          if (dropdownValue == 'Male') {
            return 'His';
          } else if (dropdownValue == 'Female') {
            return 'Her';
          } else if (dropdownValue == 'Nonbinary') {
            return 'Their';
          }
          break;
        case 3: //Reflexive
          if (dropdownValue == 'Male') {
            return 'Himself';
          } else if (dropdownValue == 'Female') {
            return 'Herself';
          } else if (dropdownValue == 'Nonbinary') {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text(
                  'Defaults',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                DropdownButton(
                  value: dropdownValue,
                  //I love API documentation
                  items: <String>['Male', 'Female', 'Nonbinary', 'Custom']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                      if (value == 'Male' ||
                          value == 'Female' ||
                          value == 'Nonbinary') {
                        checkEnabled = false;
                      } else {
                        checkEnabled = true;
                      }
                    });
                  },
                ),
              ],
            ),
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
