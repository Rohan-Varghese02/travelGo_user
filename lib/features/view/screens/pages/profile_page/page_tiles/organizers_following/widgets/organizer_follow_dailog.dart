import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/firestore_services.dart';
import 'package:travelgo_user/features/view/widgets/square_elevated_btn.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

void organizerUnfollowDailog(
  BuildContext context,
  String name,
  String userId,
  String organizerId,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: StyleText(text: 'Unfollow Organizer'),
        content: StyleText(text: 'Do you really want to Unfollow this $name'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SquareElevatedBtn(
                text: 'Cancel',
                radius: 10,
                color: black,
                backgroundColor: white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SquareElevatedBtn(
                text: 'Unfollow',
                radius: 10,
                color: white,
                onPressed: () async {
                  await FirestoreService().removeOrganizer(userId, organizerId);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
