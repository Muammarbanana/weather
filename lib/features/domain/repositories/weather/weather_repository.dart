import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/errors/failure.dart';
import 'package:weatherapp/features/data/models/weather/weather_response.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherResponse>> getWeathers();
}
