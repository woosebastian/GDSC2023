// creating object files for use with firestore: https://www.youtube.com/watch?v=R015EukCnYI&t=1018s

import 'package:cloud_firestore/cloud_firestore.dart';

class Substance {
  String? name;
  String? description;
  List<String>? symptoms;
  List<String>? treatmentOptions;

  Substance({
    this.name,
    this.description,
    this.symptoms,
    this.treatmentOptions,
  });

  factory Substance.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Substance(
      name: data?['name'],
      description: data?['description'],
      symptoms:
          data?['symptoms'] is Iterable ? List.from(data?['symptoms']) : null,
      treatmentOptions: data?['treatment options'] is Iterable
          ? List.from(data?['treatment options'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (description != null) "description": description,
      if (symptoms != null) "symptoms": symptoms,
      if (treatmentOptions != null) "treatment options": treatmentOptions,
    };
  }
}
