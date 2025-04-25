import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stripe_services.dart';
import 'package:travelgo_user/features/logic/post/post_bloc.dart';

class ChooseTicketFooter extends StatelessWidget {
  final String? selectedTicketType;
  final int ticketCount;
  final int count;
  final int price;
  const ChooseTicketFooter({
    super.key,
    this.selectedTicketType,
    required this.ticketCount,
    required this.count,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Number of seats', style: GoogleFonts.poppins(fontSize: 18)),
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
        Text('Total Amount : ${price * ticketCount}'),
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
                    : () async {
                      int totalPrice = price * ticketCount;
                      String? paymentID = await StripeServices.instance
                          .makePayment(totalPrice);

                      log(
                        'Proceeding with: $selectedTicketType, $totalPrice, payment ID: $paymentID',
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
            child: Text(
              "Continue",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
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
