class recomment {
  String? accuracy;
  String? prediction;

  recomment({this.accuracy, this.prediction});

  recomment.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    prediction = json['prediction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    data['prediction'] = this.prediction;
    return data;
  }
}
