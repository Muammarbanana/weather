import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherapp/core/use_case/use_case.dart';
import 'package:weatherapp/features/data/models/weather/weather_response.dart';
import 'package:weatherapp/features/domain/usecases/get_weathers.dart';

import '../../helper/mock_helper.mocks.dart';

void main() {
  late GetWeathers getWeathers;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeathers = GetWeathers(repository: mockWeatherRepository);
  });

  test(
    'make sure getBookmark sucessful receive response from endpoint',
    () async {
      // arrange
      const tResponse = WeatherResponse();
      when(mockWeatherRepository.getWeathers()).thenAnswer(
        (_) async => const Right(tResponse),
      );

      // act
      final result = await getWeathers(NoParams());

      // assert
      expect(result, const Right(tResponse));
      verify(mockWeatherRepository.getWeathers());
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
