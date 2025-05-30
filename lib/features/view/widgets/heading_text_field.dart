import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class HeadingTextField extends StatelessWidget {
  final String hint;
  final String headline;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  const HeadingTextField({
    super.key,
    required this.headline,
    required this.controller,
    required this.hint,
    this.validator,  this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(text: headline,size: 16,fontWeight: FontWeight.w500,),
        TextFormField(
          readOnly: readOnly ?? false,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: black),
            ),
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: grey99, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
