part of 'nav_bloc.dart';

@immutable
sealed class NavEvent {}

class NavItemSelected extends NavEvent {
  final int index;

  NavItemSelected({required this.index});
}
