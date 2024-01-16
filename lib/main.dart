
// ignore_for_file: unused_import

import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyWeatherApp());
}
 
class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wetter App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wetter - App'),
        ),
        body: WeatherDetails(),
      ),
    );
  }
}

class WeatherDetails extends StatefulWidget {
  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  String city = '';
  double temperature = 0.0;
  double feelsLike = 0.0;
  double precipitation = 0.0;
  String timeOfDay = '';
  double latitude = 0.0;
  double longitude = 0.0;
  
  get http => null;

  Future<String> fetchWeatherData() async {
    const url =
        'https://api.open-meteo.com/v1/forecast?latitude=48.783333&longitude=9.183333&current=temperature_2m,apparent_temperature,is_day,precipitation&timezone=Europe%2FBerlin&forecast_days=1';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  void updateForecast() async {
    try {
      String jsonString = await fetchWeatherData();
      Map<String, dynamic> weatherData = json.decode(jsonString);

      setState(() {
        city = 'Stuttgart'; // Stadt kann direkt aus dem JSON-Objekt genommen werden, falls verfügbar
        temperature = weatherData['current']['temperature_2m'];
        feelsLike = weatherData['current']['apparent_temperature'];
        precipitation = weatherData['current']['precipitation'];
        timeOfDay = weatherData['current']['is_day'] ? 'Tag' : 'Nacht';
        latitude = weatherData['latitude'];
        longitude = weatherData['longitude'];
      });
    } catch (e) {
      print('Fehler beim Abrufen der Wetterdaten: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Temperatur: ${temperature}°C (Gefühlte Temperatur: ${feelsLike}°C)'),
          Text('Niederschlag: ${precipitation} mm'),
          Text('Tageszeit: $timeOfDay'),
          Text('Standort: Lat $latitude, Long $longitude'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: updateForecast,
            child: const Text('Vorhersage updaten'),
          ),
        ],
      ),
    );
  }
}