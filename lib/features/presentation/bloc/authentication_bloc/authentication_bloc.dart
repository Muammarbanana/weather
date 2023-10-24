import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../../data/datasources/authentication_remote_data_sources.dart';
import '../../../domain/usecases/login_with_email.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginWithEmail loginWithEmail;
  AuthenticationBloc({
    required this.loginWithEmail,
  }) : super(AuthenticationInitialState()) {
    on<LoginWithEmailEvent>(_onLoginWithEmail);
  }

  void _onLoginWithEmail(
    LoginWithEmailEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await loginWithEmail.call(event.params);

    emit(
      result.fold(
        (failure) {
          var errorMessage = '';
          if (failure is ServerFailure) {
            errorMessage = failure.dataApiFailure.message ?? errorMessage;
          } else if (failure is ConnectionFailure) {
            errorMessage = failure.errorMessage;
          } else if (failure is ParsingFailure) {
            errorMessage = failure.errorMessage;
          }
          return AuthenticationFailureState(
            errorMessage: errorMessage,
          );
        },
        (response) => AuthenticationSuccessLoginWithEmailState(
          userCredential: response,
        ),
      ),
    );
  }
}