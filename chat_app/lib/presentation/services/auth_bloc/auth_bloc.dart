import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/repository/auth_repository.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_event.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository authRepository;
  late final Future<SharedPreferences> sharedPreferences;

  // Data user
  late AuthUser? _authUser;

  // Constructor BloC
  AuthBloc(
    this.authRepository,
    this.sharedPreferences,
  ) : super(AuthLoadingState()) {
    //* Event to login by application account
    on<NormalLoginEvent>(normalLogin);

    on<InitLoginEvent>((event, emit) => emit(LoginState(loading: false)));

    //* Event to register a new app account
    on<RegisterEvent>(_registerEvent);

    //* Event to login with a code that is accessToken. It is allocated when previously logged in.
    on<LoginByAccessTokenEvent>(loginByAccessToken);

    on<InitRegisterEvent>((event, emit) => emit(RegisterState(loading: false)));

    //* Event to login by Google account
    on<GoogleLoginEvent>((event, emit) {});

    //* Event to login by Facebook account
    on<FacebookLoginEvent>((event, emit) {});

    //* Event to logout application
    on<LogoutEvent>(logoutEvent);
  }

  logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    event.socket.close();

    //* Check data User not null
    if (_authUser == null) return;

    //* Post request (email, password) to server, receive response value
    final value = await authRepository.getDataLogout(
      data: {'userID': _authUser!.user!.sId},
      header: {'Content-Type': 'application/json'},
    );

    //* Check reponse data of api
    if (value == null || value.result != 1) return;

    //* Logout App
    emit(LoginState(loading: false));

    //* Clear data of the user
    final shared = await sharedPreferences;
    shared.setString('auth_token', '');
  }

  _registerEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    //* Show loading popup
    emit(RegisterState(loading: true));

    //* Post request (email, password) to server, receive response value
    final valueRegister = await authRepository.getDataRegister(
      data: {
        'name': event.name,
        'email': event.email,
        'password': event.password,
      },
      header: {'Content-Type': 'application/json'},
    );

    //* Check correct value data
    if (valueRegister == null) {
      return emit(RegisterState(loading: false));
    }

    if (valueRegister.result != 1) {
      return emit(RegisterState(
        message: valueRegister.error?.message,
        loading: false,
      ));
    }

    /// Auto Login
    //* Post request (email, password) to server, receive response value

    final valueLogin = await authRepository.getDataLogin(
      data: {'email': event.email, 'password': event.password},
      header: {'Content-Type': 'application/json'},
    );

    //* Check correct value data
    if (valueLogin == null || valueLogin.result != 1) {
      emit(RegisterState(loading: false));
      return emit(LoginState(loading: false));
    }

    //* Store accessToken to login
    _authUser = authRepository.convertDynamicToObject(valueLogin.data[0]);

    //* Check accessToken before store
    if (_authUser!.accessToken != null &&
        _authUser!.accessToken!.accessToken != null) {
      //* Store accessToken to login
      final shared = await sharedPreferences;
      shared.setString('auth_token', _authUser!.accessToken!.accessToken ?? '');
    }

    //* Close loading popup
    emit(RegisterState(loading: false));
    emit(LoggedState(
      loading: false,
      authUser: _authUser,
      chatRooms: _authUser!.chatRooms,
      friendRequests: _authUser!.friendRequests,
      listFriend: _authUser!.listFriend,
    ));
  }

  normalLogin(NormalLoginEvent event, Emitter<AuthState> emit) async {
    //* Show loading popup
    emit(LoginState(loading: true));

    //* Post request (email, password) to server, receive response value
    final value = await authRepository.getDataLogin(
      data: {
        'email': event.email,
        'password': event.password,
        'deviceToken': event.deviceToken,
      },
      header: {'Content-Type': 'application/json'},
    );

    //* Check correct value data
    if (value == null || value.result != 1) {
      return emit(LoginState(loading: false, message: '????ng nh???p th???t b???i'));
    }

    //* Get data of the user
    _authUser = authRepository.convertDynamicToObject(value.data[0]);

    //* Close loading popup
    emit(LoginState(loading: false));

    //* Login success
    emit(LoggedState(
      loading: false,
      authUser: _authUser,
      chatRooms: _authUser!.chatRooms,
      friendRequests: _authUser!.friendRequests,
      listFriend: _authUser!.listFriend,
    ));

    //* Check accessToken before store
    if (_authUser != null && _authUser?.accessToken != null) {
      //* Store accessToken to login
      final shared = await sharedPreferences;
      shared.setString('auth_token', _authUser!.accessToken!.accessToken ?? '');
    }
  }

  loginByAccessToken(
    LoginByAccessTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    //* Show loading popup
    emit(LoginState(loading: true));

    //* Init data for request
    final shared = await sharedPreferences;
    final tokenUser = shared.getString('auth_token');

    //* Check data not null
    if (tokenUser == null || tokenUser.isEmpty) {
      return emit(LoginState(loading: false));
    }

    //* Post a request to the server, receive a response value
    final value = await authRepository.getDataLoginWithAccessToken(
      data: {},
      header: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenUser'
      },
    );

    //* Check value not null
    if (value == null || value.result != 1) {
      return emit(LoginState(loading: false));
    }
    //* Get data of the user
    _authUser = authRepository.convertDynamicToObject(value.data[0]);

    //* Login success
    emit(LoginState(loading: false));
    emit(LoggedState(
      loading: false,
      authUser: _authUser,
      chatRooms: _authUser!.chatRooms,
      friendRequests: _authUser!.friendRequests,
      listFriend: _authUser!.listFriend,
    ));
  }
}
