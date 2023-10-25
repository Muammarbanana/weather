import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/use_case/use_case.dart';

import '../../../../core/errors/failure.dart';
import '../../../data/datasources/authentication_remote_data_sources.dart';
import '../../../domain/usecases/login_with_email.dart';
import '../../../domain/usecases/login_with_google.dart';
import '../../../domain/usecases/register_with_email.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginWithEmail loginWithEmail;
  final RegisterWithEmail registerWithEmail;
  final LoginWithGoogle loginWithGoogle;
  AuthenticationBloc({
    required this.loginWithEmail,
    required this.registerWithEmail,
    required this.loginWithGoogle,
  }) : super(AuthenticationInitialState()) {
    on<LoginWithEmailEvent>(_onLoginWithEmail);
    on<RegisterWithEmailEvent>(_onRegisterWithEmail);
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
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

  void _onRegisterWithEmail(
    RegisterWithEmailEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await registerWithEmail.call(event.params);

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
        (response) => AuthenticationSuccessRegisterWithEmailState(
          userCredential: response,
        ),
      ),
    );
  }

  void _onLoginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await loginWithGoogle.call(NoParams());

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
        (response) => AuthenticationSuccessLoginWithGoogleState(
          userCredential: response,
        ),
      ),
    );
  }
}
