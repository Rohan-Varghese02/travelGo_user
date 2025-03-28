part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class IntialSplashEvent extends AuthEvent {}

class GetStartedNavigationEvent extends AuthEvent {}

// Login Screen
class CheckLoginEvent extends AuthEvent {
  final String email;
  final String password;

  CheckLoginEvent({required this.email, required this.password});
}

class LogOutButtonClicked extends AuthEvent {}

class JoinButtonClicked extends AuthEvent {}

class VisibillityButtonClicked extends AuthEvent {
  final bool isVisible;

  VisibillityButtonClicked({required this.isVisible});
}

//Google Sigin
class GoogleSignInEvent extends AuthEvent {}

/// Register Screen
class AlreadyMemeber extends AuthEvent {}

class RegisterButtonEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterButtonEvent({required this.email, required this.password, required this.confirmPassword});
}
