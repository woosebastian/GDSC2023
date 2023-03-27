//LIST OF ALL ICONS: https://api.flutter.dev/flutter/material/Icons-class.html
//connecting Flutter to Firebase: https://www.youtube.com/watch?v=ok6se5sOthw, https://www.youtube.com/watch?v=EXp0gq9kGxI&t=9s, https://firebase.flutter.dev/docs/overview/#initialization

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'articles.dart';
import 'maps.dart';
import 'substance.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({super.key});

  @override
  //custom fonts: https://docs.flutter.dev/cookbook/design/fonts
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Drug Education App',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'RobotoSlab'),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong!');
            } else if (snapshot.hasData) {
              return const MyHomePage();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Navigating between pages + Bottom Nav bar: https://www.youtube.com/watch?v=18PVdmBOEQM
  int mySelectedIndex = 1;
  final List<Widget> _children = [
    const Maps(),
    const HomePage(),
    const Articles(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      mySelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        //customizing AppBar: https://api.flutter.dev/flutter/material/AppBar-class.html
        appBar: AppBar(
          title: const Text(
            "Drug Education",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          backgroundColor: const Color.fromARGB(255, 150, 173, 227),
          shadowColor: const Color.fromARGB(255, 150, 173, 227),
          toolbarOpacity: 0.75,
        ),
        body: _children[mySelectedIndex],
        //creating floating button: https://androidride.com/flutter-bottom-button/
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Hotline()),
            );
          },
          tooltip: "Call",
          child: const Icon(
            Icons.phone,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        //creating Bottom Navigation Bar: https://www.javatpoint.com/flutter-bottom-navigation-bar#:~:text=In%20Flutter%20application%2C%20we%20usually and https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mySelectedIndex,
          backgroundColor: const Color.fromARGB(255, 174, 221, 227),
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_sharp),
              label: 'Articles & Blogs',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      //GridView: https://www.youtube.com/watch?v=4pi7CApy4wc
      child: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            //changing grid layout depending on orientation: https://docs.flutter.dev/cookbook/design/orientation
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              //clickability for GridView items: https://stackoverflow.com/questions/71249312/how-do-i-get-dart-flutter-gridview-items-to-click
              //adding margins and images to Containers: https://docs.flutter.dev/development/ui/layout
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  margin: const EdgeInsets.all(4),
                  // for adding images to each grid element
                  // child: Image.asset('images/pic$imageIndex.jpg'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Substance A",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  getData("substanceb");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubstancePage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  margin: const EdgeInsets.all(4),
                  // for adding images to each grid element
                  // child: Image.asset('images/pic$imageIndex.jpg'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Substance B",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  margin: const EdgeInsets.all(4),
                  // for adding images to each grid element
                  // child: Image.asset('images/pic$imageIndex.jpg'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Substance C",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  margin: const EdgeInsets.all(4),
                  // for adding images to each grid element
                  // child: Image.asset('images/pic$imageIndex.jpg'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Substance D",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

//navigating to new page: https://docs.flutter.dev/cookbook/navigation/navigation-basics
class Hotline extends StatelessWidget {
  const Hotline({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Center(
          //changing pages depending on orientation: https://www.youtube.com/watch?v=_PR6C1kGbp8
          child: deviceOrientation == Orientation.portrait
              ? const HotlinePortrait()
              : const HotlineLandscape()),
    );
  }
}

class HotlinePortrait extends StatelessWidget {
  const HotlinePortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SizedBox: https://github.com/flutter/codelabs/blob/main/namer/step_08/lib/main.dart
        const Padding(
          padding: EdgeInsets.fromLTRB(20.0, 200, 20.0, 10),
          //Text styling: https://api.flutter.dev/flutter/painting/TextStyle-class.html and https://stackoverflow.com/questions/50554110/how-do-i-center-text-vertically-and-horizontally-in-flutter
          child: Text(
            "Substance Abuse and Mental Health Services Administration: \n 1-800-662-HELP (4357)",
            style: TextStyle(
                fontWeight: FontWeight.bold, height: 1.5, fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          //IconButton: https://www.javatpoint.com/flutter-buttons
          //navigating to URL: https://www.youtube.com/watch?v=nf4_Ke5B1K8 and https://stackoverflow.com/questions/66473263/the-argument-type-string-cant-be-assigned-to-the-parameter-type-uri
          padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 100),
          child: IconButton(
            onPressed: () {
              urllauncher.launchUrl(Uri.parse("tel:1-800-662-4357"));
            },
            icon: const Icon(Icons.phone),
            iconSize: 40,
            color: Colors.green,
            tooltip: "Call SAMHSA",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Return'),
        ),
      ],
    );
  }
}

