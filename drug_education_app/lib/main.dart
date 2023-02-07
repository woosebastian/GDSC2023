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
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text('Map Page'),
  //   Text('Home Page'),
  //   Text('Profile Page'),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      mySelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // referenced https://api.flutter.dev/flutter/material/AppBar-class.html for customizing appbar
      appBar: AppBar(
        // look into this website for app bar hotline information: https://www.samhsa.gov/find-help/national-helpline
        title: const Text(
          "Hotline",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),

        backgroundColor: const Color.fromARGB(255, 142, 163, 212),
        shadowColor: Colors.teal,
        toolbarOpacity: 0.5,
      ),

      body: Padding(
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
      ),
      //referenced https://www.javatpoint.com/flutter-bottom-navigation-bar#:~:text=In%20Flutter%20application%2C%20we%20usually for creating bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Map',
              backgroundColor: Color.fromARGB(255, 142, 163, 212)),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 142, 163, 212)),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_sharp),
              label: 'Articles & Blogs',
              backgroundColor: Color.fromARGB(255, 142, 163, 212)),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: mySelectedIndex,
        selectedItemColor: const Color.fromARGB(255, 5, 76, 109),
        onTap: _onItemTapped,
      ),
    );
  }
}
