import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/features/logic/post/post_bloc.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class ChooseTicketFooter extends StatelessWidget {
  final String postName;
  final String postID;
  final String organizerUid;
  final String userUid;
  final String? selectedTicketType;
  final int ticketCount;
  final int count;
  final int price;
  final String postImage, country, venue, date;
  const ChooseTicketFooter({
    super.key,
    this.selectedTicketType,
    required this.ticketCount,
    required this.count,
    required this.price,
    required this.userUid,
    required this.organizerUid,
    required this.postName,
    required this.postID,
    required this.postImage,
    required this.country,
    required this.venue,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyleText(text: 'Number of seats', size: 18),
            Row(
              children: [
                gestureControl(
                  icon: Icon(Icons.remove),
                  color: grey20,
                  onTap: () {
                    if (ticketCount > 0) {
                      context.read<PostBloc>().add(
                        DecrementTicket(ticketCount: ticketCount),
                      );
                    }
                  },
                ),
                SizedBox(width: 10),
                Text(ticketCount.toString()),
                SizedBox(width: 10),
                gestureControl(
                  icon: Icon(Icons.add, color: white),
                  color: themeColor,
                  onTap: () {
                    if (ticketCount < count) {
                      context.read<PostBloc>().add(
                        IncrementTicket(ticketCount: ticketCount),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        StyleText(text: 'Total Amount : ₹${price * ticketCount}', size: 18),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: themeColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed:
                selectedTicketType == null || ticketCount == 0
                    ? null
                    : () {
                      log(userUid);
                      log(organizerUid);
                      int totalPrice = price * ticketCount;
                      PaymentModel payment = PaymentModel(
                        postImage: postImage,
                        userUid: userUid,
                        organizerUid: organizerUid,
                        totalTickets: ticketCount,
                        totalPrice: totalPrice,
                        ticketType: selectedTicketType!,
                        postName: postName,
                        postID: postID,
                        country: country,
                        venue: venue,
                        date: date,
                        timestamp: Timestamp.now(),
                      );
                      context.read<PostBloc>().add(
                        PaymentIntiate(
                          totalPrice: totalPrice,
                          paymentData: payment,
                        ),
                      );
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor: innerTheme,
              foregroundColor: black,
              padding: EdgeInsets.symmetric(horizontal: 130, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:
                count != 0
                    ? StyleText(
                      text: 'Continue',
                      fontWeight: FontWeight.w500,
                      color: white,
                    )
                    : StyleText(
                      text: 'Full Booked',
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
          ),
        ),
      ],
    );
  }
}

Widget gestureControl({
  required Icon icon,
  required Color color,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: icon,
    ),
  );
}
