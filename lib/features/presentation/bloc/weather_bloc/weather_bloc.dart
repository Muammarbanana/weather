import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/core/use_case/use_case.dart';
import '../../../../core/errors/failure.dart';
import '../../../data/models/weather/weather_response.dart';
import '../../../domain/usecases/get_weathers.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeathers getWeathers;
  WeatherBloc({required this.getWeathers}) : super(WeatherInitialState()) {
    on<WeatherGotInitialData>(_onGotInitialData);
  }

  void _onGotInitialData(
    WeatherGotInitialData event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoadingState());
    final result = await getWeathers(NoParams());

    emit(
      result.fold(
        (failure) {
          var errorMessage = '';
          if (failure is ServerFailure) {
            errorMessage = failure.dataApiFailure.message ?? errorMessage;
          } else if (failure is ConnectionFailure) {
            errorMessage = failure.errorMessage;
          } else if (failure is ParsingFailure) {
            errorMessage = failure.errorMessage;
          }
          return WeatherFailureState(
            errorMessage: errorMessage,
          );
        },
        (response) => WeatherSuccessState(
          weatherReponse: response,
        ),
      ),
    );
  }
}
