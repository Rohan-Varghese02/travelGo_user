import 'package:cloud_firestore/cloud_firestore.dart';

class ChatData {
  final String organizerUid;
  final String organizerImage;
  final String organizerName;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final bool lastMessageBool;
  ChatData({
    required this.lastMessageBool,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.organizerUid,
    required this.organizerImage,
    required this.organizerName,
    req,
  });
  Map<String, dynamic> toMap() {
    return {
      'organizerUid': organizerUid,
      'organizerImage': organizerImage,
      'organizerName': organizerName,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastMessageBool': lastMessageBool,
    };
  }

  factory ChatData.fromFirestore(Map<String, dynamic> doc) {
    return ChatData(
      organizerUid: doc['organizerUid'] ?? '',
      organizerImage: doc['organizerImage'] ?? '',
      organizerName: doc['organizerName'] ?? '',
      lastMessage: doc['lastMessage'],
      lastMessageTime: doc['lastMessageTime'],
      lastMessageBool: doc['lastMessageBool'],
    );
  }
}
