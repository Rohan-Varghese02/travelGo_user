import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class DetailedDate extends StatelessWidget {
  final String date;
  const DetailedDate({super.key, required this.date});

  String monthAbbreviation(int month) {
    const months = [
      '',
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[month];
  }

  // Full weekday names
  String weekdayName(int weekday) {
    const weekdays = [
      '', // index 0 is unused
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[weekday];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    DateTime dateTime = DateTime.parse(date);
    int year = dateTime.year;
    int day = dateTime.day;
    String monthAbbrev = monthAbbreviation(dateTime.month);
    String weekday = weekdayName(dateTime.weekday);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: lightTheme,
              border: Border.all(color: themeColor, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  height: 30,
                  width: width,
                  color: themeColor,
                  child: Center(
                    child: Text(
                      monthAbbrev,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  day.toString(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$weekday, $year',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Time will be updated',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
