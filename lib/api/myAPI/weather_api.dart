import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/weather_model/weather_model.dart';
import '../api.dart';

mixin WeatherApi on BaseApi{
  Future<WeatherData> fetchWeatherData(latitude,longitude,dateTime) async {
    final apiKey = '122c90b2819c96e36576a933533e85fd';
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${latitude}&lon=${longitude}&dt=$dateTime&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final forecastList = data['list'] as List<dynamic>;
      final int threshold = 7200;
      final forecast = forecastList.firstWhere((item) {
        final itemTimestamp = item['dt'] as int;
        final diff = (itemTimestamp - dateTime).abs();
        return diff <= threshold;
      }, orElse: () => null);


      final outlook = forecast['weather'][0]['main'];
      final temperature = forecast['main']['temp'].toDouble();
      return WeatherData(outlook: outlook, temperature: temperature);

    } else {
      print("lôi" + response.statusCode.toString());
      throw Exception('Failed to load weather data');
    }
  }
}
