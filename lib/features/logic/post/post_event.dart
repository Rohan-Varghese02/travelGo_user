part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class SearchPostsEvent extends PostEvent {
  final String searchQuery;

  SearchPostsEvent({required this.searchQuery});
}

class FetchOrganizerDetails extends PostEvent {
  final String uid;

  FetchOrganizerDetails({required this.uid});
}

class BookNowBtn extends PostEvent {}

class SelectTicket extends PostEvent {
  final int count;
  final int price;
  final String ticketType;

  SelectTicket({
    required this.ticketType,
    required this.count,
    required this.price,
  });
}

class IncrementTicket extends PostEvent {
  final int ticketCount;

  IncrementTicket({required this.ticketCount});
}

class DecrementTicket extends PostEvent {
  final int ticketCount;

  DecrementTicket({required this.ticketCount});
}

class PaymentIntiate extends PostEvent {
  final int totalPrice;
  final PaymentModel paymentData;
  PaymentIntiate({required this.totalPrice, required this.paymentData});
}
