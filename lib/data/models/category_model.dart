import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
    final Timestamp timeStamp; // <-- add this

  Category({required this.id, required this.name,required this.timeStamp,});

  factory Category.fromFirestore(DocumentSnapshot doc) {
    return Category(id: doc.id, name: doc['name'],timeStamp: doc['timeStamp'] ?? Timestamp.now(), );
  }
}
