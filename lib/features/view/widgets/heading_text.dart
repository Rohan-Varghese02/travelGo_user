import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingText extends StatelessWidget {
  final String text;
  const HeadingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
    );
  }
}
