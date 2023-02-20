import 'package:flutter/material.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  //Orientation Builder: https://medium.flutterdevs.com/screen-orientation-in-flutter-96526f2c1e7f
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return const MyCustomForm();
      } else {
        return const LandscapeArticlesPage();
      }
    })
        // body: MyCustomForm(),
        );
  }
}

//search bar + rest of the home page
class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            child: TextField(
              cursorColor: Color.fromARGB(255, 150, 173, 227),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 174, 221, 227), width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 150, 173, 227), width: 3)),
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term'),
            )),
        SizedBox(
            height: 600,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildArticleCard(),
                  buildArticleCard(),
                  buildArticleCard(),
                  buildArticleCard(),
                  buildArticleCard(),
                  buildArticleCard(),
                  buildArticleCard(),
                ],
              ),
            ))
      ],
    );
  }

  Widget buildArticleCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      width: 800,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(3, 3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          //ARTICLE TITLE
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 10,
              bottom: 5,
            ),
            child: Text(
              'Article Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //ARTICLE DESCRIPTION
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              bottom: 10,
            ),
            child: SizedBox(
              height: 50,
              width: 180,
              child: SingleChildScrollView(
                //Adding a scrollbar to handle overflow text: https://stackoverflow.com/questions/55515671/make-scrollable-text-inside-container-in-flutter
                child: Text(
                    'Article Description: Insert Description here. Some more text to check if the description is working'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LandscapeArticlesPage extends StatelessWidget {
  const LandscapeArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
