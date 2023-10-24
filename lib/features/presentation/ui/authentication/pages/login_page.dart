import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/features/data/datasources/authentication_remote_data_sources.dart';
import 'package:weatherapp/features/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:weatherapp/injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // All TextEditingController goes here
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // All BLoC goes here
  final AuthenticationBloc _authenticationBloc = sl<AuthenticationBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _authenticationBloc,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccessLoginWithEmailState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Berhasil login ${state.userCredential}'),
                ),
              );
            } else if (state is AuthenticationFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gagal login ${state.errorMessage}'),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                ElevatedButton(
                  onPressed: () {
                    _authenticationBloc
                        .add(LoginWithEmailEvent(ParamsLoginWithEmail(
                      email: emailController.text,
                      password: passwordController.text,
                    )));
                  },
                  child: const Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
