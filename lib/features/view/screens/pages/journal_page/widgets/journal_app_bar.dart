import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  const JournalAppBar({super.key, required this.title, this.showBack = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Journal',
        style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
