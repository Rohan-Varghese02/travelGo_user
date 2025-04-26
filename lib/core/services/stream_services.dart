import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_user/data/models/category_model.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';

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

Stream<List<PaymentModel>> getReciept(String userId) {
  return firestore
      .collection('Users')
      .doc(userId)
      .collection('payments')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs
            .map((doc) => PaymentModel.fromFirestore(doc))
            .toList();
      });
}
  Stream<List<PostDataModel>> getFilteredPosts(
    String searchQuery, {
    String? category,
    String? country,
  }) {
    return FirebaseFirestore.instance.collection('post').snapshots().map((
      snapshot,
    ) {
      List<PostDataModel> allPosts =
          snapshot.docs.map((doc) {
            return PostDataModel.fromMap(doc.data(), doc.id);
          }).toList();

      String lowerQuery = searchQuery.toLowerCase();

      return allPosts.where((post) {
        final matchesSearch =
            searchQuery.isEmpty
                ? true
                : post.name.toLowerCase().contains(lowerQuery);

        final matchesCategory =
            category == null || category.isEmpty
                ? true
                : post.category.toLowerCase() == category.toLowerCase();

        final matchesCountry =
            country == null || country.isEmpty
                ? true
                : post.country.toLowerCase() == country.toLowerCase();

        return matchesSearch && matchesCategory && matchesCountry;
      }).toList();
    });
  }
}
