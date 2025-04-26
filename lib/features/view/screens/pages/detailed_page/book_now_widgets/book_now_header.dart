import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class BookNowHeader extends StatelessWidget {
  const BookNowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StyleText(text: 'Choose Ticket', fontWeight: FontWeight.w500, size: 24),
        Divider(),
      ],
    );
  }
}
