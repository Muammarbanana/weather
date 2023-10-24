part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<dynamic> get props => [];
}

class LoginWithEmailEvent extends AuthenticationEvent {
  final ParamsLoginWithEmail params;
  const LoginWithEmailEvent(
    this.params,
  );

  @override
  List<Object> get props => [
        params,
      ];

  @override
  String toString() {
    return 'LoginWithEmailEvent{params: $params}';
  }
}
