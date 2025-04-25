import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class DetailedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String postname;
  final String category;
  const DetailedAppBar({
    super.key,
    required this.postname,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Event Details',
        style: GoogleFonts.poppins(
          color: white,
          fontSize: 26,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back, color: white),
      ),
      backgroundColor: themeColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.heart, color: white),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
