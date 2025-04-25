import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class DetailTile extends StatelessWidget {
  final String heading, assets, subtitle;
  final String? extra;

  const DetailTile({
    super.key,
    required this.heading,
    required this.assets,
    required this.subtitle,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: lightTheme,
              border: Border.all(color: themeColor, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(assets, scale: 15, color: themeColor),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              extra == null
                  ? Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  )
                  : Text(
                    '$subtitle, $extra',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
