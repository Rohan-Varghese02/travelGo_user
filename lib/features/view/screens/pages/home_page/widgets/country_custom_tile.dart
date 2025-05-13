import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class CountryCustomTile extends StatelessWidget {
  final PostDataModel post;
  const CountryCustomTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: lightTheme,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: StyleText(
                        text: post.category,
                        color: themeColor,
                        size: 10,
                      ),
                    ),
                    SizedBox(height: 5),
                    StyleText(
                      text: post.name,
                      size: 17,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 5),

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
                  ],
                ),
              ],
            ),
            SizedBox(width: 20),
            Container(
              width: 41,
              height: 130,
              decoration: BoxDecoration(
                color: lightTheme,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: StyleText(
                    text: 'Book Now',
                    color: white,
                    fontWeight: FontWeight.bold,
                    size: 19,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
