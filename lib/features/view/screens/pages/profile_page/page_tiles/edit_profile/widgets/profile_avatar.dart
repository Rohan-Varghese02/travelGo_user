import 'dart:io';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final void Function()? onTap;
  final String? imagePath;
  final String imageUrl;

  const ProfileAvatar({
    super.key,
    required this.imagePath,
    required this.imageUrl, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 100,
        backgroundImage:
            imagePath != null
                ? FileImage(File(imagePath!))
                : NetworkImage(imageUrl),
      ),
    );
  }
}
