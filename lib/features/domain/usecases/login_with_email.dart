import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weatherapp/features/data/datasources/authentication_remote_data_sources.dart';
import 'package:weatherapp/features/domain/repositories/authentication/authentication_repository.dart';

import '../../../core/errors/failure.dart';
import '../../../core/use_case/use_case.dart';

class LoginWithEmail implements UseCase<UserCredential?, ParamsLoginWithEmail> {
  final AuthenticationRepository repository;

  LoginWithEmail({required this.repository});

  @override
  Future<Either<Failure, UserCredential?>> call(
      ParamsLoginWithEmail params) async {
    return repository.loginWithEmail(params);
  }
}
