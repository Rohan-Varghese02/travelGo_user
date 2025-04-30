import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/ticket_arc_painter.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class InactiveTicketTile extends StatelessWidget {
  final String ticketType;
  final int price;
  final int count;
  final bool isSelected;
  const InactiveTicketTile({
    super.key,
    required this.ticketType,
    required this.price,
    required this.count,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 160,
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: grey99,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: grey50, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(color: grey50),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                    'assets/ticket.png',
                    scale: 20,
                    color: white,
                  ),
                ),
              ),
              SizedBox(height: 5),
              StyleText(
                text: ticketType,
                size: 20,
                fontWeight: FontWeight.w600,
                color: black,
              ),
              SizedBox(height: 2),
              StyleText(
                text:
                    'The number of ticket which are available: ${count.toString()}',
                size: 14,
              ),
              SizedBox(height: 1),

              Divider(color: grey20),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: '₹${price.toString()}',
                    style: GoogleFonts.poppins(fontSize: 15, color: black),
                    children: [
                      TextSpan(
                        text: '/Person',
                        style: GoogleFonts.poppins(fontSize: 12, color: grey99),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 145,
          left: 160,
          child: CustomPaint(
            size: Size(10, 20), // width x height
            painter: HalfCirclePainter(isSelected: false, isRight: true),
          ),
        ),
        Positioned(
          top: 145,
          left: 0,
          child: CustomPaint(
            size: Size(10, 20), // width x height
            painter: HalfCirclePainter(isSelected: false, isRight: false),
          ),
        ),
      ],
    );
  }
}
