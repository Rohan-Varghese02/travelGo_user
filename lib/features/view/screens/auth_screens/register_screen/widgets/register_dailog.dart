import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class RegisterDailog extends StatelessWidget {
  final void Function()? onPressed;
  const RegisterDailog({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Email already in use', style: GoogleFonts.poppins()),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: themeColor,
            foregroundColor: white,
          ),
          onPressed: onPressed,
          child: StyleText(text: 'Go back'),
        ),
      ],
    );
  }
}
