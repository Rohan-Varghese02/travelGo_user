import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/blog_data.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class BlogTile extends StatelessWidget {
  final BlogData blogData;
  const BlogTile({super.key, required this.blogData});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(blogData.organizerImage)),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: themeColor,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage(blogData.imageUrl),
                    height: 400,

                    width: width * 0.85,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  StyleText(
                    text: blogData.blogDetails,
                    size: 20,
                    softWrap: true,
                    color: white,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
