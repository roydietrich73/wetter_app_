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
  String city = 'Stuttgart';
  double temperature = -4.0;
  double feelsLike = -10.0;
  double precipitation = 15.0;
  String timeOfDay = 'Tag';
  double latitude = 48.783;
  double longitude = 9.183;

  void updateForecast() {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vorhersage update'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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