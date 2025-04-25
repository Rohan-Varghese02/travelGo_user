import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/widgets/logout_dailog.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const ProfileAppBar({
    Key? key,
    required this.title,
    this.showBack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
              title: Text(
                title,
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
            );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
