import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class OrganizerHeader extends StatelessWidget {
  final int? folowers;
  final int? post;
  const OrganizerHeader({
    super.key,
    required this.folowers,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              StyleText(
                text: 'Members Following',
                size: 16,
                color: grey50,
                fontWeight: FontWeight.normal,
              ),
              StyleText(
                text: folowers.toString(),
                size: 22,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ],
          ),
          Column(
            children: [
              StyleText(
                text: 'Events Hosted',
                size: 16,
                fontWeight: FontWeight.normal,
                color: grey50,
              ),

              StyleText(
                text: post.toString(),
                size: 22,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
