import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/event_registered/widgets/ticket_page.dart';

class EventRegisteredTile extends StatelessWidget {
  final PaymentModel receipt;

  const EventRegisteredTile({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      return DateFormat('MMM dd, yyyy').format(date).toUpperCase();
    }

    DateTime date = DateTime.parse(receipt.date);
    String formattedDate = formatDate(date);
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
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(receipt.postImage),
                    width: 70,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receipt.postName,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TicketPage(receipt: receipt),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(4),
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeColor,
                ),
                child: Center(
                  child: Text(
                    'View Ticket',
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
