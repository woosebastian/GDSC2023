import 'package:flutter/material.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
        body: Center(
            child: deviceOrientation == Orientation.portrait
                ? const MapsPortrait()
                : const MapsLandscape()));
  }
}

class MapsPortrait extends StatelessWidget {
  const MapsPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 5)),
      Container(
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 5)),
    ]);
  }
}

class MapsLandscape extends StatelessWidget {
  const MapsLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 525,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          margin: const EdgeInsets.fromLTRB(60, 20, 0, 20)),
      Container(
          width: 265,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          margin: const EdgeInsets.fromLTRB(20, 20, 5, 20)),
    ]);
  }
}
