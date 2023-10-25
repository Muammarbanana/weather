import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weatherapp/features/data/datasources/wather_remote_data_sources.dart';
import 'package:weatherapp/features/domain/repositories/weather/weather_repository.dart';

import '../../../../core/errors/data_api_failure.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/helpers.dart';
import '../../../../core/services/network_info.dart';
import '../../models/weather/weather_response.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherResponse>> getWeathers() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getWeathers();
        return Right(response);
      } on DioException catch (error) {
        if (error.response == null) {
          return Left(
            ServerFailure(
              DataApiFailure(message: error.message),
            ),
          );
        }
        final errorResponseData = error.response?.data;
        dynamic errorData;
        String errorMessage = Helpers.getErrorMessageFromEndpoint(
          errorResponseData,
          error.message!,
          error.response?.statusCode ?? 400,
        );
        if (errorResponseData is Map &&
            errorResponseData.containsKey('errors')) {
          errorData = errorResponseData['errors'];
        }
        return Left(
          ServerFailure(
            DataApiFailure(
              message: errorMessage,
              statusCode: error.response?.statusCode,
              httpMessage: error.message,
              errorData: errorData,
            ),
          ),
        );
      } on TypeError catch (error) {
        return Left(ParsingFailure(error.toString()));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
