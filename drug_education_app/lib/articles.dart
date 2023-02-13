import 'package:flutter/material.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyCustomForm(),
    );
  }
}

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
        Column(
          children: [
            buildArticleCard(),
            buildArticleCard(),
            buildArticleCard(),
            buildArticleCard(),
          ],
        ),
      ],
    );
  }

  Widget buildArticleCard() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
            child: Text(
              'Article Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Text(
              'Article Description',
            ),
          )
        ],
      ),
    );
  }
}
