import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class DetailedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isFavorite;
  final void Function()? onFavoriteToggle;
  const DetailedAppBar({
    super.key,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: StyleText(
        text: 'Event Details',
        size: 26,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back, color: white),
      ),
      backgroundColor: themeColor,
      actions: [
        IconButton(
          onPressed: onFavoriteToggle,
          icon:
              isFavorite
                  ? Icon(FontAwesomeIcons.solidHeart, color: redeError)
                  : Icon(FontAwesomeIcons.heart, color: white),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
