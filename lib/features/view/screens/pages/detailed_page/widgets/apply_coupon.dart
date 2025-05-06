import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class ApplyCoupon extends StatelessWidget {
    final String? Function(String?)? validator;
  final Function()? onTap;
  final TextEditingController controller;
  const ApplyCoupon({super.key, this.onTap, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            validator: validator,
            controller: controller,
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
        GestureDetector(
          onTap: onTap,
          child: Container(
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
        ),
      ],
    );
  }
}
