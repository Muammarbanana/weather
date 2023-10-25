import 'package:dartz/dartz.dart';
import 'package:weatherapp/features/data/models/weather/weather_response.dart';
import 'package:weatherapp/features/domain/repositories/weather/weather_repository.dart';

import '../../../core/errors/failure.dart';
import '../../../core/use_case/use_case.dart';

class GetWeathers implements UseCase<WeatherResponse, NoParams> {
  final WeatherRepository repository;

  GetWeathers({required this.repository});

  @override
  Future<Either<Failure, WeatherResponse>> call(NoParams params) async {
    return repository.getWeathers();
  }
}
