import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool? center;
  final Color color;
  final bool showBack;
  final Color? backgroundColor;
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = false,
    required this.color,
    this.backgroundColor,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back, color: color),
      ),
      title: StyleText(
        text: title,
        color: color,
        size: 26,
        fontWeight: FontWeight.w500,
      ),
      automaticallyImplyLeading: showBack,
      actions: actions,
      centerTitle: center,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
