import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/widgets/logout_dailog.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/widgets/profile_info_text.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/widgets/profile_list.dart';
import 'package:travelgo_user/features/view/widgets/profile_avatar.dart';

class ProfilePage extends StatelessWidget {
  final UserDataModel userdata;
  const ProfilePage({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogoutApprove) {
                logoutDailog(context);
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
              icon: Icon(
                FontAwesomeIcons.rightFromBracket,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ProfileAvatar(url: userdata.imageUrl),
          SizedBox(height: 20),
          ProfileInfoText(name: userdata.name, email: userdata.email),
          Flexible(child: ProfileList()),
        ],
      ),
    );
  }
}
