import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/features/logic/post/post_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/inactive_ticket_tile.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/ticket_tile.dart';

class TicketList extends StatefulWidget {
  final String? selectedTicketType;

  final Map<String, Map<String, dynamic>> tickets;

  const TicketList({super.key, required this.tickets, this.selectedTicketType});

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                widget.tickets.entries.map((ticketEntry) {
                  final ticketType = ticketEntry.key;
                  final int price = ticketEntry.value['price'];
                  final int count = ticketEntry.value['count'];
                  final isSelected = widget.selectedTicketType == ticketType;
                  return GestureDetector(
                    onTap: () {
                      context.read<PostBloc>().add(
                        SelectTicket(
                          ticketType: ticketType,
                          price: price,
                          count: count,
                        ),
                      );
                    },
                    child:
                        count == 0
                            ? InactiveTicketTile(
                              ticketType: ticketType,
                              price: price,
                              count: count,
                              isSelected: isSelected,
                            )
                            : TicketTile(
                              ticketType: ticketType,
                              price: price,
                              count: count,
                              isSelected: isSelected,
                            ),
                  );
                }).toList(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
