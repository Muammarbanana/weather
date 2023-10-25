// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccessState extends WeatherState {
  final WeatherResponse weatherReponse;
  const WeatherSuccessState({
    required this.weatherReponse,
  });

  @override
  List<Object> get props => [weatherReponse];

  @override
  String toString() {
    return 'WeatherSuccessState{weatherReponse: $weatherReponse}';
  }
}

class WeatherFailureState extends WeatherState {
  final String errorMessage;
  const WeatherFailureState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'WeatherFailureState{errorMessage: $errorMessage}';
  }
}
