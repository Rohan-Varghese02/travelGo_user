// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String userUid;
  final String organizerUid;
  final int totalTickets;
  final int totalPrice;
  final String ticketType;
  final String postName;
  final String postID;
  final String postImage;
  final String country;
  final String venue;
  final String date;
  PaymentModel({
    required this.userUid,
    required this.organizerUid,
    required this.totalTickets,
    required this.totalPrice,
    required this.ticketType,
    required this.postName,
    required this.postID,
    required this.postImage,
    required this.country,
    required this.venue,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userUid': userUid,
      'organizerUid': organizerUid,
      'totalTickets': totalTickets,
      'totalPrice': totalPrice,
      'ticketType': ticketType,
      'postName': postName,
      'postID': postID,
      'postImage': postImage,
      'country': country,
      'venue': venue,
      'date': date,
    };
  }

  factory PaymentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PaymentModel(
      postImage: data['postImage'] ?? '',
      userUid: data['userUid'] ?? '',
      organizerUid: data['organizerUid'] ?? '',
      totalTickets: data['totalTickets'] ?? 0,
      totalPrice: data['totalPrice'] ?? 0,
      ticketType: data['ticketType'] ?? '',
      postName: data['postName'] ?? '',
      postID: data['postID'] ?? '',
      country: data['country'] ?? '',
      venue: data['venue'] ?? '',
      date: data['date'] ?? '',
    );
  }

  PaymentModel copyWith({
    String? userUid,
    String? organizerUid,
    int? totalTickets,
    int? totalPrice,
    String? ticketType,
    String? postName,
    String? postID,
    String? postImage,
    String? country,
    String? venue,
    String? date,
  }) {
    return PaymentModel(
      userUid: userUid ?? this.userUid,
      organizerUid: organizerUid ?? this.organizerUid,
      totalTickets: totalTickets ?? this.totalTickets,
      totalPrice: totalPrice ?? this.totalPrice,
      ticketType: ticketType ?? this.ticketType,
      postName: postName ?? this.postName,
      postID: postID ?? this.postID,
      postImage: postImage ?? this.postImage,
      country: country ?? this.country,
      venue: venue ?? this.venue,
      date: date ?? this.date,
    );
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      userUid: map['userUid'] as String,
      organizerUid: map['organizerUid'] as String,
      totalTickets: map['totalTickets'] as int,
      totalPrice: map['totalPrice'] as int,
      ticketType: map['ticketType'] as String,
      postName: map['postName'] as String,
      postID: map['postID'] as String,
      postImage: map['postImage'] as String,
      country: map['country'] as String,
      venue: map['venue'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentModel(userUid: $userUid, organizerUid: $organizerUid, totalTickets: $totalTickets, totalPrice: $totalPrice, ticketType: $ticketType, postName: $postName, postID: $postID, postImage: $postImage, country: $country, venue: $venue, date: $date)';
  }

  @override
  bool operator ==(covariant PaymentModel other) {
    if (identical(this, other)) return true;

    return other.userUid == userUid &&
        other.organizerUid == organizerUid &&
        other.totalTickets == totalTickets &&
        other.totalPrice == totalPrice &&
        other.ticketType == ticketType &&
        other.postName == postName &&
        other.postID == postID &&
        other.postImage == postImage &&
        other.country == country &&
        other.venue == venue &&
        other.date == date;
  }

  @override
  int get hashCode {
    return userUid.hashCode ^
        organizerUid.hashCode ^
        totalTickets.hashCode ^
        totalPrice.hashCode ^
        ticketType.hashCode ^
        postName.hashCode ^
        postID.hashCode ^
        postImage.hashCode ^
        country.hashCode ^
        venue.hashCode ^
        date.hashCode;
  }
}
