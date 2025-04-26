import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class DetailedBottom extends StatelessWidget {
  final int numberOfVariants;
  final void Function()? onPressed;
  const DetailedBottom({
    super.key,
    required this.numberOfVariants,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: themeColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tickets variants',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Available: $numberOfVariants',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: themeColor,
              foregroundColor: black,
            ),
            onPressed: onPressed,
            child: Text('Book Now', style: GoogleFonts.poppins(color: white)),
          ),
        ],
      ),
    );
  }
}
