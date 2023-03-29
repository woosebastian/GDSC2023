import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'article.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;

Map<String, Article> articleMap = <String, Article>{};

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  var db = FirebaseFirestore.instance;
  Future<void> getAllData() async {
    final collection =
        FirebaseFirestore.instance.collection('articles').withConverter(
              fromFirestore: Article.fromFirestore,
              toFirestore: (Article article, _) => article.toFirestore(),
            );
    await collection.get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        articleMap[docSnapshot.id] = docSnapshot.data();
      }
    });
  }

  //initState(): https://www.geeksforgeeks.org/flutter-initstate/
  @override
  void initState() {
    getAllData();
    super.initState();
  }

  //Orientation Builder: https://medium.flutterdevs.com/screen-orientation-in-flutter-96526f2c1e7f
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              body: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return const ArticlesPagePortrait();
            } else {
              return const ArticlesPageLandscape();
            }
          }));
        } else {
          return const Align(
              alignment: Alignment.center, child: CircularProgressIndicator());
        }
      },
    );
  }
}

//search bar + rest of the home page
class ArticlesPagePortrait extends StatelessWidget {
  const ArticlesPagePortrait({super.key});

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

class ArticlesPageLandscape extends StatelessWidget {
  const ArticlesPageLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    // return Padding(
    // padding: const EdgeInsets.fromLTRB(70, 20, 70, 15),
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(58, 20, 58, 5),
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
        ),
      ),
      const SizedBox(height: 15),
      SizedBox(
          height: 180,
          //ListView: https://api.flutter.dev/flutter/widgets/ListView-class.html
          child: ListView.separated(
            itemCount: articleMap.length,
            separatorBuilder: (_, __) => const Divider(
              indent: 30,
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  urllauncher.launchUrl(
                      Uri.parse("${articleMap.values.elementAt(index).url}"));
                },
                child: Container(
                  width: 400,
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          bottom: 5,
                        ),
                        child: Text(
                          '${articleMap.values.elementAt(index).name}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          bottom: 5,
                        ),
                        child: Text(
                            '${articleMap.values.elementAt(index).author}, ${articleMap.values.elementAt(index).publisher} - ${articleMap.values.elementAt(index).date}'),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            bottom: 15,
                          ),
                          child: SingleChildScrollView(
                              child: Text(
                            '${articleMap.values.elementAt(index).url}',
                            style: const TextStyle(color: Colors.grey),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    ]
        // ),
        );
  }
}
