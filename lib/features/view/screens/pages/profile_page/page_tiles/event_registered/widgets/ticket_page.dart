import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/event_registered/widgets/barcode.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/event_registered/widgets/ticket_circle_painter.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/event_registered/widgets/ticket_details.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class TicketPage extends StatelessWidget {
  final PaymentModel receipt;

  const TicketPage({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: CustomAppBar(
        backgroundColor: themeColor,
        title: 'My Ticket',
        color: white,
        showBack: true,
        center: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Container(
                height: height * 0.8,
                decoration: BoxDecoration(
                  color: lightTheme,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                          width: double.infinity,
                          height: 300,
                          image: NetworkImage(receipt.postImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 15),
                      StyleText(
                        text: receipt.postName,
                        size: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 10),
                      Divider(color: themeColor),
                      SizedBox(height: 10),
                      TicketDetails(
                        venue: receipt.venue,
                        country: receipt.country,
                        date: receipt.date,
                        ticketType: receipt.ticketType,
                        numberOfTickets: receipt.totalTickets, price: receipt.totalPrice,
                      ),
                      SizedBox(height: 25),
                      Divider(color: themeColor),
                      SizedBox(height: 10),
                      Barcode(),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 370,
                left: 0,
                child: CustomPaint(
                  size: Size(10, 20),
                  painter: TicketCirclePainter(isRight: false),
                ),
              ),
              Positioned(
                top: 370,
                right: -10,
                child: CustomPaint(
                  size: Size(10, 20),
                  painter: TicketCirclePainter(isRight: true),
                ),
              ),
              Positioned(
                bottom: 150,
                left: 0,
                child: CustomPaint(
                  size: Size(10, 20),
                  painter: TicketCirclePainter(isRight: false),
                ),
              ),
              Positioned(
                bottom: 150,
                right: -10,
                child: CustomPaint(
                  size: Size(10, 20),
                  painter: TicketCirclePainter(isRight: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
