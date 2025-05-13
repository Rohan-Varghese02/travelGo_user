// journal_detail_page.dart
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/hive_model/journal_entry.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class JournalDetailPage extends StatelessWidget {
  final JournalEntry entry;

  const JournalDetailPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Jorunal Entry',
        color: white,
        backgroundColor: themeColor,
        center: true,
        showBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CarouselSlider(
                items:
                    entry.imagePaths.map((path) {
                      return Image.file(
                        File(path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    }).toList(),
                options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
              SizedBox(height: 10),
              DottedBorder(
                color: themeColor,
                strokeWidth: 2,
                dashPattern: [6, 3],
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyleText(
                        text: entry.title,
                        fontWeight: FontWeight.bold,
                        size: 24,
                      ),
                      SizedBox(height: 10),
                      StyleText(text: entry.description, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
