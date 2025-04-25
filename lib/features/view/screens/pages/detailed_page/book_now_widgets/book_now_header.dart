import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookNowHeader extends StatelessWidget {
  const BookNowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Choose Ticket',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 24),
        ),
        Divider(),
      ],
    );
  }
}
