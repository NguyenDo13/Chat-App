import 'package:chat_app/data/models/auth_user.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoggedState extends LoginState {
  final AuthUser authUser;
  LoggedState(this.authUser);
}

class LogoutState extends LoginState {}
