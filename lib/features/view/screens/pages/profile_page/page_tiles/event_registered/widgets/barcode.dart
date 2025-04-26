import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class Barcode extends StatelessWidget {
  const Barcode({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          StyleText(text: 'SCAN BARCODE', size: 19),
          SizedBox(height: 10),
          Image(
            image: NetworkImage(
              'https://lh3.googleusercontent.com/proxy/tWIdtv06_lcIheBJ3Pmh0YuJ-7H5zlyFQiwOB0Zb6NyTrHy_yfFiPSuOBlN8ic3b9YoH-r0fDcF3qktg65i5DSY9UOAFJ7me8bK-dNlcXYk',
            ),
            height: 90,
          ),
        ],
      ),
    );
  }
}
