import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/detail_tile.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/detailed_date.dart';

class EventDetails extends StatelessWidget {
  final String category, date, venue, country;
  const EventDetails({
    super.key,
    required this.category,
    required this.date,
    required this.venue,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: innerTheme,
          border: Border.all(color: themeColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DetailTile(
                heading: 'Event Type',
                assets: 'assets/calendar.png',
                subtitle: category,
              ),
              DetailTile(
                heading: 'Venue',
                assets: 'assets/location.png',
                subtitle: venue,
                extra: country,
              ),
              DetailedDate(date: date),
            ],
          ),
        ),
      ),
    );
  }
}
