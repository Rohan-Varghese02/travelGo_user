import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class TicketDetails extends StatelessWidget {
  final String venue, country, date, ticketType;
  final int numberOfTickets;
  final int price;
  const TicketDetails({
    super.key,
    required this.venue,
    required this.country,
    required this.date,
    required this.ticketType,
    required this.numberOfTickets,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(text: 'Location', size: 19),
                StyleText(
                  text: '$venue, $country',
                  size: 19,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                StyleText(text: 'No. of Tickets', size: 19),
                StyleText(
                  text: numberOfTickets.toString(),
                  size: 19,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                StyleText(text: 'Ticket Type', size: 19),
                StyleText(
                  text: ticketType,
                  size: 19,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                StyleText(text: 'Price', size: 19),
                StyleText(
                  text: '₹ $price',
                  size: 19,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
