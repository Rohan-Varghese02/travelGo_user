part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class FirstTimeLoading extends AuthState{

}
class OnceLoadedState extends AuthState{

}

class LoginPageNavigationState extends AuthState{}