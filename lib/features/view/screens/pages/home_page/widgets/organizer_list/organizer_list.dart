import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/organizer_list/organizer_tile.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/organizer_list_page/organizer_list_page.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class OrganizerList extends StatelessWidget {
  const OrganizerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyleText(
              text: 'Organizer List',
              fontWeight: FontWeight.bold,
              size: 24,
              color: innerTheme,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OrganizerListPage()),
                );
              },
              child: StyleText(
                text: 'View more',
                fontWeight: FontWeight.w300,
                color: themeColor,
                size: 13,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        StreamBuilder(
          stream: StreamServices().getOrganizerHome(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: StyleText(text: 'No Organizer registered'));
            }
            final organizer = snapshot.data;
            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: organizer!.length,
                itemBuilder: (context, index) {
                  return OrganizerTile(organizerData: organizer[index]);
                },
                separatorBuilder: (context, index) => SizedBox(width: 10),
              ),
            );
          },
        ),
      ],
    );
  }
}
