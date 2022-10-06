import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';
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
    return Scaffold(
      body: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is RegisterState) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    Dimensions.width10 * 4,
                    Dimensions.height20,
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
                        'Sign Up',
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
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
                      SizedBox(height: Dimensions.height20),
                      InputTextField(
                        onChanged: (password) => _verifyPassword(password),
                      ),
                      WarningMessage(
                        isDataValid: _isValidVerified,
                        message: _messageVerified,
                      ),
                      SizedBox(height: Dimensions.height20),
                      ButtonRoundWhite(
                        textButton: 'Sign Up',
                        onTap: _signup,
                      ),
                      _buildSignupBtn(context),
                    ],
                  ),
                ),
              );
            }
            return const Text('Error 500');
          },
        ),
      ),
    );
  }

  _signup() {
    if (!_isValidEmail && !_isValidPassword && !_isValidVerified) {
      print("go here...");
      context.read<AuthBloc>().add(
            RegisterEvent(
              email: _email,
              password: _password,
            ),
          );
          
      // Navigator.pop(context);
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

  Widget _buildSignupBtn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height8),
            child: const Text(
              'If you have an Account?',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: Dimensions.width8),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Login',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
