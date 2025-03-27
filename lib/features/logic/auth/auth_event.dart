part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class IntialSplashEvent extends AuthEvent{

}

class GetStartedNavigationEvent extends AuthEvent{
  
}
