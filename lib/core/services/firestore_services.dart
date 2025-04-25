import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/data/models/user_data.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> updateUserInFirestore(UserUpdateModel userData) async {
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

  Future<OrganizerDataModel> getOrganizer(String uid) async {
    final doc = await firestore.collection('Organizers').doc(uid).get();

    return OrganizerDataModel.fromMap(doc.data()!);
  }
}
