import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/logic/user/user_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/wishlist/wishlist.dart';
import 'package:travelgo_user/features/view/widgets/border_list_tile.dart';

class ProfileList extends StatelessWidget {
  final UserDataModel userData;
  const ProfileList({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView(
        children: [
          BorderedListTile(
            title: 'Edit Profile',
            leadingIcon: FontAwesomeIcons.user,
            onTap: () {
              context.read<UserBloc>().add(
                FullProfileEvent(userData: userData),
              );
            },
          ),
          BorderedListTile(
            title: 'Wishlist',
            leadingIcon: FontAwesomeIcons.bookmark,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WishlistPage(userData: userData),
                ),
              );
            },
          ),
          BorderedListTile(
            title: 'Event Registered',
            leadingIcon: FontAwesomeIcons.calendarXmark,
            onTap: () {
              context.read<UserBloc>().add(
                EventRegisterClicked(userData: userData),
              );
            },
          ),
          BorderedListTile(
            title: 'Organizers Following',
            leadingIcon: FontAwesomeIcons.users,
            onTap: () {
              context.read<UserBloc>().add(
                OrganizerFollowingTile(userData: userData),
              );
            },
          ),
          BorderedListTile(
            title: 'Payment and Payouts',
            leadingIcon: FontAwesomeIcons.creditCard,
            onTap: () {
              context.read<UserBloc>().add(
                PaymentAndPayoutClicked(userData: userData),
              );
            },
          ),
        ],
      ),
    );
  }
}
