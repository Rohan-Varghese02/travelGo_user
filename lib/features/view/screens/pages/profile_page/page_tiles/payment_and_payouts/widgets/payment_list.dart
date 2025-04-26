import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class PaymentList extends StatelessWidget {
  final PaymentModel receipt;
  const PaymentList({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: themeColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(receipt.postImage),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(
                  text: receipt.postName,
                  size: 19,
                  fontWeight: FontWeight.w700,
                ),
                StyleText(
                  text: 'Ticket Type : ${receipt.ticketType}',
                  size: 15,
                  fontWeight: FontWeight.w400,
                ),
                StyleText(
                  text: 'Number of tickets : ${receipt.totalTickets}',
                  size: 14,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            StyleText(
              text: '₹ ${receipt.totalPrice}',
              size: 18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
