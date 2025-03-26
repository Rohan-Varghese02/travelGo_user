part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}


class FirstLoadingState extends SplashState{}

class LoadedState extends SplashState{

}

class UserLoadaedState extends SplashState{}