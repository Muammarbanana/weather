import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:weatherapp/features/data/datasources/authentication_remote_data_sources.dart';
import 'package:weatherapp/features/presentation/bloc/authentication_bloc/authentication_bloc.dart';

import 'core/services/network_info.dart';
import 'features/data/repositories/authentication/authentication_repository_impl.dart';
import 'features/domain/repositories/authentication/authentication_repository.dart';
import 'features/domain/usecases/login_with_email.dart';
import 'features/domain/usecases/register_with_email.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Remote Datasources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  // Usecases
  sl.registerLazySingleton(() => LoginWithEmail(repository: sl()));
  sl.registerLazySingleton(() => RegisterWithEmail(repository: sl()));

  // BLoC
  sl.registerFactory(
      () => AuthenticationBloc(loginWithEmail: sl(), registerWithEmail: sl()));

  // External
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());
}
