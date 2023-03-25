class Substance {
  String? name;
  int? overdoseRate;
  String? description;
  List<String>? symptoms;

  Substance({this.name, this.overdoseRate, this.description, this.symptoms});

  factory Substance.fromJson(Map<String, dynamic> json) {
    return Substance(
      name: json['name'],
      overdoseRate: json['overdose rate'],
      description: json['description'],
      symptoms: json['symptoms'],
    );
  }
}
