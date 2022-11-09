// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthEvent {
  //) Events for user authentication
  const AuthEvent();
}

//* Register a new account
class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class InitRegisterEvent extends AuthEvent {}

//* Login by account app
class NormalLoginEvent extends AuthEvent {
  final String email;
  final String password;
  final String deviceToken;
  NormalLoginEvent({
    required this.email,
    required this.password,
    required this.deviceToken,
  });
}

class InitLoginEvent extends AuthEvent {}

//* Login with a code
class LoginByAccessTokenEvent extends AuthEvent {}

//* Login by Google account
class GoogleLoginEvent extends AuthEvent {}

//* Login by Facebook account
class FacebookLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {
  final dynamic socket;
  LogoutEvent({
    required this.socket,
  });
}
