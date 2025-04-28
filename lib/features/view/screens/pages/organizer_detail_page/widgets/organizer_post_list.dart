import 'package:flutter/material.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/widgets/post_list_tile.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class OrganizerPostList extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const OrganizerPostList({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StreamServices().getOrganizerPost(organizerData.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Center(child: StyleText(text: 'Noting posted yet!!'));
        }
        final organizerPost = snapshot.data;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: organizerPost!.length,
          itemBuilder: (context, index) {
            return PostListTile(postData: organizerPost[index]);
          },
        );
      },
    );
  }
}
