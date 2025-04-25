import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class LandingHeader extends StatelessWidget {
  const LandingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Wrap(
      children: [
        Text(
          '"Where Will You GO Next?" ',
          style: GoogleFonts.poppins(fontSize: 55, fontWeight: FontWeight.w500),
        ),
        Text(
          '"Go Beyond Go ',
          style: GoogleFonts.poppins(fontSize: 55, fontWeight: FontWeight.w500),
        ),
        Text.rich(
          TextSpan(
            text: 'TravL',
            style: GoogleFonts.poppins(
              fontSize: 60,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: 'GO"',
                style: GoogleFonts.poppins(
                  fontSize: 55,
                  fontWeight: FontWeight.w500,
                  color: themeColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
