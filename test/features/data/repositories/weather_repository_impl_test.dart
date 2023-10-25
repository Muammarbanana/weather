import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherapp/core/errors/data_api_failure.dart';
import 'package:weatherapp/core/errors/failure.dart';
import 'package:weatherapp/features/data/models/weather/weather_response.dart';
import 'package:weatherapp/features/data/repositories/weather/weather_repository_impl.dart';

import '../../../helper/mock_helper.mocks.dart';

void main() {
  late WeatherRepositoryImpl repositoryImpl;
  late MockWeatherRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = WeatherRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  final tRequestOptions = RequestOptions(path: '');

  void setUpMockNetworkConnected() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  }

  void setUpMockNetworkDisconnected() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
  }

  void testDisconnected(Function endpointInvoke) {
    test(
      'make sure return ConnectionFailure when device is not connected to internet',
      () async {
        // arrange
        setUpMockNetworkDisconnected();

        // act
        final result = await endpointInvoke.call();

        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      },
    );
  }

  void testServerFailureString(
    Function whenInvoke,
    Function actInvoke,
    Function verifyInvoke,
  ) {
    test(
      'make sure return ServerFailure when Repository receives failed response from endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(whenInvoke.call()).thenThrow(
          DioException(
            requestOptions: tRequestOptions,
            error: 'testError',
            message: 'testError',
            response: Response(
              requestOptions: tRequestOptions,
              data: 'testDataError',
              statusCode: 400,
            ),
          ),
        );

        // act
        final result = await actInvoke.call();

        // assert
        verify(verifyInvoke.call());
        expect(
            result,
            Left(ServerFailure(const DataApiFailure(
              message: 'testError',
              httpMessage: 'testError',
              statusCode: 400,
            ))));
      },
    );
  }

  void testParsingFailure(
      Function whenInvoke, Function actInvoke, Function verifyInvoke) {
    test(
      'make sure return ParsingFailure when RemoteDataSource receives not valid response from endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(whenInvoke.call()).thenThrow(TypeError());

        // act
        final result = await actInvoke.call();

        // assert
        verify(verifyInvoke.call());
        expect(result, Left(ParsingFailure(TypeError().toString())));
      },
    );
  }

  group('getWeathers', () {
    const tResponse = WeatherResponse();

    test(
      'make sure return success value when receieve success response from endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockRemoteDataSource.getWeathers())
            .thenAnswer((_) async => tResponse);

        // act
        final result = await repositoryImpl.getWeathers();

        // assert
        verify(mockRemoteDataSource.getWeathers());
        expect(result, const Right(tResponse));
      },
    );

    test(
      'make sure return ServerFailure when response is timeout',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockRemoteDataSource.getWeathers()).thenThrow(DioException(
          requestOptions: tRequestOptions,
          error: 'testError',
          message: 'testError',
        ));

        // act
        final result = await repositoryImpl.getWeathers();

        // assert
        verify(mockRemoteDataSource.getWeathers());
        expect(
            result,
            Left(ServerFailure(const DataApiFailure(
              message: 'testError',
            ))));
      },
    );

    test(
      'make sure return ServerFailure when failed response from endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockRemoteDataSource.getWeathers()).thenThrow(
          DioException(
            requestOptions: tRequestOptions,
            error: 'testError',
            message: 'testError',
            response: Response(
              requestOptions: tRequestOptions,
              data: {
                'title': 'testTitleError',
                'message': 'testMessageError',
                'errors': {'testError': []},
              },
              statusCode: 400,
            ),
          ),
        );

        // act
        final result = await repositoryImpl.getWeathers();

        // assert
        verify(mockRemoteDataSource.getWeathers());
        expect(
            result,
            Left(ServerFailure(const DataApiFailure(
              statusCode: 400,
              httpMessage: 'testError',
              message: 'status code : 400 | error: testMessageError',
              errorData: {'testError': []},
            ))));
      },
    );

    testServerFailureString(
      () => mockRemoteDataSource.getWeathers(),
      () => repositoryImpl.getWeathers(),
      () => mockRemoteDataSource.getWeathers(),
    );

    testParsingFailure(
      () => mockRemoteDataSource.getWeathers(),
      () => repositoryImpl.getWeathers(),
      () => mockRemoteDataSource.getWeathers(),
    );

    testDisconnected(() => repositoryImpl.getWeathers());
  });
}
