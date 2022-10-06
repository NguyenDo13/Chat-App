import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/images_animations.dart';
import 'package:chat_app/presentation/pages/chit_chat_app.dart';
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
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
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
                    _buildForgotPasswordBtn(),
                    _buildRememberMeCheckbox(),
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
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    _buildSocialBtnRow(),
                    _buildSignupBtn(),
                  ],
                ),
              ),
            );
          },
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
    if (context.read<AuthBloc>().state is LoggedState) {
      print("login successful");
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => const ChitChatApp(),
    //   ),
    // );
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

  Widget _buildForgotPasswordBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(Dimensions.height10),
        child: Text(
          'Forgot Password?',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: Dimensions.height20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white70),
            child: Checkbox(
              value: _rememberMe,
              checkColor: deepPurple,
              activeColor: Colors.white70,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return InkWell(
      onTap: () => onTap,
      child: Container(
        height: Dimensions.height60 - Dimensions.height8,
        width: Dimensions.height60 - Dimensions.height8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white70,
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.height20),
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
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height8),
            child: const Text(
              'Don\'t have an Account?',
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
              context.read<AuthBloc>().emit(RegisterState());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignUpScreen(),
                ),
              );
            },
            child: Text(
              'Sign Up',
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
