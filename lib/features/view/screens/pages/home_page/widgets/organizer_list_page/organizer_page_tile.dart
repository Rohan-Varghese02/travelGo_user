import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/features/view/screens/pages/organizer_detail_page/organizer_detail_page.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class OrganizerPageTile extends StatelessWidget {
  final OrganizerDataModel organizerData;
  const OrganizerPageTile({super.key, required this.organizerData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: themeColor),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(organizerData.imageUrl),
          ),
          StyleText(
            text: organizerData.name,
            size: 20,
            fontWeight: FontWeight.bold,
          ),
          StyleText(
            text: '${organizerData.designation}, ${organizerData.company}',
            size: 14,
            fontWeight: FontWeight.w500,
            color: themeColor,
          ),
          StyleText(
            text: 'Follwers :${organizerData.followersCount}',
            size: 14,
            fontWeight: FontWeight.w500,
            color: themeColor,
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) =>
                          OrganizerDetailPage(organizerData: organizerData),
                ),
              );
            },
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: StyleText(text: 'View Profile', color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
