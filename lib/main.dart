// ignore_for_file: use_key_in_widget_constructors

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

  void updateForecast() {
   
    String jsonString = '''
    {
      "city": "Stuttgart",
      "temperature": -4.0,
      "feelsLike": -10.0,
      "precipitation": 15.0,
      "timeOfDay": "Tag",
      "latitude": 48.783,
      "longitude": 9.183
    }
    ''';

    Map<String, dynamic> weatherData = json.decode(jsonString);

    setState(() {
      city = weatherData['city'];
      temperature = weatherData['temperature'];
      feelsLike = weatherData['feelsLike'];
      precipitation = weatherData['precipitation'];
      timeOfDay = weatherData['timeOfDay'];
      latitude = weatherData['latitude'];
      longitude = weatherData['longitude'];
    });
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