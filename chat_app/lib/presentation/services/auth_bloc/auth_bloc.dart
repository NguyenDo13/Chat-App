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
      final value = await authRepository.getDataLogin(
        data: {'email': event.email, 'password': event.password},
        header: {'Content-Type': 'application/json'},
      );

      if (value == null) emit(LoginState());
      if (value!.result != 1) emit(LoginState());

      final authUser = authRepository.convertDynamicToObject(value.data[0]);
      final shared = await sharedPreferences;

      shared.setString('auth_token', authUser.accessToken.toString());
      emit(LoggedState(authUser));
    });

    // Event to login with a code that is accessToken. It is allocated when previously logged in.
    on<LoginWithAccessTokenEvent>((event, emit) async {
      final shared = await sharedPreferences;
      final tokenUser = shared.getString('auth_token');
      log('Bearer $tokenUser');
      if (tokenUser != null) {
        final value = await authRepository
            .getDataLoginWithAccessToken(data: null, header: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenUser'
        });

        if (value != null) {
          final authUser = authRepository.convertDynamicToObject(value.data[0]);

          emit(LoggedState(authUser));
        } else {
          emit(LoginState());
        }
      } else {
        emit(LoginState());
      }
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
