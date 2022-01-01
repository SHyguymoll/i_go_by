import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  const Credits({Key? key}) : super(key: key);

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Text("Created by Solomon Mollet, for CS4750"),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 25),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    ));
  }
}
