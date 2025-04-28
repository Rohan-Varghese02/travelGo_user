import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/event_registered/widgets/event_registered_tile.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class EventRegistered extends StatelessWidget {
  final UserDataModel userData;
  const EventRegistered({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Event Registered',
        color: themeColor,
        showBack: true,
      ),
      body: StreamBuilder<List<PaymentModel>>(
        stream: StreamServices().getReciept(userData.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(
              child: StyleText(
                text: 'No purchases made !!',
                size: 24,
                fontWeight: FontWeight.bold,
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final receipts = snapshot.data ?? [];

          return ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              final receipt = receipts[index];
              return EventRegisteredTile(receipt: receipt);
            },
          );
        },
      ),
    );
  }
}
