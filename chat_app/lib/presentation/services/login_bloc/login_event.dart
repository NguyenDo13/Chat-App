// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LoginEvent {
  const LoginEvent();
}

class SimplyLoginEvent extends LoginEvent {
  final String email;
  final String password;
  SimplyLoginEvent({
    required this.email,
    required this.password,
  });
}

class LoginWithAccessToken extends LoginEvent {}

class LoginGoogleEvent extends LoginEvent {}

class LoginFacebookEvent extends LoginEvent {}

class LogoutEvent extends LoginEvent {}
