import 'package:dio/dio.dart';
import 'package:weatherapp/features/data/models/weather/weather_response.dart';

import '../../../config/base_url_config.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherResponse> getWeathers();
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final Dio dio;
  WeatherRemoteDataSourceImpl({required this.dio});

  @override
  Future<WeatherResponse> getWeathers() async {
    const String path = 'http://api.openweathermap.org/data/2.5/forecast';
    final Response<dynamic> response = await dio.get(
      path,
      queryParameters: {"units": 'metric'},
      options: Options(
        extra: {
          BaseUrlConfig.requireAPIKey: true,
          BaseUrlConfig.requireLocation: true,
        },
      ),
    );
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(response.data);
    } else {
      throw DioException(requestOptions: RequestOptions(path: path));
    }
  }
}
