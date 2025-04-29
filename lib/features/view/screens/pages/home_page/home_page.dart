import 'package:flutter/material.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/country_list.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/explore_header_profile.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/featured_list/featured_list.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/home_category/home_category.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/organizer_list/organizer_list.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/search_box.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class HomePage extends StatelessWidget {
  final UserDataModel userdata;
  const HomePage({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExploreHeaderProfile(
                  name: userdata.name,
                  image: userdata.imageUrl,
                ),
                SizedBox(height: 20),
                SearchBox(userdata: userdata),
                SizedBox(height: 20),
                StyleText(
                  text: 'Countries',
                  size: 24,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                SizedBox(height: 50, child: CountryList(userdata: userdata)),
                SizedBox(height: 20),
                FeaturedList(userdata: userdata),
                SizedBox(height: 20),
                OrganizerList(),
                SizedBox(height: 20),
                HomeCategory(userdata: userdata),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
