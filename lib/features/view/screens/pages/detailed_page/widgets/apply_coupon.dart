import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class ApplyCoupon extends StatelessWidget {
  const ApplyCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: themeColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: themeColor),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 70,
          height: 55,
          child: Center(
            child: StyleText(
              text: 'Apply',
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
