import 'package:chat_app/presentation/helper/loading/loading_screen.dart';
import 'package:chat_app/presentation/helper/notify/alert_error.dart';
import 'package:chat_app/presentation/pages/signup/components/signin_btn.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/res/style.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:chat_app/presentation/widgets/input_text_field.dart';
import 'package:chat_app/presentation/widgets/large_round_button.dart';
import 'package:chat_app/presentation/widgets/warning_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _name = "";
  String _email = "";
  String _password = "";
  bool _isValidName = false;
  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _isValidVerified = false;
  String _messagePassword = "";
  String _messageVerified = "";
  @override
  Widget build(BuildContext context) {
    var sizedBox16 = SizedBox(height: Dimensions.height16);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterState) {
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
                  sizedBox16,
                  InputTextField(
                    title: 'Name',
                    hint: 'Enter your name',
                    icon: CupertinoIcons.person,
                    keyInput: 'name',
                    obscure: false,
                    type: TextInputType.name,
                    onSubmitted: null,
                    onChanged: (name) => _formatName(name),
                  ),
                  WarningMessage(
                    isDataValid: _isValidEmail,
                    message: 'Name is required!',
                  ),
                  sizedBox16,
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
                  sizedBox16,
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
                  sizedBox16,
                  InputTextField(
                    title: 'Verify',
                    hint: 'Re-enter your password',
                    icon: Icons.verified_user_outlined,
                    keyInput: 'password',
                    obscure: true,
                    type: TextInputType.multiline,
                    onSubmitted: null,
                    onChanged: (password) => _verifyPassword(password),
                  ),
                  WarningMessage(
                    isDataValid: _isValidVerified,
                    message: _messageVerified,
                  ),
                  sizedBox16,
                  LargeRoundButton(
                    textButton: 'Sign Up',
                    onTap: () => _signupApp(context),
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

  _signupApp(BuildContext context) {
    if (_isValidName || _isValidEmail || _isValidPassword || _isValidVerified) return;
    context.read<AuthBloc>().add(
          RegisterEvent(
            name: _name,
            email: _email,
            password: _password,
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

  _formatName(String name) {
    if (name.isEmpty) {
      setState(() {
        _isValidName = true;
      });
    } else {
      setState(() {
        _isValidName = false;
        _name = name;
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
