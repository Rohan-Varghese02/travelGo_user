import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';

class CustomListTile extends StatelessWidget {
  final int price;
  final PostDataModel post;
  const CustomListTile({super.key, required this.post, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage(post.imageUrl),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: lightTheme,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    post.category,
                    style: GoogleFonts.poppins(color: black, fontSize: 10),
                  ),
                ),
                Text(
                  post.name,
                  style: GoogleFonts.poppins(
                    color: black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Image(
                      image: AssetImage('assets/location.png'),
                      width: 20,
                      height: 20,
                      color: themeColor,
                    ),
                    SizedBox(width: 10),
                    Text('${post.venue}, ${post.country}'),
                  ],
                ),
                Text.rich(
                  TextSpan(
                    text: '₹$price',
                    style: GoogleFonts.poppins(color: themeColor, fontSize: 18),
                    children: [
                      TextSpan(
                        text: ' /person',
                        style: GoogleFonts.poppins(color: grey99, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
