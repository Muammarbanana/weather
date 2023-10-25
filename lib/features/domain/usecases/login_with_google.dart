import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/authentication/authentication_repository.dart';

import '../../../core/errors/failure.dart';
import '../../../core/use_case/use_case.dart';

class LoginWithGoogle implements UseCase<UserCredential?, NoParams> {
  final AuthenticationRepository repository;

  LoginWithGoogle({required this.repository});

  @override
  Future<Either<Failure, UserCredential?>> call(NoParams params) async {
    return repository.loginWithGoogle();
  }
}
