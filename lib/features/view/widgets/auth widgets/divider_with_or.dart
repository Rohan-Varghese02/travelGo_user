import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class DividerWithOr extends StatelessWidget {
  const DividerWithOr({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: Colors.grey, thickness: 1),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          color: Colors.white,
          child: StyleText(text: 'Or', size: 16, color: grey99),
        ),
      ],
    );
  }
}
