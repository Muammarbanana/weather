import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/common_widgets/loading_dialog_widget.dart';
import 'package:weatherapp/core/helpers.dart';
import 'package:weatherapp/core/theme/input_decoration_manager.dart';
import 'package:weatherapp/core/theme/text_style_manager.dart';
import 'package:weatherapp/core/utils/custom_dialog.dart';
import 'package:weatherapp/features/presentation/ui/authentication/pages/register_page.dart';
import 'package:weatherapp/features/presentation/ui/weather_info/pages/weather_page.dart';

import '../../../../../core/theme/button_style_manager.dart';
import '../../../../../injection_container.dart';
import '../../../../data/datasources/authentication_remote_data_sources.dart';
import '../../../bloc/authentication_bloc/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // All TextEditingController goes here
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // All BLoC goes here
  final AuthenticationBloc _authenticationBloc = sl<AuthenticationBloc>();
  //Others
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _authenticationBloc,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccessLoginWithEmailState ||
                state is AuthenticationSuccessLoginWithGoogleState) {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, WeatherPage.routeName, (route) => false);
            } else if (state is AuthenticationFailureState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            } else {
              CustomDialog().of(context).dialog(const LoadingDialogWidget());
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Image.asset(
                      'assets/images/rainy_weather.png',
                      height: 200,
                    ),
                    const SizedBox(height: 40),
                    _signInWithEmailWidget(),
                    _signInWithSocmedWidget(),
                    Text(
                      'Don\'t have an account?',
                      style: TextStyleManager.mediumText(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.routeName);
                      },
                      child: Text(
                        'Register',
                        style: TextStyleManager.mediumText(
                            color: Colors.deepPurple),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInWithEmailWidget() {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorationManager.defaultStyle(hintText: 'Email'),
          style: TextStyleManager.mediumText(),
          validator: (value) {
            if (value == null || value == '') {
              return 'Please enter an email';
            } else if (!Helpers.validateEmail(email: value)) {
              return 'Invalid email format';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecorationManager.defaultStyle(hintText: 'Password'),
          style: TextStyleManager.mediumText(),
          validator: (value) {
            if (value == null || value == '') {
              return 'Please enter a password';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyleManager.primary(),
          onPressed: () {
            if (_formKey.currentState != null) {
              if (_formKey.currentState!.validate()) {
                _authenticationBloc
                    .add(LoginWithEmailEvent(ParamsLoginWithEmail(
                  email: _emailController.text,
                  password: _passwordController.text,
                )));
              }
            }
          },
          child: Text(
            'Sign In with Email',
            style: TextStyleManager.buttonText(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _signInWithSocmedWidget() {
    return Column(
      children: [
        Text(
          'Or',
          style: TextStyleManager.mediumText(),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            _authenticationBloc.add(
              LoginWithGoogleEvent(),
            );
          },
          style: ButtonStyleManager.primaryWhite(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/google.png', height: 30),
              const SizedBox(width: 16),
              Text(
                'Sign In with Google',
                style: TextStyleManager.mediumText(),
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
