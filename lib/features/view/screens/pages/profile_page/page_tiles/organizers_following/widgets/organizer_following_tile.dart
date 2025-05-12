import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/organizer_list_data.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/organizers_following/widgets/organizer_follow_dailog.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class OrganizerFollowingTile extends StatelessWidget {
  final OrganizerListData organizerList;
  final String userID;
  const OrganizerFollowingTile({
    super.key,
    required this.organizerList,
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(organizerList.image),
        radius: 25,
      ),
      title: StyleText(text: organizerList.name),
      trailing: GestureDetector(
        onTap: () {
          organizerUnfollowDailog(
            context,
            organizerList.name,
            userID,
            organizerList.uid,
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: StyleText(text: 'Unfollow', color: white),
        ),
      ),
    );
  }
}
