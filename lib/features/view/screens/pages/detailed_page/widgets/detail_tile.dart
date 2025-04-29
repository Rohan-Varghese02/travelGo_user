import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class DetailTile extends StatelessWidget {
  final String heading, assets, subtitle;
  final String? extra;

  const DetailTile({
    super.key,
    required this.heading,
    required this.assets,
    required this.subtitle,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: themeColor, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(assets, scale: 15, color: themeColor),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleText(
                text: heading,
                size: 18,
                color: white,
                fontWeight: FontWeight.bold,
              ),
              extra == null
                  ? StyleText(
                    text: subtitle,
                    fontWeight: FontWeight.w500,
                    size: 15,
                    color: white,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                  : StyleText(
                    text: '$subtitle, $extra',
                    size: 15,
                    color: white,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
