import 'package:cloud_firestore/cloud_firestore.dart';
import 'substance.dart';

class SubstanceService {
  FirebaseFirestore? _instance;

  final List<Substance> _substance = [];

  List<Substance> getSubstances() {
    return _substance;
  }

  Future<void> getSubstanceCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;

    CollectionReference substances = _instance!.collection("substances");

    DocumentSnapshot snapshot = await substances.doc("substanceb").get();
    var data = snapshot.data() as Map;
    var substanceaData = data['substanceb'] as List<dynamic>;

    for (var subData in substanceaData) {
      _substance.add(Substance.fromJson(subData));
    }
  }
}
