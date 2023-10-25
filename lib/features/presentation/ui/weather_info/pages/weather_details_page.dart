import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/features/data/models/weather/weather_response.dart';

import '../../../../../core/theme/text_style_manager.dart';

class WeatherDetailsPage extends StatelessWidget {
  static const routeName = '/weather-details-page';
  final DateTime weatherDate;
  final ListElement weatherItemData;
  const WeatherDetailsPage({
    super.key,
    required this.weatherDate,
    required this.weatherItemData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        title: Text(
          'Weather Details',
          style: TextStyleManager.header2Text(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              DateFormat('EE, MMM dd, yyyy').format(weatherDate),
              style: TextStyleManager.headerText(fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat('hh:mm a').format(weatherDate),
              style: TextStyleManager.header2Text(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: CachedNetworkImage(
                imageUrl:
                    'https://openweathermap.org/img/wn/${weatherItemData.weather?[0].icon}@2x.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Text(
              '${weatherItemData.main?.temp}°C',
              style: TextStyleManager.headerText(fontSize: 32),
            ),
            const SizedBox(height: 20),
            Text(
              '${weatherItemData.weather?[0].main} (${weatherItemData.weather?[0].description})',
              style: TextStyleManager.header2Text(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Temp (min)',
                      style: TextStyleManager.header2Text(),
                    ),
                    Text(
                      '${weatherItemData.main?.tempMin}°C',
                      style: TextStyleManager.header2Text(
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Temp (max)',
                      style: TextStyleManager.header2Text(),
                    ),
                    Text(
                      '${weatherItemData.main?.tempMax}°C',
                      style: TextStyleManager.header2Text(
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
