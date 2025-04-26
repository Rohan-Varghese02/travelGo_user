import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class ExploreHeaderProfile extends StatelessWidget {
  final String name;
  final String image;
  const ExploreHeaderProfile({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: greyprofile,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(backgroundImage: NetworkImage(image)),
              SizedBox(width: 10),
              StyleText(text: name)
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(border: Border(bottom: BorderSide())),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleText(text: 'Explore the',size: 45,fontWeight: FontWeight.w300,),
              Text.rich(
                TextSpan(
                  text: 'Beautiful ',
                  style: GoogleFonts.poppins(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'world!',
                      style: GoogleFonts.poppins(color: themeColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
