import 'package:chat_app/data/models/auth_user.dart';

abstract class AuthState {
  // Authenticate to use the application.
  const AuthState();
}

// That is state when the user has not logged in to the application yet.
class LoginState extends AuthState {}

// That is state when await a event of login from the application
class LoginLoadingState extends AuthState {}

// That is state when the user have to register account to be used application.
class RegisterState extends AuthState {}

// That is state when the user has logged in to the application.
class LoggedState extends AuthState {
  final AuthUser authUser;
  LoggedState(this.authUser);
}

// That is state when the user has logged out to the application.
class LogoutState extends AuthState {}
