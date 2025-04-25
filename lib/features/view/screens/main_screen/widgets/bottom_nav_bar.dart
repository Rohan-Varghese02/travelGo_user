import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/logic/nav/nav_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: themeColor,
            boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black12)],
          ),
          child: GNav(
            gap: 5,
            activeColor: themeColor,
            color: Colors.white,
            iconSize: 20,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: navbarSelectedColor,
            selectedIndex: state.index,
            onTabChange: (index) {
              context.read<NavBloc>().add(NavItemSelected(index: index));
            },
            tabs: [
              GButton(icon: FontAwesomeIcons.magnifyingGlass, text: 'Explore'),
              GButton(icon: FontAwesomeIcons.newspaper, text: 'Blog'),
              GButton(icon: FontAwesomeIcons.bookBookmark, text: 'Journal'),
              GButton(icon: FontAwesomeIcons.message, text: 'Chat'),
              GButton(icon: FontAwesomeIcons.user, text: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}
