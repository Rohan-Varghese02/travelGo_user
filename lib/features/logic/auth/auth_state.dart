part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

sealed class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

class FirstTimeLoading extends AuthState {}

class OnceLoadedState extends AuthState {}

class LoginPageNavigationState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserCredential userCredential;

  LoginSuccessState({required this.userCredential});
}

class LoginFailedState extends AuthState {
  final String error;

  LoginFailedState({required this.error});
}

class LogoutState extends AuthState {}

class NavigateToRegister extends AuthState {}

class VisibleState extends AuthActionState {
  final bool isVisible;

  VisibleState({required this.isVisible});
}

class GoogleLoginSucess extends AuthState {
  final UserCredential userCredential;

  GoogleLoginSucess({required this.userCredential});
}

class GoogleLoginFailure extends AuthState {
  final String error;

  GoogleLoginFailure({required this.error});
}
