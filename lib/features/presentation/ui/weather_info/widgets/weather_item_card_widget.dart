import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/core/theme/text_style_manager.dart';

import '../../../../data/models/weather/weather_response.dart';

class WeatherItemCardWidget extends StatelessWidget {
  final ListElement weatherItemData;
  const WeatherItemCardWidget({
    super.key,
    required this.weatherItemData,
  });

  @override
  Widget build(BuildContext context) {
    String generateDate() {
      var dt = DateTime.fromMillisecondsSinceEpoch(
          (int.tryParse(weatherItemData.dt.toString()) ?? 0) * 1000);
      // 12 Hour format:
      return DateFormat('EE, MMM dd, yyyy hh:mm a').format(dt);
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://openweathermap.org/img/wn/${weatherItemData.weather?[0].icon}@2x.png',
                height: 100,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      generateDate(),
                      style: TextStyleManager.mediumText(
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      weatherItemData.weather?[0].main ?? '',
                      style: TextStyleManager.mediumText(),
                    ),
                    Text(
                      'Temp: ${weatherItemData.main?.temp ?? ''}°C',
                      style: TextStyleManager.mediumText(),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
