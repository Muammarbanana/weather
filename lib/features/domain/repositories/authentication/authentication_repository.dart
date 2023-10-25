import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weatherapp/features/data/datasources/authentication_remote_data_sources.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserCredential?>> loginWithEmail(
      ParamsLoginWithEmail params);
  Future<Either<Failure, UserCredential?>> registerWithEmail(
      ParamsLoginWithEmail params);
}
