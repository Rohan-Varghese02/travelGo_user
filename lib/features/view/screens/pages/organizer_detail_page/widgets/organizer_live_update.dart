import 'package:flutter/material.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/widgets/organizer_header.dart';

class OrganizerLiveUpdate extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const OrganizerLiveUpdate({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrganizerDataModel>(
      stream: StreamServices().getOrganizerByUid(organizerData.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final organizer = snapshot.data!;
          return OrganizerHeader(
            folowers: organizer.followersCount,
            post: organizer.eventHosted!,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
