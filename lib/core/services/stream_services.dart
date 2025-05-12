import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_user/data/models/blog_data.dart';
import 'package:travelgo_user/data/models/category_model.dart';
import 'package:travelgo_user/data/models/chat_data.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/data/models/organizer_list_data.dart';
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

  Stream<OrganizerDataModel> getOrganizerByUid(String uid) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collection('Organizers')
        .doc(uid)
        .snapshots()
        .map((doc) => OrganizerDataModel.fromFireStore(doc));
  }

  Stream<List<OrganizerDataModel>> getOrganizerHome() {
    return firestore
        .collection('Organizers')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => OrganizerDataModel.fromFireStore(doc))
                  .toList(),
        );
  }

  Stream<List<PostDataModel>> getOrganizerPost(uid) {
    return firestore
        .collection('post')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => PostDataModel.fromFirestore(doc))
                  .toList(),
        );
  }

  Stream<List<PostDataModel>> getPostCategoryCountry(String country) {
    return firestore
        .collection('post')
        .where('country', isEqualTo: country)
        .snapshots()
        .map(
          (snaphot) =>
              snaphot.docs
                  .map((doc) => PostDataModel.fromFirestore(doc))
                  .toList(),
        );
  }

  Stream<List<Category>> categoryStream() {
    return firestore
        .collection('categories')
        .where('type', isEqualTo: 'event')
        .snapshots()
        .map((snapshot) {
          List<Category> categories =
              snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
          categories.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));

          return categories;
        });
  }

  Stream<List<PostDataModel>> getPostCategory(String category) {
    return firestore
        .collection('post')
        .where('category', isEqualTo: category)
        .snapshots()
        .map(
          (snaphot) =>
              snaphot.docs
                  .map((doc) => PostDataModel.fromFirestore(doc))
                  .toList(),
        );
  }

  Stream<List<PostDataModel>> featuredStream() {
    return firestore
        .collection('post')
        .where('isFeatured', isEqualTo: true)
        .snapshots()
        .map(
          (snaphot) =>
              snaphot.docs
                  .map((doc) => PostDataModel.fromFirestore(doc))
                  .toList(),
        );
  }

  Stream<List<PaymentModel>> getReciept(String userId) {
    return firestore
        .collection('Users')
        .doc(userId)
        .collection('payments')
        .orderBy('timestamp', descending: true)
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

  Stream<List<BlogData>> getBlog() {
    return firestore.collection('Blogs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BlogData.fromMap(doc.data())).toList();
    });
  }

  Stream<List<ChatData>> getChat(String userId) {
    return firestore
        .collection('OrganizerChatrooms')
        .doc(userId)
        .collection('Organizers')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatData.fromFirestore(doc.data()))
              .toList();
        });
  }

  Stream<List<OrganizerListData>> getOrganizerFollowing(String userUid) {
    return firestore
        .collection('Users')
        .doc(userUid)
        .collection('following')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => OrganizerListData.fromFirestore(doc.data()))
              .toList();
        });
  }
}
