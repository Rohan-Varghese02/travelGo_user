import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class DetailedHeader extends StatelessWidget {
  final String group, name;
  const DetailedHeader({super.key, required this.group, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [themeColor, purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: 10,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                group,
                style: GoogleFonts.poppins(color: themeColor, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
