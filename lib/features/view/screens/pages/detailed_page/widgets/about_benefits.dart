import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class AboutBenefits extends StatelessWidget {
  final String about;
  final String benefits;
  const AboutBenefits({super.key, required this.about, required this.benefits});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: innerTheme,
          border: Border.all(color: themeColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event Details',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(about, style: GoogleFonts.poppins()),
              SizedBox(height: 5),
              Text(
                'Benefits:',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: black,
                ),
              ),
              Text(benefits, style: GoogleFonts.poppins()),
            ],
          ),
        ),
      ),
    );
  }
}
