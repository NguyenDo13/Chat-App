import 'dart:developer';

import 'package:chat_app/data/repository/auth_repository.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository authRepository;
  late final Future<SharedPreferences> sharedPreferences;

  AuthBloc(
    this.authRepository,
    this.sharedPreferences,
  ) : super(LoginState()) {
    // Event to login by application account
    on<NormalLoginEvent>((event, emit) async {
      // Post request (email, password) to server, receive response value
      final value = await authRepository.getDataLogin(
        data: {'email': event.email, 'password': event.password},
        header: {'Content-Type': 'application/json'},
      );

      // Ckeck correct value data
      if (value == null || value.result != 1) return emit(LoginState());

      // Store accessToken to login
      final authUser = authRepository.convertDynamicToObject(value.data[0]);
      final shared = await sharedPreferences;
      shared.setString('auth_token', authUser.accessToken.toString());

      // Login success
      emit(LoggedState(authUser));
    });

    // Event to login with a code that is accessToken. It is allocated when previously logged in.
    on<LoginWithAccessTokenEvent>((event, emit) async {
      // To wait event
      emit(LoginLoadingState());

      // Init data for request
      final shared = await sharedPreferences;
      final tokenUser = shared.getString('auth_token');

      // Check data not null
      if (tokenUser == null) return emit(LoginState());

      // Post a request to the server, receive a response value
      final value = await authRepository.getDataLoginWithAccessToken(
        data: {},
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenUser'
        },
      );

      // Check value not null
      if (value == null) return emit(LoginState());

      // Get data User
      final authUser = authRepository.convertDynamicToObject(value.data[0]);
      emit(LoggedState(authUser));
    });

    // Event to login by Google account
    on<GoogleLoginEvent>((event, emit) {});

    // Event to login by Facebook account
    on<FacebookLoginEvent>((event, emit) {});

    //Event to logout application
    on<LogoutEvent>((event, emit) => emit(LoginState()));

    // Event to register a new app account
    on<RegisterEvent>((event, emit) async {
      final value = await authRepository.getDataRegister(
        data: {'email': event.email, 'password': event.password},
        header: {'Content-Type': 'application/json'},
      );

      if (value != null) {
        final authUser = authRepository.convertDynamicToObject(value);
        final shared = await sharedPreferences;

        shared.setString('auth_token', authUser.accessToken.toString());

        emit(LoggedState(authUser));
      } else {
        emit(LoginState());
      }
    });
  }
}
