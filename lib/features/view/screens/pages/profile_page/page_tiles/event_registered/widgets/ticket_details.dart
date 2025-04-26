import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class TicketDetails extends StatelessWidget {
  final String venue, country, date, ticketType;
  final int numberOfTickets;
  const TicketDetails({
    super.key,
    required this.venue,
    required this.country,
    required this.date,
    required this.ticketType,
    required this.numberOfTickets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(text: 'Location', size: 22),
        StyleText(
          text: '$venue, $country',
          size: 22,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(text: 'Ticket Type', size: 20),
                StyleText(
                  text: ticketType,
                  size: 22,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(text: 'No. of Tickets', size: 20),
                StyleText(
                  text: numberOfTickets.toString(),
                  size: 22,
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
