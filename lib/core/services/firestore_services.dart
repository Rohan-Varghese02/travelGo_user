import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_user/data/models/user_data.dart';

class FirestoreService {
  Future<void> updateUserInFirestore(UserUpdateModel userData) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Users')
        .doc(userData.uid)
        .update(userData.toMap());
  }

  Future<UserDataModel> getUser(String uid) async {
    final doc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    return UserDataModel.fromMap(doc.data()!);
  }
}
