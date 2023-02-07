//LIST OF ALL ICONS: https://api.flutter.dev/flutter/material/Icons-class.html

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // referenced https://docs.flutter.dev/cookbook/design/fonts for tutorial on using custom fonts
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drug Education App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'RobotoSlab'),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// referenced https://www.youtube.com/watch?v=4pi7CApy4wc for tutorial on GridView
// referenced https://docs.flutter.dev/development/ui/layout for adding margins and images to Containers
class _MyHomePageState extends State<MyHomePage> {
  int mySelectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      mySelectedIndex = index;
    });
  }

  //referenced https://github.com/flutter/codelabs/blob/main/namer/step_08/lib/main.dart and https://codelabs.developers.google.com/codelabs/flutter-codelab-first#6 for switching pages
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (mySelectedIndex) {
      case 0:
        page = Placeholder();
        break;
      case 1:
        page = HomePage();
        break;
      case 2:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $mySelectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        // referenced https://api.flutter.dev/flutter/material/AppBar-class.html for customizing appbar
        appBar: AppBar(
          // look into this website for app bar hotline information: https://www.samhsa.gov/find-help/national-helpline
          title: const Text(
            "Drug Education",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),

          backgroundColor: const Color.fromARGB(255, 150, 173, 227),
          shadowColor: const Color.fromARGB(255, 150, 173, 227),
          toolbarOpacity: 0.75,
        ),

        body: Row(
          children: [
            Expanded(
              child: Container(
                child: page,
              ),
            ),
          ],
        ),
        //referenced https://www.javatpoint.com/flutter-bottom-navigation-bar#:~:text=In%20Flutter%20application%2C%20we%20usually and https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html for creating bottom navigation bar
        bottomNavigationBar: BottomNavigationBar(
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
          currentIndex: mySelectedIndex,
          backgroundColor: const Color.fromARGB(255, 174, 221, 227),
          onTap: _onItemTapped,
        ),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        children: [
          Container(
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
          Container(
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
          Container(
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
          Container(
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
        ],
      ),
    );
  }
}
