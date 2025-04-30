import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/detailed_page.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';
import 'package:travelgo_user/features/view/widgets/text_fw.dart';

class HomePostTile extends StatelessWidget {
  final UserDataModel userData;
  final PostDataModel post;
  const HomePostTile({super.key, required this.post, required this.userData});

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    String originalDate = post.registrationDeadline;
    String formattedDate = formatDate(originalDate);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailedPage(post: post, userData: userData),
          ),
        );
      },
      child: SizedBox(
        height: 175,
        child: SizedBox(
          child: Column(
            children: [
              Container(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: NetworkImage(post.imageUrl),
                        width: 150,
                        height: 152,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    StyleText(
                      text: post.name,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    TextFw(firstword: 'Date: ', secondWord: formattedDate),
                    TextFw(firstword: 'Venue: ', secondWord: post.venue),
                    TextFw(
                      firstword: 'Price: ',
                      secondWord:
                          '₹${post.tickets.entries.first.value['price']}',
                    ),

                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: innerTheme,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: StyleText(text: 'Book Now', color: white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
