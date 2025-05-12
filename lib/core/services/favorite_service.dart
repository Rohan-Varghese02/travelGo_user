import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';

class FavoritesService {
  static final _firestore = FirebaseFirestore.instance;

  static Stream<List<PostDataModel>> getFavoritesStream(String userId) {
    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('favorites')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => PostDataModel.fromFirestore(doc))
              .toList();
        });
  }

  static Future<void> addToFavorites(String userId, PostDataModel post) async {
    await _firestore
        .collection('Users')
        .doc(userId)
        .collection('favorites')
        .doc(post.postId)
        .set(post.toMap());
  }

  static Future<void> removeFromFavorites(String userId, String postId) async {
    await _firestore
        .collection('Users')
        .doc(userId)
        .collection('favorites')
        .doc(postId)
        .delete();
  }

  static Future<bool> isFavorite(String userId, String postId) async {
    final doc =
        await _firestore
            .collection('Users')
            .doc(userId)
            .collection('favorites')
            .doc(postId)
            .get();
    return doc.exists;
  }

  static Future<List<PostDataModel>> getFavorites(String userId) async {
    final querySnapshot =
        await _firestore
            .collection('Users')
            .doc(userId)
            .collection('favorites')
            .orderBy('timestamp', descending: true)
            .get();

    return querySnapshot.docs
        .map((doc) => PostDataModel.fromFirestore(doc))
        .toList();
  }
}