class HotlineLandscape extends StatelessWidget {
  const HotlineLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SizedBox: https://github.com/flutter/codelabs/blob/main/namer/step_08/lib/main.dart
        const Padding(
          padding: EdgeInsets.fromLTRB(60, 60, 20, 20),
          //Text styling: https://api.flutter.dev/flutter/painting/TextStyle-class.html and https://stackoverflow.com/questions/50554110/how-do-i-center-text-vertically-and-horizontally-in-flutter
          child: Text(
            "Substance Abuse and Mental Health Services Administration: \n 1-800-662-HELP (4357)",
            style: TextStyle(
                fontWeight: FontWeight.bold, height: 1.5, fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          //IconButton: https://www.javatpoint.com/flutter-buttons
          //navigating to URL: https://www.youtube.com/watch?v=nf4_Ke5B1K8 and https://stackoverflow.com/questions/66473263/the-argument-type-string-cant-be-assigned-to-the-parameter-type-uri
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: IconButton(
            onPressed: () {
              urllauncher.launchUrl(Uri.parse("tel:1-800-662-4357"));
            },
            icon: const Icon(Icons.phone),
            iconSize: 40,
            color: Colors.green,
            tooltip: "Call SAMHSA",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Return'),
        ),
      ],
    );
  }
}

Substance substance = Substance();

//returning an object from firestore database: https://github.com/firebase/snippets-flutter/blob/36812ac93095d36ebe10bed2f08793e5f7dfcb06/packages/firebase_snippets_app/lib/snippets/firestore.dart#L412-L419
//accessing the returned object from a future: https://meysam-mahfouzi.medium.com/understanding-future-in-dart-3c3eea5a22fb
var db = FirebaseFirestore.instance;
getData(id) async {
  final ref = db.collection("substances").doc(id).withConverter(
        fromFirestore: Substance.fromFirestore,
        toFirestore: (Substance substance, _) => substance.toFirestore(),
      );
  final docSnap = await ref.get();
  final mySubstance = docSnap.data();
  if (mySubstance != null) {
    substance = mySubstance;
  }
  // else {
  //   throw ErrorDescription("no substance found");
  // }
}

class SubstancePage extends StatelessWidget {
  const SubstancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Center(
          //changing pages depending on orientation: https://www.youtube.com/watch?v=_PR6C1kGbp8
          child: deviceOrientation == Orientation.portrait
              ? const SubstancePagePortrait()
              : const SubstancePageLandscape()),
    );
  }
}

class SubstancePagePortrait extends StatelessWidget {
  const SubstancePagePortrait({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(
          height: 60,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "${substance.name} Factsheet",
            style: const TextStyle(
                fontWeight: FontWeight.bold, height: 1.5, fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Text(
            "Overdose Rate: ${substance.overdoseRate}",
            style: const TextStyle(
                fontWeight: FontWeight.normal, height: 1, fontSize: 25),
            textAlign: TextAlign.left,
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: Text(
            "Description: ",
            style: TextStyle(
                fontWeight: FontWeight.normal, height: 1, fontSize: 25),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
          child: Flexible(
            child: Text(
              "${substance.description}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, height: 1, fontSize: 20),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: Text(
            "Symptoms:",
            style: TextStyle(
                fontWeight: FontWeight.normal, height: 1, fontSize: 25),
            textAlign: TextAlign.left,
          ),
        ),
        //create widget for each element in array: https://stackoverflow.com/questions/56026705/create-widget-for-each-item-in-the-list-in-flutter-dart
        Column(
          children: substance.symptoms!
              .map<Widget>(
                (symptom) => Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: Text(
                    "- $symptom",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, height: 1, fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
              .toList(),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Return'),
          ),
        )),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class SubstancePageLandscape extends StatelessWidget {
  const SubstancePageLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SizedBox: https://github.com/flutter/codelabs/blob/main/namer/step_08/lib/main.dart
        const Padding(
          padding: EdgeInsets.fromLTRB(60, 60, 20, 20),
          //Text styling: https://api.flutter.dev/flutter/painting/TextStyle-class.html and https://stackoverflow.com/questions/50554110/how-do-i-center-text-vertically-and-horizontally-in-flutter
          child: Text(
            "Substance Abuse and Mental Health Services Administration: \n 1-800-662-HELP (4357)",
            style: TextStyle(
                fontWeight: FontWeight.bold, height: 1.5, fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          //IconButton: https://www.javatpoint.com/flutter-buttons
          //navigating to URL: https://www.youtube.com/watch?v=nf4_Ke5B1K8 and https://stackoverflow.com/questions/66473263/the-argument-type-string-cant-be-assigned-to-the-parameter-type-uri
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: IconButton(
            onPressed: () {
              urllauncher.launchUrl(Uri.parse("tel:1-800-662-4357"));
            },
            icon: const Icon(Icons.phone),
            iconSize: 40,
            color: Colors.green,
            tooltip: "Call SAMHSA",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Return'),
        ),
      ],
    );
  }
}
