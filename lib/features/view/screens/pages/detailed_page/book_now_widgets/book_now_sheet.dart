import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/logic/post/post_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/book_now_header.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/choose_ticket_footer.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/payment_sucess_dailog.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/book_now_widgets/ticket_list.dart';

class BookNowSheet extends StatefulWidget {
  final PostDataModel post;
  final OrganizerDataModel organizer;
  final String organizerUid;
  final UserDataModel userData;
  final Map<String, Map<String, dynamic>> tickets;

  const BookNowSheet({
    super.key,
    required this.tickets,
    required this.userData,
    required this.organizerUid,
    required this.post, required this.organizer,
  });

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
      listenWhen:
          (previous, current) =>
              current is PaymentSuccess || current is PaymentFailed,
      buildWhen:
          (previous, current) =>
              current is TicketSelected ||
              current is IncrementedTicket ||
              current is DecrementedTicket,
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            paymentSuccessDaiolg(context);
          });
        }
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

              SizedBox(height: 10),
              selectedTicketType != null && count != null && count != 0
                  ? ChooseTicketFooter(
                    organizerData: widget.organizer,
                    userData: widget.userData,
                    postImage: widget.post.imageUrl,
                    organizerUid: widget.organizerUid,
                    userUid: widget.userData.uid,
                    price: price!,
                    count: count!,
                    selectedTicketType: selectedTicketType,
                    ticketCount: ticketCount,
                    postName: widget.post.name,
                    postID: widget.post.postId,
                    country: widget.post.country,
                    venue: widget.post.venue,
                    date: widget.post.registrationDeadline,
                  )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
