import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/features/data/datasources/authentication_remote_data_sources.dart';
import 'package:weatherapp/features/data/datasources/wather_remote_data_sources.dart';
import 'package:weatherapp/features/data/repositories/weather/weather_repository_impl.dart';
import 'package:weatherapp/features/domain/repositories/weather/weather_repository.dart';
import 'package:weatherapp/features/domain/usecases/get_weathers.dart';
import 'package:weatherapp/features/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:weatherapp/features/presentation/bloc/weather_bloc/weather_bloc.dart';

import 'core/services/dio_loggin_interceptor.dart';
import 'core/services/network_info.dart';
import 'core/services/shared_preference_manager.dart';
import 'features/data/repositories/authentication/authentication_repository_impl.dart';
import 'features/domain/repositories/authentication/authentication_repository.dart';
import 'features/domain/usecases/login_with_email.dart';
import 'features/domain/usecases/register_with_email.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Remote Datasources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(dio: sl()));

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => LoginWithEmail(repository: sl()));
  sl.registerLazySingleton(() => RegisterWithEmail(repository: sl()));
  sl.registerLazySingleton(() => GetWeathers(repository: sl()));

  // BLoC
  sl.registerFactory(
      () => AuthenticationBloc(loginWithEmail: sl(), registerWithEmail: sl()));
  sl.registerFactory(() => WeatherBloc(getWeathers: sl()));

  // External
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());
  final sharedPreferences = await SharedPreferences.getInstance();
  final sharedPreferencesManager =
      SharedPreferencesManager.getInstance(sharedPreferences);
  sl.registerLazySingleton(() => sharedPreferencesManager);

  sl.registerLazySingleton(() {
    final options = BaseOptions(
      connectTimeout: const Duration(seconds: 60), //20 seconds
      receiveTimeout: const Duration(seconds: 60),
    );
    final dio = Dio(options);
    dio.interceptors.add(DioLoggingInterceptor(sharedPreferencesManager));
    return dio;
  });
}
