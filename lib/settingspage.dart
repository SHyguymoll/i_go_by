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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = '';
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
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        if (dropdownValue == 'Male') {}
                      });
                    }),
              ],
            ),
            Divider(color: Colors.black),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Divider(color: Colors.black),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
              ),
              onPressed: () {
                Navigator.pop(context, [
                  widget.nom,
                  widget.acc,
                  widget.gen,
                  widget.ref,
                ]);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
