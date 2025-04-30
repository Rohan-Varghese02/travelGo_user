import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/user_data.dart';

import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/home_category/home_post_tile.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/view_more.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class FeaturedList extends StatelessWidget {
  final UserDataModel userdata;

  const FeaturedList({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyleText(
              text: 'Featured',
              fontWeight: FontWeight.bold,
              size: 24,
              color: black,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => ViewMore(
                          stream: StreamServices().featuredStream(),
                          headline: 'Featured', userdata: userdata,
                        ),
                  ),
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
          stream: StreamServices().featuredStream(),
          builder: (context, snapshot) {
            log(snapshot.toString());
            if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return SizedBox(
                height: 150,
                child: Center(child: StyleText(text: 'No post available')),
              );
            }
            final post = snapshot.data;
            return SizedBox(
              height: 290,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: post!.length,
                itemBuilder: (context, index) {
                  return HomePostTile(post: post[index], userData: userdata);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
