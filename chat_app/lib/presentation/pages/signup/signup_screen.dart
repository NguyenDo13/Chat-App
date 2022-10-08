import 'package:chat_app/presentation/helper/loading/loading_screen.dart';
import 'package:chat_app/presentation/pages/signup/components/signin_btn.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/res/style.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:chat_app/presentation/widgets/button_round_white.dart';
import 'package:chat_app/presentation/widgets/input_text_field.dart';
import 'package:chat_app/presentation/widgets/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email = "";
  String _password = "";
  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _isValidVerified = false;
  String _messagePassword = "";
  String _messageVerified = "";
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterState) {
          if (state.message != null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(state.message!),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("oke"),
                    ),
                  ],
                );
              },
            );
          }
          if (state.loading) {
            LoadingScreen().show(context: context);
          } else {
            LoadingScreen().hide();
          }
        }
      },
      child: Scaffold(
        body: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              padding: paddingAuthRG,
              height: Dimensions.screenHeight,
              width: Dimensions.screenWidth,
              decoration: boxBGAuth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildSignUpTitle(context),
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
                  SizedBox(height: Dimensions.height20),
                  InputTextField(
                    onChanged: (password) => _verifyPassword(password),
                  ),
                  WarningMessage(
                    isDataValid: _isValidVerified,
                    message: _messageVerified,
                  ),
                  SizedBox(height: Dimensions.height20),
                  LagreButtonRound(
                    textButton: 'Sign Up',
                    onTap: () {
                      if (!_isValidEmail &&
                          !_isValidPassword &&
                          !_isValidVerified) {
                        context.read<AuthBloc>().add(
                              RegisterEvent(
                                email: _email,
                                password: _password,
                              ),
                            );
                      }
                    },
                  ),
                  const SignInBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildSignUpTitle(BuildContext context) {
    return Text(
      'Sign Up',
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Colors.white70,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
    );
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

  _verifyPassword(String password) {
    if (_password.isEmpty) {
      setState(() {
        _isValidVerified = true;
        _messageVerified = 'Please enter the password first!';
      });
    } else if (_password != password) {
      setState(() {
        _isValidVerified = true;
        _messageVerified = 'Password does not match!';
      });
    } else {
      setState(() {
        _isValidVerified = false;
      });
    }
  }
}
