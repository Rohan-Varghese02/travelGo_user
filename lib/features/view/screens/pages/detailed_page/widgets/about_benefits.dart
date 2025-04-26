import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

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
              StyleText(
                text: 'Event Details',
                size: 20,
                fontWeight: FontWeight.bold,
                color: white,
              ),
              StyleText(text: about, color: white, fontWeight: FontWeight.w400),
              SizedBox(height: 5),
              StyleText(text: 'Benefits:', size: 18, color: white),
              StyleText(
                text: benefits,
                color: white,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
