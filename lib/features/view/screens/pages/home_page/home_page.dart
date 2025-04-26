import 'package:flutter/material.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/country_list.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/explore_header_profile.dart';
import 'package:travelgo_user/features/view/screens/pages/home_page/widgets/search_box.dart';
import 'package:travelgo_user/features/view/widgets/heading_text.dart';

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
                SearchBox(userdata: userdata,),
                SizedBox(height: 20),
                HeadingText(text: 'Countries'),
                SizedBox(height: 20),
                SizedBox(height: 50, child: CountryList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
