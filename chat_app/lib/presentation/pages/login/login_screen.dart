import 'package:chat_app/presentation/helper/loading/loading_screen.dart';
import 'package:chat_app/presentation/helper/notify/alert_error.dart';
import 'package:chat_app/presentation/pages/login/components/signin_other_ways.dart';
import 'package:chat_app/presentation/pages/login/components/signin_title.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/pages/login/components/forgot_password_btn.dart';
import 'package:chat_app/presentation/pages/login/components/remember_me_checkbox.dart';
import 'package:chat_app/presentation/pages/login/components/signup_btn.dart';
import 'package:chat_app/presentation/pages/login/components/social_btn_row.dart';
import 'package:chat_app/presentation/res/style.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:chat_app/presentation/widgets/input_text_field.dart';
import 'package:chat_app/presentation/widgets/large_round_button.dart';
import 'package:chat_app/presentation/widgets/warning_message_widget.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginState) {
          if (state.loading) {
            LoadingScreen().show(context: context);
          } else {
            LoadingScreen().hide();
          }
          if (state.message != null) {
            showDialog(
              context: context,
              builder: (context) => AlertError(
                title: "error",
                content: state.message ?? 'Cannot connect to server',
                nameBtn: 'Oke',
              ),
            );
          }
        }
      },
      child: Scaffold(
        body: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              padding: paddingAuthLG,
              height: Dimensions.screenHeight,
              width: Dimensions.screenWidth,
              decoration: boxBGAuth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SignInTitle(),
                  SizedBox(height: Dimensions.height20),
                  InputTextField(
                    title: 'Email',
                    hint: 'Enter your email',
                    icon: Icons.email,
                    keyInput: 'email',
                    obscure: false,
                    type: TextInputType.emailAddress,
                    onSubmitted: null,
                    onChanged: (email) => _formatEmail(email),
                  ),
                  WarningMessage(
                    isDataValid: _isValidEmail,
                    message: 'Email is required!',
                  ),
                  SizedBox(height: Dimensions.height20),
                  InputTextField(
                    title: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock,
                    keyInput: 'password',
                    obscure: true,
                    type: TextInputType.multiline,
                    onSubmitted: null,
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
                  LargeRoundButton(
                    textButton: 'Login',
                    onTap: _loginApp,
                  ),
                  const SignInOtherWays(),
                  const SocialBtnRow(),
                  const SignupBtn(),
                ],
              ),
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
