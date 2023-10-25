import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/features/presentation/ui/weather_info/pages/weather_page.dart';

import 'core/routes/app_route.dart';
import 'core/services/geolocator_manager.dart';
import 'features/presentation/ui/authentication/pages/login_page.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  di.sl.allowReassignment = true;
  GeolocatorManager().determinePosition();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const routeName = '/';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.inter().fontFamily,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => AppRoute.generateRoute(settings),
      home: (FirebaseAuth.instance.currentUser != null)
          ? const WeatherPage()
          : const LoginPage(),
    );
  }
}
