import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/weather_model/weather_model.dart';
import '../api.dart';

mixin WeatherApi on BaseApi{
  Future<WeatherData> fetchWeatherData(latitude,longitude) async {
    final apiKey = '122c90b2819c96e36576a933533e85fd';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final outlook = json['weather'][0]['main'] ?? 'Unknown outlook';
      final temperature = json['main']['temp']?.toDouble() ?? 0.0;
      return WeatherData(outlook: outlook, temperature: temperature);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
