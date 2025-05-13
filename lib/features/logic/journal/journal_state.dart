part of 'journal_bloc.dart';

@immutable
sealed class JournalState {}

final class JournalInitial extends JournalState {}

class JournalLoaded extends JournalState {
  final List<MapEntry<dynamic, JournalEntry>> entries;

  JournalLoaded(this.entries);
}
