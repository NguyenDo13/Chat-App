import 'package:chat_app/presentation/pages/home/home_page.dart';
import 'package:chat_app/presentation/pages/login/login_screen.dart';
import 'package:chat_app/presentation/pages/signup/signup_screen.dart';
import 'package:chat_app/presentation/pages/splash/splash_screen.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppController extends StatefulWidget {
  const AppController({
    Key? key,
  }) : super(key: key);

  @override
  State<AppController> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          Future.delayed(const Duration(seconds: 1), () {
            context.read<AuthBloc>().add(LoginWithAccessTokenEvent());
          });
          return const SplashScreen();
        }
        if (state is LoggedState) {
          return const HomePage();
        }
        if (state is LoginState) {
          return const LoginScreen();
        }
        if (state is RegisterState) {
          return const SignUpScreen();
        }
        return const Center(child: Text('Error 500'));
      },
    );
  }
}
