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
    on<CouponStatusCheck>(couponStatusCheck);
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
            'userName': event.userData.name,
            'tickets': {
              event.paymentData.ticketType: FieldValue.increment(
                event.paymentData.totalTickets,
              ),
            },
          }, SetOptions(merge: true));
      await FirestoreService().organizerMessage(
        event.organizerData.uid,
        event.organizerData.imageUrl,
        event.organizerData.name,
        event.userData.uid,
        'Tap here to message',
        Timestamp.now(),
      );
      await FirestoreService().userMessage(
        event.userData.uid,
        event.userData.imageUrl,
        event.userData.name,
        event.organizerData.uid,
        'Tap here to message',
        Timestamp.now(),
      );
      await FirestoreService().updateRevenueAfterPurchase(
        organizerUid: event.paymentData.organizerUid,
        postId: event.paymentData.postID,
        ticketType: event.paymentData.ticketType,
        quantity: event.paymentData.totalTickets,
        totalPrice: event.paymentData.totalPrice,
      );
      if (event.couponCode != null && event.couponCode!.isNotEmpty) {
        final couponQuery =
            await FirebaseFirestore.instance
                .collection('Coupons')
                .where('codeName', isEqualTo: event.couponCode)
                .limit(1)
                .get();

        if (couponQuery.docs.isNotEmpty) {
          final couponDoc = couponQuery.docs.first.reference;
          await couponDoc.update({
            'codeRedeem': FieldValue.increment(-event.paymentData.totalTickets),
          });
        }
      }

      emit(PaymentSuccess(paymentID: paymentID));
    } else {
      emit(PaymentFailed());
    }
  }

  FutureOr<void> couponStatusCheck(
    CouponStatusCheck event,
    Emitter<PostState> emit,
  ) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('Coupons')
              .where('codeName', isEqualTo: event.couponCode)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        final isActive = data['isActive'] ?? false;
        final codeRedeem = data['codeRedeem'] ?? 0;
        final couponPostName = data['postName'] ?? '';
        final currentPostName = event.postName;

        if (couponPostName != currentPostName) {
          emit(CouponInvalid(message: 'This coupon is not for this post'));
          return;
        }

        if (!isActive) {
          emit(CouponInvalid(message: 'Coupon is inactive'));
          return;
        }

        if (codeRedeem == 0) {
          emit(CouponInvalid(message: 'This coupon has already been used up'));
          return;
        }

        final int discount = data['codeDiscount'] ?? 0;
        emit(CouponValid(discount: discount)); // Custom state
      } else {
        emit(CouponInvalid(message: 'Invalid coupon code'));
      }
    } catch (e) {
      emit(CouponInvalid(message: 'Error: ${e.toString()}'));
    }
  }
}
