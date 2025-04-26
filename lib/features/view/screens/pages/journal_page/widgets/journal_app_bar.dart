import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class JournalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  const JournalAppBar({super.key, required this.title, this.showBack = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: StyleText(text: 'Journal',size: 30,fontWeight: FontWeight.bold,)
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
