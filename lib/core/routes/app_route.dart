import 'package:flutter/material.dart';
import 'package:weatherapp/features/presentation/ui/authentication/pages/login_page.dart';
import 'package:weatherapp/features/presentation/ui/authentication/pages/register_page.dart';
import 'package:weatherapp/features/presentation/ui/weather_info/pages/weather_details_page.dart';
import 'package:weatherapp/main.dart';

import '../../features/data/models/weather/weather_response.dart';
import '../../features/presentation/ui/weather_info/pages/weather_page.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyApp.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const MyApp(),
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LoginPage(),
        );
      case RegisterPage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const RegisterPage(),
        );
      case WeatherPage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const WeatherPage(),
        );
      case WeatherDetailsPage.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        final DateTime weatherDateTime = arguments['weatherDateTime'];
        final ListElement weatherItemData = arguments['weatherItemData'];
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => WeatherDetailsPage(
            weatherDate: weatherDateTime,
            weatherItemData: weatherItemData,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(
                'Page not found',
              ),
            ),
          ),
        );
    }
  }
}
