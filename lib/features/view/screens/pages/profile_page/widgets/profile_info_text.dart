import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class ProfileInfoText extends StatelessWidget {
  final String name;
  final String email;
  const ProfileInfoText({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          StyleText(text: name, size: 20, fontWeight: FontWeight.bold),
          SizedBox(height: 5),
          StyleText(
            text: email,
            size: 16,
            fontWeight: FontWeight.bold,
            color: grey99,
          ),
        ],
      ),
    );
  }
}
