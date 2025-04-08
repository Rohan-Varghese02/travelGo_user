import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';

class CountryList extends StatelessWidget {
  final void Function()? onTap;
  const CountryList({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StreamServices().countryCategoryStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'No Category added',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        final categories = snapshot.data!;
        return SizedBox(
          height: 30,
          child: ListView.separated(
            // physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: innerTheme,
                    border: Border.all(color: themeColor),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Center(
                    child: Text(
                      categories[index].name,
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
          ),
        );
      },
    );
  }
}
