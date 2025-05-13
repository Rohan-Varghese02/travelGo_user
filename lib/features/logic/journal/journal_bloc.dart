import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_user/data/hive_model/journal_entry.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final Box<JournalEntry> box;

  JournalBloc(this.box) : super(JournalInitial()) {
on<LoadJournalEntries>((event, emit) {
  final entries = box.toMap().entries.toList(); // Keeps keys
  emit(JournalLoaded(entries));
});

    on<AddJournalEntry>((event, emit) {
      box.add(event.entry);
      add(LoadJournalEntries());
    });
    on<DeleteJournalEntry>((event, emit) {
  box.delete(event.key);
  add(LoadJournalEntries());
});

on<EditJournalEntry>((event, emit) {
  box.put(event.key, event.updatedEntry);
  add(LoadJournalEntries());
});
  }
}
