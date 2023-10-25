import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserCredential?> loginWithEmail(ParamsLoginWithEmail params);
  Future<UserCredential?> registerWithEmail(ParamsLoginWithEmail params);
  Future<UserCredential?> loginWithGoogle();
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

  @override
  Future<UserCredential?> registerWithEmail(ParamsLoginWithEmail params) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: params.email, password: params.password);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.toString(), message: e.message);
    }
  }

  @override
  Future<UserCredential> loginWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
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
