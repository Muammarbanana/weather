import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/data_api_failure.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/network_info.dart';
import '../../../domain/repositories/authentication/authentication_repository.dart';
import '../../datasources/authentication_remote_data_sources.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserCredential?>> loginWithEmail(
      ParamsLoginWithEmail params) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.loginWithEmail(params);
        return Right(response);
      } on FirebaseAuthException catch (error) {
        return Left(
          ServerFailure(
            DataApiFailure(message: error.message),
          ),
        );
      } on TypeError catch (error) {
        return Left(ParsingFailure(error.toString()));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> registerWithEmail(
      ParamsLoginWithEmail params) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.registerWithEmail(params);
        return Right(response);
      } on FirebaseAuthException catch (error) {
        return Left(
          ServerFailure(
            DataApiFailure(message: error.message),
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
