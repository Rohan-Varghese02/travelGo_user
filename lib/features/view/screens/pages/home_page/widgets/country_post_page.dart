import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/detailed_page.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/country_custom_tile.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class CountryPostPage extends StatelessWidget {
  final UserDataModel userData;
  final String nameOfCountry;
  const CountryPostPage({
    super.key,
    required this.nameOfCountry,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: nameOfCountry,
        color: themeColor,
        showBack: true,
      ),
      body: StreamBuilder(
        stream: StreamServices().getPostCategoryCountry(nameOfCountry),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(
              child: StyleText(text: 'No post available for this country'),
            );
          }
          final post = snapshot.data;
          return ListView.builder(
            itemCount: post!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          ((context) => DetailedPage(
                            post: post[index],
                            userData: userData,
                          )),
                    ),
                  );
                },
                child: CountryCustomTile(post: post[index]),
              );
            },
          );
        },
      ),
    );
  }
}
