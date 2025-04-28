part of 'nav_bloc.dart';

@immutable
sealed class NavState {
  final int index;

  NavState({required this.index});
}

final class NavInitial extends NavState {
  NavInitial() : super(index: 2);
}

class NavUpdated extends NavState {
  NavUpdated(int index) : super(index: index);
}
