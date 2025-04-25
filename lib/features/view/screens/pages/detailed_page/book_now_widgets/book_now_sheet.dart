import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/features/logic/post/post_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/book_now_header.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/choose_ticket_footer.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/ticket_list.dart';

class BookNowSheet extends StatefulWidget {
  final Map<String, Map<String, dynamic>> tickets;


  const BookNowSheet({super.key, required this.tickets,});

  @override
  _BookNowSheetState createState() => _BookNowSheetState();
}

class _BookNowSheetState extends State<BookNowSheet> {
  String? selectedTicketType;
  int? count;
  int? price;
  int ticketCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      buildWhen:
          (previous, current) =>
              current is TicketSelected ||
              current is IncrementedTicket ||
              current is DecrementedTicket,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is TicketSelected) {
          selectedTicketType = state.selectTicketType;
          price = state.price;
          count = state.count;
          ticketCount = 0;
        }
        if (state is IncrementedTicket) {
          ticketCount = state.ticketCount;
        }
        if (state is DecrementedTicket) {
          ticketCount = state.ticketCount;
        }
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
                tickets: widget.tickets,
                selectedTicketType: selectedTicketType,
              ),

              SizedBox(height: 24),
              selectedTicketType != null && count != null
                  ? ChooseTicketFooter(
                    price: price!,
                    count: count!,
                    selectedTicketType: selectedTicketType,
                    ticketCount: ticketCount,
                  )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
