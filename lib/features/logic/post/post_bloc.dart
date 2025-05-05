import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:travelgo_user/core/services/firestore_services.dart';
import 'package:travelgo_user/core/services/stripe_services.dart';
import 'package:travelgo_user/data/models/organizer_data.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/data/models/post_data_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<FetchOrganizerDetails>(fetchOrganizerDetails);
    on<BookNowBtn>(bookNowBtn);
    on<SelectTicket>(selectTicket);
    on<IncrementTicket>(incrementTicket);
    on<DecrementTicket>(decrementTicket);
    on<PaymentIntiate>(paymentIntiate);
  }

  FutureOr<void> fetchOrganizerDetails(
    FetchOrganizerDetails event,
    Emitter<PostState> emit,
  ) async {
    final organizerData = await FirestoreService().getOrganizer(event.uid);
    log(organizerData.name);
    emit(OrganizerGet(organizerData: organizerData));
  }

  FutureOr<void> bookNowBtn(BookNowBtn event, Emitter<PostState> emit) {
    emit(BookNowState());
  }

  FutureOr<void> selectTicket(SelectTicket event, Emitter<PostState> emit) {
    log(event.ticketType);
    emit(
      TicketSelected(
        selectTicketType: event.ticketType,
        count: event.count,
        price: event.price,
      ),
    );
  }

  FutureOr<void> incrementTicket(
    IncrementTicket event,
    Emitter<PostState> emit,
  ) {
    int count = event.ticketCount;
    log(event.ticketCount.toString());
    count++;
    log(count.toString());
    emit(IncrementedTicket(ticketCount: count));
  }

  FutureOr<void> decrementTicket(
    DecrementTicket event,
    Emitter<PostState> emit,
  ) {
    int count = event.ticketCount;
    log(event.ticketCount.toString());
    count--;
    log(count.toString());
    emit(DecrementedTicket(ticketCount: count));
  }

  FutureOr<void> paymentIntiate(
    PaymentIntiate event,
    Emitter<PostState> emit,
  ) async {
    String? paymentID = await StripeServices.instance.makePayment(
      event.totalPrice,
    );
    if (paymentID != null) {
      await FirestoreService().paymentRecipetinFiresttore(event.paymentData);
      await FirestoreService().updateTicketCount(
        postId: event.paymentData.postID,
        ticketType: event.paymentData.ticketType,
        quantityToBuy: event.paymentData.totalTickets,
      );
      await FirebaseFirestore.instance
          .collection('post')
          .doc(event.paymentData.postID)
          .collection('users')
          .doc(event.paymentData.userUid)
          .set({
            'userUID': event.paymentData.userUid,
            'userImage': event.userData.imageUrl,
            'userEmail': event.userData.email,
            'userPhone': event.userData.phoneNumber,
          });
      await FirestoreService().updateRevenueAfterPurchase(
        organizerUid: event.paymentData.organizerUid,
        postId: event.paymentData.postID,
        ticketType: event.paymentData.ticketType,
        quantity: event.paymentData.totalTickets,
        totalPrice: event.paymentData.totalPrice,
      );
      emit(PaymentSuccess(paymentID: paymentID));
    } else {
      emit(PaymentFailed());
    }
  }
}
