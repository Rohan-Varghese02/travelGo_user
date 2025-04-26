import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class StyleText extends StatelessWidget {
  final TextDecoration? decoration;
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  const StyleText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color ?? black,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }
}
