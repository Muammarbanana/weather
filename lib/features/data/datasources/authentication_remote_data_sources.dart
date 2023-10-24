import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserCredential?> loginWithEmail(ParamsLoginWithEmail params);
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  @override
  Future<UserCredential?> loginWithEmail(ParamsLoginWithEmail params) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: params.email, password: params.password);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.toString(), message: e.message);
    }
  }
}

class ParamsLoginWithEmail extends Equatable {
  final String email;
  final String password;

  const ParamsLoginWithEmail({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  @override
  bool get stringify => true;
}
