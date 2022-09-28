import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/images_animations.dart';
import 'package:chat_app/presentation/UIData/style.dart';
import 'package:chat_app/presentation/pages/signup/sign_up_screen.dart';
import 'package:chat_app/presentation/services/login_bloc/login_bloc.dart';
import 'package:chat_app/presentation/services/login_bloc/login_event.dart';
import 'package:chat_app/presentation/services/login_bloc/login_state.dart';
import 'package:chat_app/presentation/widgets/button_round_white.dart';
import 'package:chat_app/presentation/widgets/input_text_field.dart';
import 'package:chat_app/presentation/widgets/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _isValidEmail = true;
  bool _isValidPassword = true;
  String _messagePassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginInitial) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: InkWell(
                onTap: () {},
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: DecorationBGLogin,
                    ),
                    SizedBox(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 120.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              TITLE_SIGNIN,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            InputTextField(
                              isEmail: true,
                              onChanged: (email) {
                                setState(() {
                                  _email = email;
                                });
                                _formatEmail(email);
                              },
                            ),
                            WarningMessage(
                              isDataValid: _isValidEmail,
                              message: MESSAGE_EMAIL,
                            ),
                            const SizedBox(height: 20.0),
                            InputTextField(
                              isPassword: true,
                              onChanged: (password) {
                                setState(() {
                                  _password = password;
                                });
                                _formatPassword(password);
                              },
                            ),
                            WarningMessage(
                              isDataValid: _isValidPassword,
                              message: _messagePassword,
                            ),
                            _buildForgotPasswordBtn(),
                            _buildRememberMeCheckbox(),
                            ButtonRoundWhite(
                              textButton: TITLE_LOGIN,
                              press: () {
                                if (_isValidPassword && _isValidEmail) {
                                  context.read<LoginBloc>().add(
                                        SimplyLoginEvent(
                                          email: _email,
                                          password: _password,
                                        ),
                                      );
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            _buildSignInWithText(),
                            _buildSocialBtnRow(),
                            _buildSignupBtn(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const Text('some thing Wrong!');
        },
      ),
    );
  }

  _formatPassword(String password) {
    setState(() {
      if (password.isEmpty) {
        _isValidPassword = false;
        _messagePassword = MESSAGE_PASSWORD;
      } else if (password.length < 6) {
        _isValidPassword = false;
        _messagePassword = MESSAGE_PASSWORD_6;
      } else {
        _isValidPassword = true;
      }
    });
  }

  _formatEmail(String email) {
    setState(() {
      if (email.isEmpty) {
        _isValidEmail = false;
      } else {
        _isValidEmail = true;
      }
    });
  }

  Widget _buildForgotPasswordBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(10),
        child: const Text(
          FORGOTPASS,
          style: LabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: lightBlueColorF6,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            REMEMBER_ME,
            style: LabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: const [
        Text(
          OR,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          SIGN_WITH,
          style: LabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return InkWell(
      onTap: () => onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () {},
            const AssetImage(
              IMG_FB,
            ),
          ),
          _buildSocialBtn(
            () {},
            const AssetImage(
              IMG_GG,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SignUpScreen(),
          ),
        );
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: DON_HAVE_ACC,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: TITLE_SIGNUP,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
