// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/data/models/auth_user.dart';

abstract class AuthState {
  // Authenticate to use the application.
  const AuthState();
}

// That is state when await a auth event
class AuthLoadingState extends AuthState {}

// That is state when the user have to register account to be used application.
class RegisterState extends AuthState {
  final String? message;
  final bool loading;
  RegisterState({
    required this.loading,
    this.message,
  });
}

// That is state when await a register event
class RegisterLoadingState extends AuthState {}

// That is state when the user has not logged in to the application yet.
class LoginState extends AuthState {
  bool loading;
  LoginState({
    required this.loading,
  });
}

// That is state when the user has logged in to the application.
class LoggedState extends AuthState {
  final AuthUser authUser;
  LoggedState(this.authUser);
}

// That is state when the user has logged out to the application.
class LogoutState extends AuthState {}
