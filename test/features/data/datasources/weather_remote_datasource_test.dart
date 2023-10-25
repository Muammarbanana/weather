import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherapp/features/data/datasources/wather_remote_data_sources.dart';
import 'package:weatherapp/features/data/models/weather/weather_response.dart';

import '../../../fixture/fixture_reader.dart';
import '../../../helper/mock_helper.mocks.dart';

void main() {
  late WeatherRemoteDataSource remoteDataSource;
  late MockDio mockDio;
  late MockHttpClientAdapter mockDioAdapter;

  setUp(
    () {
      mockDio = MockDio();
      mockDioAdapter = MockHttpClientAdapter();
      mockDio.httpClientAdapter = mockDioAdapter;
      remoteDataSource = WeatherRemoteDataSourceImpl(dio: mockDio);
    },
  );

  final tRequestOptions = RequestOptions(path: '');

  group('getWeathers', () {
    final jsonMap = json.decode(fixture('weather_response.json'));
    final tResponse = WeatherResponse.fromJson(jsonMap);

    void setUpMockDioSuccess() {
      final responsePayload = jsonMap;
      final response = Response(
        requestOptions: tRequestOptions,
        data: responsePayload,
        statusCode: 200,
        headers: Headers.fromMap({
          Headers.contentTypeHeader: [Headers.jsonContentType],
        }),
      );
      when(mockDio.get(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => response);
    }

    test(
      'make sure getWeathers called with method GET',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        await remoteDataSource.getWeathers();

        // assert
        verify(
          mockDio.get(
            'http://api.openweathermap.org/data/2.5/forecast',
            data: anyNamed('data'),
            options: anyNamed('options'),
            queryParameters: anyNamed('queryParameters'),
          ),
        );
      },
    );

    test(
      'make sure returns model when response is (200) from endpoint',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        final result = await remoteDataSource.getWeathers();

        // assert
        expect(result, tResponse);
      },
    );

    test(
      'make sure throw exception DioException when returns exception from endpoint',
      () async {
        // arrange
        final response = Response(
          requestOptions: tRequestOptions,
          data: 'Bad Request',
          statusCode: 400,
        );
        when(
          mockDio.get(
            any,
            data: anyNamed('data'),
            options: anyNamed('options'),
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer((_) async => response);

        // act
        final call = remoteDataSource.getWeathers();

        // assert
        expect(() => call, throwsA(const TypeMatcher<DioException>()));
      },
    );
  });
}
