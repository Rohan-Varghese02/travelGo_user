import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';

class OrganizerPanel extends StatelessWidget {
  final OrganizerDataModel? organizerData;
  final Function()? onTap;
  const OrganizerPanel({super.key, required this.organizerData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          //color: innerTheme,
          borderRadius: BorderRadius.circular(20),
          //border: Border.all(color: themeColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(organizerData!.imageUrl),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Organizer',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        organizerData!.name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 95,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeColor,
                    border: Border.all(color: themeColor),
                  ),
                  child: Center(
                    child: Text(
                      'Follow',
                      style: GoogleFonts.poppins(
                        color: white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
