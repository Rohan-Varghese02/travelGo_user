import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class HeadingText extends StatelessWidget {
  final String text;
  const HeadingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return StyleText(text: text, size: 20,fontWeight: FontWeight.w500,);
  }
}
