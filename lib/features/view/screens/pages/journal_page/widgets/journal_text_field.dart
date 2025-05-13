import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class JournalTextField extends StatelessWidget {
  final TextEditingController descController;
  final String hint;
  final String headline;
  const JournalTextField({
    super.key,
    required this.descController,
    required this.hint,
    required this.headline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(text: headline, size: 16, fontWeight: FontWeight.w500),

        TextField(
          controller: descController,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: black),
            ),
            hintStyle: GoogleFonts.poppins(color: grey99, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
