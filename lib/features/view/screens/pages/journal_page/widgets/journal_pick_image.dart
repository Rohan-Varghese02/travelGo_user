import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class JournalPickImage extends StatelessWidget {
  final void Function()? onTap;
  const JournalPickImage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        StyleText(text: 'Image', size: 16, fontWeight: FontWeight.w500),
        SizedBox(height: 2),
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            color: Colors.grey, // Border color
            strokeWidth: 2, // Border thickness
            dashPattern: [6, 3], // 6 is dash length, 3 is gap length
            borderType: BorderType.RRect, // Rounded rectangle
            radius: Radius.circular(12), // Optional: border radius
            child: Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.cameraRetro, size: 20, color: grey50),
                    SizedBox(width: 5),
                    StyleText(text: 'Upload photo', color: grey50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
