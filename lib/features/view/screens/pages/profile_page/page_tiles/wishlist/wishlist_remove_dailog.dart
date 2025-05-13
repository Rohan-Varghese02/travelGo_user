import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/favorite_service.dart';
import 'package:travelgo_user/features/view/widgets/square_elevated_btn.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

void wishlistRemoveDailog(BuildContext context, String name, uid, postId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: StyleText(text: 'Remove Wishlist'),
        content: StyleText(
          text: 'Do you really want to remove this wishlist: $name ',
        ),
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
                text: 'Remove',
                radius: 10,
                color: white,
                onPressed: () async {
                  await FavoritesService.removeFromFavorites(uid, postId);
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
