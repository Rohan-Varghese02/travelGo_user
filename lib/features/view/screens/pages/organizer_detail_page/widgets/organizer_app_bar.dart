import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class OrganizerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final OrganizerDataModel organizerData;

  const OrganizerAppBar({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyleText(text: 'Organizer', color: themeColor),
          StyleText(
            text: '${organizerData.designation} of ${organizerData.company}',
            color: themeColor,
            size: 14,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
