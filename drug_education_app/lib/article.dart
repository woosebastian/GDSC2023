// creating object files for use with firestore: https://www.youtube.com/watch?v=R015EukCnYI&t=1018s and https://firebase.google.com/docs/firestore/query-data/get-data

import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String? name;
  String? author;
  String? date;
  String? publisher;
  String? url;

  Article({
    this.name,
    this.author,
    this.date,
    this.publisher,
    this.url,
  });

  factory Article.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Article(
      name: data?['name'],
      author: data?['author'],
      date: data?['date'],
      publisher: data?['publisher'],
      url: data?['url'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (author != null) "author": author,
      if (date != null) "date": date,
      if (publisher != null) "publisher": publisher,
      if (url != null) "url": url,
    };
  }
}
