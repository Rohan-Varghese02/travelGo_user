import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/ticket_arc_painter.dart';

class TicketTile extends StatefulWidget {
  final String ticketType;
  final int price;
  final int count;
  final bool isSelected;
  const TicketTile({
    super.key,
    required this.ticketType,
    required this.price,
    required this.count,
    required this.isSelected,
  });

  @override
  State<TicketTile> createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 160,
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:
                widget.isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isSelected ? themeColor : grey20,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.isSelected ? lightTheme : grey20,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                    'assets/ticket.png',
                    scale: 20,
                    color: widget.isSelected ? darkthemeColor : black,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                widget.ticketType,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: widget.isSelected ? Colors.blue : Colors.black,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'The number of ticket which are available: ${widget.count.toString()}',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              SizedBox(height: 1),

              Divider(color: widget.isSelected ? themeColor : grey20),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: '₹${widget.price.toString()}',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: widget.isSelected ? darkthemeColor : black,
                    ),
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
            painter: HalfCirclePainter(
              isSelected: widget.isSelected,
              isRight: true,
            ),
          ),
        ),
        Positioned(
          top: 145,
          left: 0,
          child: CustomPaint(
            size: Size(10, 20), // width x height
            painter: HalfCirclePainter(
              isSelected: widget.isSelected,
              isRight: false,
            ),
          ),
        ),
      ],
    );
  }
}
