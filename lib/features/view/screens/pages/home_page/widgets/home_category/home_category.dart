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
          return const Center(child: StyleText(text: 'No Category'));
        }

        final categoryList = snapshot.data!;
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            final categoryName = categoryList[index].name;
            return StreamBuilder(
              stream: StreamServices().getPostCategory(categoryName),
              builder: (context, postSnapshot) {
                final posts = postSnapshot.data;

                if (!postSnapshot.hasData || posts == null || posts.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StyleText(
                          text: categoryName,
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
                                        categoryName,
                                      ),
                                      headline: categoryName,
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
                    const SizedBox(height: 10),
                    CategoryTile(category: categoryName, userdata: userdata),
                  ],
                );
              },
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 10),
        );
      },
    );
  }
}
