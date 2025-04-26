import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/search_page/searchpage.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class SearchBox extends StatelessWidget {
  final UserDataModel userdata;
  const SearchBox({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Searchpage(userdata: userdata),
          ),
        );
      },
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.magnifyingGlass),
              SizedBox(width: 10),
              StyleText(text: 'Search for events', color: grey99),
            ],
          ),
        ),
      ),
    );
  }
}
