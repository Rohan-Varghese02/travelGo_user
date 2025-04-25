import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String url;
  const ProfileAvatar({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.grey[300],
        backgroundImage: NetworkImage(url),
      ),
    );
  }
}
