import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/core/services/stream_services.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/payment_and_payouts/widgets/payment_list.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';

class PaymentPage extends StatelessWidget {
  final UserDataModel userData;

  const PaymentPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment and Payouts',
        color: black,
        showBack: true,
      ),
      body: StreamBuilder<List<PaymentModel>>(
        stream: StreamServices().getReciept(userData.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final receipts = snapshot.data ?? [];

          return ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              final receipt = receipts[index];
              return PaymentList(receipt: receipt);
            },
          );
        },
      ),
    );
  }
}
