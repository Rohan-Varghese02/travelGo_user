import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/organizers_following/widgets/organizer_following_tile.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class OrganizerFollowing extends StatelessWidget {
  final UserDataModel userdata;
  const OrganizerFollowing({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Organizers Following',
        color: white,
        backgroundColor: themeColor,
        showBack: true,
        center: true,
      ),
      body: StreamBuilder(
        stream: StreamServices().getOrganizerFollowing(userdata.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(
              child: StyleText(text: 'Follow some organizer to show here'),
            );
          }
          final organizers = snapshot.data!;
          return ListView.builder(
            itemCount: organizers.length,
            itemBuilder: (context, index) {
              final organzier = organizers[index];
              return OrganizerFollowingTile(
                organizerList: organzier,
                userID: userdata.uid,
              );
            },
          );
        },
      ),
    );
  }
}
