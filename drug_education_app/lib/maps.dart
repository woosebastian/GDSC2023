import 'package:flutter/material.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    //responsive widgets: https://codelabs.developers.google.com/codelabs/flutter-codelab-first#6, https://github.com/flutter/codelabs/blob/main/namer/step_08/lib/main.dart, and https://docs.flutter.dev/cookbook/design/orientation
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: OrientationBuilder(builder: (context, orientation) {
        return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
            children: [
              //using Align to resize Containers: https://stackoverflow.com/questions/54717748/why-flutter-container-does-not-respects-its-width-and-height-constraints-when-it
              SafeArea(
                  child: Align(
                      child: Container(
                          // constraints: BoxConstraints.expand({300, 300}),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10)))),
              Expanded(
                  child: Align(
                      child: Container(
                          // constraints: BoxConstraints.expand(300, 100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10)))),
            ]);
      }),
    );
  }
}
