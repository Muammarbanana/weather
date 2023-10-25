import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:weatherapp/core/services/network_info.dart';
import 'package:weatherapp/features/data/datasources/wather_remote_data_sources.dart';
import 'package:weatherapp/features/domain/repositories/weather/weather_repository.dart';

@GenerateMocks([
  Dio,
  HttpClientAdapter,
  NetworkInfo,
  WeatherRemoteDataSource,
  WeatherRepository,
])
void main() {}
