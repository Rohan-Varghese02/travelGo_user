import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/widgets/organizer_app_bar.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/widgets/organizer_live_update.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/widgets/organizer_post_list.dart';
import 'package:travelgo_user/features/view/widgets/heading_text.dart';
import 'package:travelgo_user/features/view/widgets/long_button.dart';
import 'package:travelgo_user/features/view/widgets/profile_avatar.dart';

class OrganizerDetailPage extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const OrganizerDetailPage({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrganizerAppBar(organizerData: organizerData),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileAvatar(url: organizerData.imageUrl),
              SizedBox(height: 10),
              OrganizerLiveUpdate(organizerData: organizerData),
              SizedBox(height: 10),
              HeadingText(text: 'Events Hosted', color: themeColor),
              SizedBox(height: 10),

              OrganizerPostList(organizerData: organizerData),
            ],
          ),
        ),
      ),
      floatingActionButton: LongButton(
        text: 'Follow',
        onPressed: () {},
        color: white,
      ),
    );
  }
}
