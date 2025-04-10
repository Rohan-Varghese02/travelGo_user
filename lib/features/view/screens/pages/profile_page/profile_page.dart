import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_user/features/logic/user/user_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/full_profile/full_profile.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/widgets/logout_dailog.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/widgets/profile_info_text.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/widgets/profile_list.dart';
import 'package:travelgo_user/features/view/widgets/profile_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(FetchIntialDetails());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      buildWhen: (previous, current) => current is ProfileDetailsFetched,
      listener: (context, state) {
        log(state.runtimeType.toString());

        if (state is NavigateToFullProfile) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FullProfile(userData: state.userData),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileDetailsFetched) {
          final userData = state.userData;
          log(userData.imagePublicID);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
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
                ProfileAvatar(url: userData.imageUrl),
                SizedBox(height: 20),
                ProfileInfoText(name: userData.name, email: userData.email),
                Flexible(child: ProfileList(userData: userData)),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
