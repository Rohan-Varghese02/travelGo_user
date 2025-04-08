import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/border_list_tile.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView(
        children: [
          BorderedListTile(
            title: 'Profile',
            leadingIcon: FontAwesomeIcons.user,
            onTap: () {},
          ),
          BorderedListTile(
            title: 'Wishlist',
            leadingIcon: FontAwesomeIcons.bookmark,
            onTap: () {},
          ),
          BorderedListTile(
            title: 'Event Registered',
            leadingIcon: FontAwesomeIcons.calendarXmark,
            onTap: () {},
          ),
          BorderedListTile(
            title: 'Organizers Following',
            leadingIcon: FontAwesomeIcons.users,
            onTap: () {},
          ),
          BorderedListTile(
            title: 'Payment and Payouts',
            leadingIcon: FontAwesomeIcons.creditCard,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
