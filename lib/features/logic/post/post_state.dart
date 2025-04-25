part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

class PostsLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<PostDataModel> posts;

  PostsLoaded({required this.posts});
}

class PostsError extends PostState {
  final String errorMessage;

  PostsError({required this.errorMessage});
}

class OrganizerGet extends PostState {
  final OrganizerDataModel organizerData;

  OrganizerGet({required this.organizerData});
}

class BookNowState extends PostState {}

class TicketSelected extends PostState {
    final int count;
  final int price;
  final String selectTicketType;

  TicketSelected({required this.selectTicketType,required this.count,required this.price, });
}

class IncrementedTicket extends PostState{
  final int ticketCount;

  IncrementedTicket({required this.ticketCount});

}
class DecrementedTicket extends PostState{
    final int ticketCount;

  DecrementedTicket({required this.ticketCount});

}