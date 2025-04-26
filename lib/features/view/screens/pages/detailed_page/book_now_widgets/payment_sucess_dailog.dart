import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

paymentSuccessDaiolg(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: white,
        content: SizedBox(
          height: 300,
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/check.png'),
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Congratulations!',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Your Order has been placed',
                style: GoogleFonts.poppins(
                  color: grey99,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: innerTheme,
                  foregroundColor: black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Go Back to Home Page',
                  style: GoogleFonts.poppins(color: white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
