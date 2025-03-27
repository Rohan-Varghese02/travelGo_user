import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class HeadingPasswordField extends StatefulWidget {
  final String headline;
  final String hint;
  final TextEditingController controller;
  final void Function()? onPressed;
  const HeadingPasswordField({
    super.key,
    required this.headline,
    required this.hint,
    required this.controller,
    required this.onPressed,
  });

  @override
  State<HeadingPasswordField> createState() => _HeadingPasswordFieldState();
}

class _HeadingPasswordFieldState extends State<HeadingPasswordField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.headline,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey20),
            ),
            hintText: widget.hint,
            hintStyle: GoogleFonts.poppins(color: grey99, fontSize: 16),
            suffixIcon:
                isVisible
                    ? IconButton(
                      icon: Icon(Icons.visibility_off_outlined),
                      color: grey99,
                      onPressed: widget.onPressed,
                    )
                    : IconButton(
                      icon: Icon(Icons.visibility_outlined),
                      color: grey99,
                      onPressed: widget.onPressed,
                    ),
          ),
        ),
      ],
    );
  }
}
