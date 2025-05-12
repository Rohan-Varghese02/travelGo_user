import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/features/logic/user/user_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/event_registered/event_register.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/full_profile/full_profile.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/organizers_following/organizer_following.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/payment_and_payouts/payment_page.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/widgets/profile_app_bar.dart';
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
        if (state is NavigatePaymentPayout) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentPage(userData: state.userData),
            ),
          );
        }
        if (state is NavigateEventRegistered) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventRegistered(userData: state.userData),
            ),
          );
        }
        if (state is NavigateToOrganizerFollow) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => OrganizerFollowing(userdata: state.userData),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileDetailsFetched) {
          final userData = state.userData;
          log(userData.imagePublicID);

          return Scaffold(
            appBar: ProfileAppBar(title: 'Profile'),
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
