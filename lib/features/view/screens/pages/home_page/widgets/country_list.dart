import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class CountryList extends StatelessWidget {
  final void Function()? onTap;
  const CountryList({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StreamServices().countryCategoryStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: StyleText(
                text: 'No Category added',
                size: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        final categories = snapshot.data!;
        return SizedBox(
          height: 30,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: innerTheme,
                    border: Border.all(color: themeColor),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Center(child: StyleText(text: categories[index].name)),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
          ),
        );
      },
    );
  }
}
