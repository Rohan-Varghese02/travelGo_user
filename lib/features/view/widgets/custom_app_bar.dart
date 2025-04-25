import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color color;
  final bool showBack;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBack = false, required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 26,
          fontWeight: FontWeight.w500,
        ),
      ),
      automaticallyImplyLeading: showBack,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
