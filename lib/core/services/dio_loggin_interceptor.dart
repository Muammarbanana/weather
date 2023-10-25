import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/base_url_config.dart';
import '../constant/static_value.dart';
import 'shared_preference_manager.dart';

class DioLoggingInterceptor extends InterceptorsWrapper {
  final SharedPreferencesManager _sharedPreferencesManager;

  DioLoggingInterceptor(this._sharedPreferencesManager);

  var isRefreshTokenProcessing = false;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log(options.contentType.toString());

    debugPrint(
        '--> ${options.method.toUpperCase()} ${options.baseUrl + options.path}');

    if (options.extra.containsKey(BaseUrlConfig.requireAPIKey)) {
      var apiKey = 'af20ccf785600018471c806a043e5154';
      options.extra.remove(BaseUrlConfig.requireAPIKey);
      options.queryParameters['appid'] = apiKey;
    }

    if (options.extra.containsKey(BaseUrlConfig.requireLocation)) {
      String lat = _sharedPreferencesManager.getString(
          SharedPreferencesManager.lat,
          defaultValue: DefaultLocation.latitude);
      String lon = _sharedPreferencesManager.getString(
          SharedPreferencesManager.lon,
          defaultValue: DefaultLocation.longitude);

      options.extra.remove(BaseUrlConfig.requireLocation);

      options.queryParameters['lat'] = lat;
      options.queryParameters['lon'] = lon;
    }
    options.headers.addAll({'Accept': 'application/json'});

    log("options : ${options.data}");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('<-- ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}');
    handler.next(response);
  }
}
