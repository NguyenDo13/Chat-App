import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/repository/auth_repository.dart';
import 'package:chat_app/presentation/pages/page_controller.dart';
import 'package:chat_app/presentation/pages/login/login_screen.dart';
import 'package:chat_app/presentation/pages/signup/signup_screen.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppAuthentication extends StatefulWidget {
  final Future<SharedPreferences> sharedFuture;
  final String? tokenUser;
  final String deviceToken;
  const AppAuthentication({
    Key? key,
    required this.sharedFuture,
    this.tokenUser,
    required this.deviceToken,
  }) : super(key: key);

  @override
  State<AppAuthentication> createState() => _AppAuthenticationState();
}

class _AppAuthenticationState extends State<AppAuthentication> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
    );
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        AuthRepository(
          environment: Environment(isServerDev: true),
        ),
        widget.sharedFuture,
      )..add(widget.tokenUser != null
          ? LoginByAccessTokenEvent()
          : InitLoginEvent()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // Check dark mode
          if (state is LoggedState) {
            // app states
            AppStateProvider appState = context.read<AppStateProvider>();
            if (state.authUser != null) {
              appState.darkMode = state.authUser!.user!.isDarkMode!;
              if (state.authUser!.user!.urlImage != null) {
                appState.urlImage = state.authUser!.user!.urlImage!;
              }
            }
          }
        },
        builder: (context, state) {
          // Register screen
          if (state is RegisterState) {
            return const SignUpScreen();
          }
          // Home page
          if (state is LoggedState) {
            return AppPageController(
              friendRequests: state.friendRequests,
              chatRooms: state.chatRooms!,
              authUser: state.authUser!,
              listFriend: state.listFriend,
            );
          }
          return LoginScreen(
            deviceToken: widget.deviceToken,
          );
        },
      ),
    );
  }
}
