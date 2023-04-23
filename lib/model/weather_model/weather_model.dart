import 'dart:ffi';

class WeatherData {
  String? outlook;
  double? temperature;

  WeatherData({this.outlook, this.temperature});

  WeatherData.fromJson(Map<String, dynamic> json) {
    outlook = json['outlook'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outlook'] = this.outlook;
    data['temperature'] = this.temperature;
    return data;
  }
}
