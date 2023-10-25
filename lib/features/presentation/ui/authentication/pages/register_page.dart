import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/features/data/datasources/authentication_remote_data_sources.dart';

import '../../../../../core/common_widgets/loading_dialog_widget.dart';
import '../../../../../core/helpers.dart';
import '../../../../../core/theme/button_style_manager.dart';
import '../../../../../core/theme/input_decoration_manager.dart';
import '../../../../../core/theme/text_style_manager.dart';
import '../../../../../core/utils/custom_dialog.dart';
import '../../../../../injection_container.dart';
import '../../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../weather_info/pages/weather_page.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register-page';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            if (state is AuthenticationSuccessLoginWithEmailState) {
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
                      'assets/images/sunny_weather.png',
                      height: 200,
                    ),
                    const SizedBox(height: 40),
                    _registerWithEmailWidget(),
                    Text(
                      'Already have an account?',
                      style: TextStyleManager.mediumText(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
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

  Widget _registerWithEmailWidget() {
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
                _authenticationBloc.add(
                  RegisterWithEmailEvent(
                    ParamsLoginWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text),
                  ),
                );
              }
            }
          },
          child: Text(
            'Register with Email',
            style: TextStyleManager.buttonText(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
