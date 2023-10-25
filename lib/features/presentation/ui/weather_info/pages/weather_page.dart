import 'package:flutter/material.dart';
import 'package:weatherapp/core/theme/text_style_manager.dart';

class WeatherPage extends StatefulWidget {
  static const routeName = '/weather-page';
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyleManager.titleText(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: const Text('Halaman cuaca'),
    );
  }
}
