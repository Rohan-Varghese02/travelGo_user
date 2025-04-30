import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/home_category/category_tile.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/view_more.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyleText(
                      text: category[index].name,
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
                                  stream: StreamServices().getPostCategory(
                                    category[index].name,
                                  ),
                                  headline: category[index].name,
                                  userdata: userdata,
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
