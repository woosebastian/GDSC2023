// creating object files for use with firestore: https://www.youtube.com/watch?v=R015EukCnYI&t=1018s

import 'package:cloud_firestore/cloud_firestore.dart';

class Substance {
  String? name;
  String? overdoseRate;
  String? description;
  List<String>? symptoms;

  Substance({
    this.name,
    this.overdoseRate,
    this.description,
    this.symptoms,
  });

  factory Substance.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Substance(
      name: data?['name'],
      overdoseRate: data?['overdose rate'],
      description: data?['description'],
      symptoms:
          data?['symptoms'] is Iterable ? List.from(data?['symptoms']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (overdoseRate != null) "overdose rate": overdoseRate,
      if (description != null) "description": description,
      if (symptoms != null) "symptoms": symptoms,
    };
  }
}
