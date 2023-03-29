import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'article.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  late Future<List<Article>> articleList;
  List<Article> foundArticles = <Article>[];

  var db = FirebaseFirestore.instance;
  Future<List<Article>> getAllData() async {
    List<Article> myArticleList = <Article>[];
    final collection =
        FirebaseFirestore.instance.collection('articles').withConverter(
              fromFirestore: Article.fromFirestore,
              toFirestore: (Article article, _) => article.toFirestore(),
            );
    await collection.get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        myArticleList.add(docSnapshot.data());
      }
    });
    foundArticles = myArticleList;
    return myArticleList;
  }

  //initState(): https://www.geeksforgeeks.org/flutter-initstate/
  @override
  void initState() {
    articleList = getAllData();
    super.initState();
  }

  //filtering Firestore data: https://www.youtube.com/watch?v=pUV5v240po0
  void runFilter(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        articleList.then((newList) {
          foundArticles = newList;
        });
      } else {
        articleList.then((newList) {
          foundArticles = newList
              .where((article) =>
                  article.name!.toLowerCase().contains(keyword.toLowerCase()))
              .toList();
        });
      }
    });
  }

  //Orientation Builder: https://medium.flutterdevs.com/screen-orientation-in-flutter-96526f2c1e7f
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //using FutureBuilder with setState(): https://stackoverflow.com/questions/52021205/usage-of-futurebuilder-with-setstate
        future: articleList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                body: OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(58, 20, 58, 5),
                        child: TextField(
                          onChanged: (value) => runFilter(value),
                          cursorColor: const Color.fromARGB(255, 150, 173, 227),
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 174, 221, 227),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 150, 173, 227),
                                      width: 3)),
                              border: OutlineInputBorder(),
                              hintText: 'Enter a search term'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 313,
                        height: 600,
                        //ListView: https://api.flutter.dev/flutter/widgets/ListView-class.html
                        child: foundArticles.isNotEmpty
                            ? ListView.separated(
                                itemCount: foundArticles.length,
                                separatorBuilder: (_, __) => const Divider(
                                  height: 20,
                                ),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      urllauncher.launchUrl(Uri.parse(
                                          "${foundArticles[index].url}"));
                                    },
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(3, 3),
                                            )
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              top: 10,
                                              bottom: 5,
                                            ),
                                            child: Text(
                                              '${foundArticles[index].name}',
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
                                                '${foundArticles[index].author}, ${foundArticles[index].publisher} - ${foundArticles[index].date}'),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20,
                                                bottom: 15,
                                              ),
                                              child: SingleChildScrollView(
                                                  child: Text(
                                                '${foundArticles[index].url}',
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text("No articles found",
                                    style: TextStyle(fontSize: 24))),
                      ),
                    ]);
              } else {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(58, 20, 58, 5),
                        child: TextField(
                          //detecting changes to TextField: https://www.youtube.com/watch?v=pUV5v240po0
                          onChanged: (value) => runFilter(value),
                          cursorColor: const Color.fromARGB(255, 150, 173, 227),
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 174, 221, 227),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 150, 173, 227),
                                      width: 3)),
                              border: OutlineInputBorder(),
                              hintText: 'Enter a search term'),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 180,
                        //ListView: https://api.flutter.dev/flutter/widgets/ListView-class.html
                        child: foundArticles.isNotEmpty
                            ? ListView.separated(
                                itemCount: foundArticles.length,
                                separatorBuilder: (_, __) => const Divider(
                                  indent: 30,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      urllauncher.launchUrl(Uri.parse(
                                          "${foundArticles[index].url}"));
                                    },
                                    child: Container(
                                      width: 400,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(3, 3),
                                            )
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              top: 10,
                                              bottom: 5,
                                            ),
                                            child: Text(
                                              '${foundArticles[index].name}',
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
                                                '${foundArticles[index].author}, ${foundArticles[index].publisher} - ${foundArticles[index].date}'),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20,
                                                bottom: 15,
                                              ),
                                              child: SingleChildScrollView(
                                                  child: Text(
                                                '${foundArticles[index].url}',
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text("No articles found",
                                    style: TextStyle(fontSize: 24))),
                      ),
                    ]);
              }
            }));
          } else {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        });
  }
}
