part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class IntialSplashEvent extends AuthEvent {}

class GetStartedNavigationEvent extends AuthEvent {}

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
