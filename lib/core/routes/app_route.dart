import 'package:flutter/material.dart';
import 'package:weatherapp/features/presentation/ui/authentication/pages/login_page.dart';
import 'package:weatherapp/features/presentation/ui/authentication/pages/register_page.dart';
import 'package:weatherapp/main.dart';

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
