import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class BorderedListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final VoidCallback onTap;
  final IconData? trailingIcon;
  final Color borderColor;

  const BorderedListTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.trailingIcon = FontAwesomeIcons.chevronRight,
    this.borderColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        leading: Icon(leadingIcon, color: themeColor),
        title: StyleText(text: title,color: black,),
        trailing: Icon(trailingIcon, color: grey30),
      ),
    );
  }
}
