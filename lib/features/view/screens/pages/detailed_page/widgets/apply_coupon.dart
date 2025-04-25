import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class ApplyCoupon extends StatelessWidget {
  const ApplyCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: themeColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: themeColor),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 70,
          height: 55,
          child: Center(
            child: Text(
              'Apply',
              style: GoogleFonts.poppins(
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
