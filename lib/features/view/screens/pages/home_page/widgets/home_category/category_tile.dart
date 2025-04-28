import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/home_category/home_post_tile.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class CategoryTile extends StatelessWidget {
  final UserDataModel userdata;
  final String category;
  const CategoryTile({
    super.key,
    required this.category,
    required this.userdata,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StreamServices().getPostCategory(category),
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
    );
  }
}
