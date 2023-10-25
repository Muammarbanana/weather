import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import 'shared_preference_manager.dart';

class GeolocatorManager {
  late LocationSettings locationSettings;

  GeolocatorManager() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        //(Optional) Set foreground notification config to keep the app alive
        //when going to the background
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
              "Example app will continue to receive your location even when you aren't using it",
          notificationTitle: "Running in Background",
          enableWakeLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }
  }

  Future<bool> _isPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    bool isPermissionGranted = await _isPermissionGranted();
    if (!isPermissionGranted) {
      return Future.error('Location permissions are denied');
    }

    final location = await Geolocator.getCurrentPosition();
    final pref = SharedPreferencesManager();
    log("location : $location");
    pref.putString(SharedPreferencesManager.lat, "${location.latitude}");
    pref.putString(SharedPreferencesManager.lng, "${location.longitude}");

    return location;
  }

  Stream<Position> determinePositionStream() async* {
    bool isPermissionGranted = await _isPermissionGranted();
    if (!isPermissionGranted) {
      yield* Stream.error('Location permissions are denied');
    }
    yield* Geolocator.getPositionStream(
      locationSettings: locationSettings,
    );
  }
}
