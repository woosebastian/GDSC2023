import 'package:flutter/material.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    //responsive widgets: https://codelabs.developers.google.com/codelabs/flutter-codelab-first#6 and https://github.com/flutter/codelabs/blob/main/namer/step_08/lib/main.dart
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
          child: Column(children: [
        SafeArea(
            child: Container(
                constraints: const BoxConstraints.expand(height: 400),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 10))),
        Expanded(
            child: Container(
                constraints: const BoxConstraints.expand(height: 200),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10))),
      ])),
    );
  }
}
