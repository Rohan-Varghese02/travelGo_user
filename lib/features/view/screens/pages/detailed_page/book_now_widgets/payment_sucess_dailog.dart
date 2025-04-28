import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

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
              StyleText(
                text: 'Congratulations!',
                size: 24,
                fontWeight: FontWeight.w500,
              ),
              StyleText(
                text: 'Your Order has been placed',
                size: 18,
                fontWeight: FontWeight.w500,
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
                },
                child: StyleText(text: 'Go Back to Home Page', color: white),
              ),
            ],
          ),
        ),
      );
    },
  );
}
