import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/images_animations.dart';
import 'package:chat_app/presentation/pages/login/components/forgot_password_btn.dart';
import 'package:chat_app/presentation/pages/login/components/remember_me_checkbox.dart';
import 'package:chat_app/presentation/pages/login/components/signup_btn.dart';
import 'package:chat_app/presentation/pages/login/components/social_btn_row.dart';
import 'package:chat_app/presentation/pages/signup/sign_up_screen.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:chat_app/presentation/widgets/button_round_white.dart';
import 'package:chat_app/presentation/widgets/input_text_field.dart';
import 'package:chat_app/presentation/widgets/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  String _email = "";
  String _password = "";
  bool _isValidEmail = false;
  bool _isValidPassword = false;
  String _messagePassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              Dimensions.width10 * 4,
              Dimensions.height62,
              Dimensions.width10 * 4,
              0,
            ),
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  redAccent,
                  deepPurple,
                  deepPurple,
                  deepPurple,
                  redAccent,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Colors.white70,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: Dimensions.height20),
                InputTextField(
                  isEmail: true,
                  onChanged: (email) => _formatEmail(email),
                ),
                WarningMessage(
                  isDataValid: _isValidEmail,
                  message: 'Email is required!',
                ),
                SizedBox(height: Dimensions.height20),
                InputTextField(
                  isPassword: true,
                  onChanged: (password) => _formatPassword(password),
                ),
                WarningMessage(
                  isDataValid: _isValidPassword,
                  message: _messagePassword,
                ),
                const ForgotPasswordBtn(),
                RememberMeCheckbox(
                    rememberMe: _rememberMe,
                    onChange: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    }),
                ButtonRoundWhite(
                  textButton: 'Login',
                  onTap: _loginApp,
                ),
                Column(
                  children: [
                    const Text(
                      '- OR -',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    Text(
                      'Sign in with',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SocialBtnRow(),
                const SignupBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginApp() {
    if (_isValidPassword || _isValidEmail) return;
    context.read<AuthBloc>().add(
          NormalLoginEvent(
            email: _email,
            password: _password,
          ),
        );
  }

  _formatPassword(String password) {
    if (password.isEmpty) {
      setState(() {
        _isValidPassword = true;
        _messagePassword = 'Password is required!';
      });
    } else if (password.length < 6) {
      setState(() {
        _isValidPassword = true;
        _messagePassword = 'Must be more than 5 characters!';
      });
    } else {
      setState(() {
        _isValidPassword = false;
        _password = password;
      });
    }
  }

  _formatEmail(String email) {
    if (email.isEmpty) {
      setState(() {
        _isValidEmail = true;
      });
    } else {
      setState(() {
        _isValidEmail = false;
        _email = email;
      });
    }
  }
}
