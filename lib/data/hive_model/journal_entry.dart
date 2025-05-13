// journal_entry.dart
import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 0)
class JournalEntry extends HiveObject {
  @HiveField(0)
  final List<String> imagePaths;

  @HiveField(1)
  final String title; // ✅ Add this

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime createdAt;

  JournalEntry({
    required this.imagePaths,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}
