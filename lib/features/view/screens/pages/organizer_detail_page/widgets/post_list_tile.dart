import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class PostListTile extends StatelessWidget {
  final PostDataModel postData;
  const PostListTile({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: themeColor, width: 0.4),
          bottom: BorderSide(color: themeColor, width: 0.4),
        ),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: NetworkImage(postData.imageUrl),
            width: 60,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        title: StyleText(
          text: postData.name,
          color: themeColor,
          fontWeight: FontWeight.w500,
          size: 20,
        ),
        subtitle: StyleText(text: postData.category, color: grey99),
        trailing: Icon(Icons.arrow_forward_ios, color: themeColor),
      ),
    );
  }
}
