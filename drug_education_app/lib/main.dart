//LIST OF ALL ICONS: https://api.flutter.dev/flutter/material/Icons-class.html

import 'package:flutter/material.dart';
import 'articles.dart';
import 'maps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  //custom fonts: https://docs.flutter.dev/cookbook/design/fonts
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

class _MyHomePageState extends State<MyHomePage> {
  //Navigating between pages + Bottom Nav bar: https://www.youtube.com/watch?v=18PVdmBOEQM
  int mySelectedIndex = 0;
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
          //app bar hotline information: https://www.samhsa.gov/find-help/national-helpline
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
          onPressed: () {},
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
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
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
      ),
    );
  }
}
