import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> updateUserInFirestore(UserUpdateModel userData) async {
    await firestore
        .collection('Users')
        .doc(userData.uid)
        .update(userData.toMap());
  }

  Future<void> paymentRecipetinFiresttore(PaymentModel payment) async {
    await firestore
        .collection('Users')
        .doc(payment.userUid)
        .collection('payments')
        .doc()
        .set(payment.toMap());
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

  Future<void> updateTicketCount({
    required String postId,
    required String ticketType,
    required int quantityToBuy,
  }) async {
    final postRef = FirebaseFirestore.instance.collection('post').doc(postId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      log('Ticket Updating');
      final snapshot = await transaction.get(postRef);

      if (!snapshot.exists) {
        throw Exception("Post not found");
      }

      final data = snapshot.data();
      if (data == null || data['tickets'] == null) {
        throw Exception("Tickets data not found");
      }

      final tickets = Map<String, dynamic>.from(data['tickets']);
      final ticketDetails = Map<String, dynamic>.from(tickets[ticketType]);

      final currentCount = ticketDetails['count'];
      if (currentCount < quantityToBuy) {
        throw Exception("Not enough tickets available");
      }

      ticketDetails['count'] = currentCount - quantityToBuy;
      tickets[ticketType] = ticketDetails;

      transaction.update(postRef, {'tickets': tickets});
    });
  }

  Future<void> updateRevenueAfterPurchase({
    required String organizerUid,
    required String postId,
    required String ticketType,
    required int quantity,
    required int totalPrice,
  }) async {
    final revenueRef = FirebaseFirestore.instance
        .collection('revenue')
        .doc(organizerUid)
        .collection('posts')
        .doc(postId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(revenueRef);

      if (!snapshot.exists) return;

      final data = snapshot.data()!;
      final currentTotalRevenue = data['totalRevenue'] ?? 0;
      final currentTotalTicketsSold = data['totalTicketsSold'] ?? 0;

      final currentTicketTypeData =
          (data['revenueByTicketType'] ?? {})[ticketType] ??
          {'revenue': 0, 'soldCount': 0};

      final updatedTicketTypeData = {
        'revenue': (currentTicketTypeData['revenue'] ?? 0) + totalPrice,
        'soldCount': (currentTicketTypeData['soldCount'] ?? 0) + quantity,
      };

      transaction.update(revenueRef, {
        'totalRevenue': currentTotalRevenue + totalPrice,
        'totalTicketsSold': currentTotalTicketsSold + quantity,
        'revenueByTicketType.$ticketType': updatedTicketTypeData,
      });
    });
  }

  Future<void> organizerMessage(
    String organizerUid,
    organizerImage,
    organizerName,
    userId,
    lastMessage, Timestamp lastMessageTime
  ) async {
    return firestore
        .collection('OrganizerChatrooms')
        .doc(userId)
        .collection('Organizers')
        .doc(organizerUid)
        .set({
          'organizerUid': organizerUid,
          'organizerImage': organizerImage,
          'organizerName': organizerName,
          'lastMessage':lastMessage,
          'lastMessageTime':Timestamp.now(),
                    'lastMessageBool':true,

        });
  }

  Future<void> userMessage(
    String userUid,
    userImage,
    userName,
    organizerUid,
    lastMessage, Timestamp lastMessageTime
  ) async {
    return firestore
        .collection('UserChatrooms')
        .doc(organizerUid)
        .collection('Users')
        .doc(userUid)
        .set({
          'userUid': userUid,
          'userImage': userImage,
          'userName': userName,
           'lastMessage':lastMessage,
          'lastMessageTime':Timestamp.now(),
          'lastMessagebool':true,
        });
  }
}
