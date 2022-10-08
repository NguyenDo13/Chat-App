import 'dart:developer';

import 'package:chat_app/data/repository/auth_repository.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository authRepository;
  late final Future<SharedPreferences> sharedPreferences;

  // Constructer BloC
  AuthBloc(
    this.authRepository,
    this.sharedPreferences,
  ) : super(AuthLoadingState()) {
    // Event to login by application account
    on<NormalLoginEvent>((event, emit) async {
      // Show loading popup
      emit(LoginState(loading: true));

      // Post request (email, password) to server, receive response value
      final value = await authRepository.getDataLogin(
        data: {'email': event.email, 'password': event.password},
        header: {'Content-Type': 'application/json'},
      );

      // Ckeck correct value data
      if (value == null || value.result != 1) return emit(LoginState(loading: false));

      // Store accessToken to login
      final authUser = authRepository.convertDynamicToObject(value.data[0]);
      final shared = await sharedPreferences;
      shared.setString('auth_token', authUser.accessToken.toString());

      // Close loading popup
      emit(LoginState(loading: false));

      // Login success
      emit(LoggedState(authUser));
    });

    // Event to register a new app account
    on<RegisterEvent>((event, emit) async {
      // Show loading popup
      emit(RegisterState(loading: true));

      // * Register
      // Post request (email, password) to server, receive response value
      final valueRegister = await authRepository.getDataRegister(
        data: {'email': event.email, 'password': event.password},
        header: {'Content-Type': 'application/json'},
      );

      // Ckeck correct value data
      if (valueRegister == null) {
        return emit(RegisterState(loading: false));
      }

      if (valueRegister.result != 1) {
        return emit(RegisterState(
            message: valueRegister.error?.message, loading: false));
      }
      emit(RegisterState(loading: false));

      // ****************************************************************
      // * Auto Login
      //Post request (email, password) to server, receive response value
      final valueLogin = await authRepository.getDataLogin(
        data: {'email': event.email, 'password': event.password},
        header: {'Content-Type': 'application/json'},
      );

      // Ckeck correct value data
      if (valueLogin == null || valueLogin.result != 1) {
        return emit(LoginState(loading: false));
      }

      // Store accessToken to login
      final authUser = authRepository.convertDynamicToObject(
        valueLogin.data[0],
      );
      final shared = await sharedPreferences;
      shared.setString('auth_token', authUser.accessToken.toString());
      
      // Close loading popup
      emit(RegisterState(loading: false));

      // Login success
      emit(LoggedState(authUser));
    });

    // Event to login with a code that is accessToken. It is allocated when previously logged in.
    on<LoginWithAccessTokenEvent>((event, emit) async {
      // Init data for request
      final shared = await sharedPreferences;
      final tokenUser = shared.getString('auth_token');

      // Check data not null
      if (tokenUser == null || tokenUser.isEmpty) return emit(LoginState(loading: false));

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
      if (value == null) return emit(LoginState(loading: false));

      // Get data User
      final authUser = authRepository.convertDynamicToObject(value.data[0]);
      emit(LoggedState(authUser));
    });

    on<InitRegisterEvent>((event, emit) => emit(RegisterState(loading: false)));

    // Event to login by Google account
    on<GoogleLoginEvent>((event, emit) {});

    // Event to login by Facebook account
    on<FacebookLoginEvent>((event, emit) {});

    //Event to logout application
    on<LogoutEvent>((event, emit) async {
      // Delete accessToken in local storage
      final shared = await sharedPreferences;
      shared.setString('auth_token', '');
      // Logout App
      emit(LoginState(loading: false));
    });
  }
}
