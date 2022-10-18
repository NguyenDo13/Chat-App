abstract class AuthEvent {
  // Events for user authentication
  const AuthEvent();
}

// Register a new account
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

// Login by account app
class NormalLoginEvent extends AuthEvent {
  final String email;
  final String password;
  NormalLoginEvent({
    required this.email,
    required this.password,
  });
}

// Login with a code
class LoginWithAccessTokenEvent extends AuthEvent {}

// Login by Google account
class GoogleLoginEvent extends AuthEvent {}

// Login by Facebook account
class FacebookLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
