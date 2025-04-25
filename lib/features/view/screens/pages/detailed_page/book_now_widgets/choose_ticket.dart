import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/book_now_header.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/ticket_list.dart';

class ChooseTicket extends StatelessWidget {
  final Map<String, Map<String, dynamic>> tickets;
  final String? selectedTicketType;
  const ChooseTicket({super.key, required this.tickets, this.selectedTicketType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BookNowHeader(),
          SizedBox(height: 16),
          TicketList(
            tickets: tickets,
            selectedTicketType: selectedTicketType,
          ),
        ],
      ),
    );
  }
}

