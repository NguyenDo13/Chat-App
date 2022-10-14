import 'dart:developer';

import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/repository/auth_repository.dart';
import 'package:chat_app/presentation/pages/app_home.dart';
import 'package:chat_app/presentation/pages/login/login_screen.dart';
import 'package:chat_app/presentation/pages/signup/signup_screen.dart';
import 'package:chat_app/presentation/pages/splash/splash_screen.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends StatefulWidget {
  const AppController({
    Key? key,
  }) : super(key: key);

  @override
  State<AppController> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {
  // Initialize SharedPreferences to get tokenUser
  late Future<SharedPreferences> shared;
  _initshared() async {
    shared = SharedPreferences.getInstance();
  }

  @override
  void initState() {
    _initshared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        AuthRepository(
          environment: Environment(isServerDev: true),
        ),
        shared,
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // Check dark mode
          if (state is LoggedState) {
            // app states
            AppStateProvider appStateProvider =
                context.read<AppStateProvider>();
            final authUser =
                Provider.of<AuthBloc>(context, listen: false).authUser;

            if (authUser.user == null) return;
            appStateProvider.darkMode = authUser.user!.isDarkMode!;
          }
        },
        builder: (context, state) {
          // Splash screen
          if (state is AuthLoadingState) {
            Future.delayed(const Duration(milliseconds: 500), () {
              context.read<AuthBloc>().add(LoginWithAccessTokenEvent());
            });
            return const SplashScreen();
          }

          // Login screen
          if (state is LoginState) {
            return const LoginScreen();
          }

          // Register screen
          if (state is RegisterState) {
            return const SignUpScreen();
          }

          // Home page
          if (state is LoggedState) {
            return const AppHome();
          }

          // Error app
          return const Center(
              child: Text(
            'Error 500',
            style: TextStyle(color: Colors.red),
          ));
        },
      ),
    );
  }
}
