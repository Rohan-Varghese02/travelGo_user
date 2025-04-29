import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/home_category/category_tile.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class HomeCategory extends StatelessWidget {
  final UserDataModel userdata;
  const HomeCategory({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StreamServices().categoryStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: StyleText(text: 'No Category'));
        }
        final category = snapshot.data;
        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: category!.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(
                  text: category[index].name,
                  fontWeight: FontWeight.bold,
                  size: 24,
                  color: black,
                ),
                SizedBox(height: 10),
                CategoryTile(
                  category: category[index].name,
                  userdata: userdata,
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
        );
      },
    );
  }
}
