part of 'journal_bloc.dart';

@immutable
sealed class JournalEvent {}
class LoadJournalEntries extends JournalEvent {}

class AddJournalEntry extends JournalEvent {
  final JournalEntry entry;

  AddJournalEntry(this.entry);
}
class DeleteJournalEntry extends JournalEvent {
  final int key;
  DeleteJournalEntry(this.key);
}

class EditJournalEntry extends JournalEvent {
  final int key;
  final JournalEntry updatedEntry;
  EditJournalEntry({required this.key, required this.updatedEntry});
}