import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_user/data/models/category_model.dart';

class StreamServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Category>> countryCategoryStream() {
    return firestore
        .collection('categories')
        .where('type', isEqualTo: 'country')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList(),
        );
  }
}
