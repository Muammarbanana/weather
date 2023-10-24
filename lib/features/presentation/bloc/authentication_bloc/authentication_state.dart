part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessLoginWithEmailState extends AuthenticationState {
  final UserCredential? userCredential;

  const AuthenticationSuccessLoginWithEmailState(
      {required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}

class AuthenticationFailureState extends AuthenticationState {
  final String errorMessage;
  const AuthenticationFailureState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'AuthenticationFailureState{errorMessage: $errorMessage}';
  }
}
