

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/payment_model.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/logic/post/post_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/detailed_page/widgets/apply_coupon.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

class ChooseTicketFooter extends StatefulWidget {
  final UserDataModel userData;
  final String postName;
  final String postID;
  final String organizerUid;
  final String userUid;
  final String? selectedTicketType;
  final int ticketCount;
  final int count;
  final int price;
  final String postImage, country, venue, date;
  const ChooseTicketFooter({
    super.key,
    this.selectedTicketType,
    required this.ticketCount,
    required this.count,
    required this.price,
    required this.userUid,
    required this.organizerUid,
    required this.postName,
    required this.postID,
    required this.postImage,
    required this.country,
    required this.venue,
    required this.date,
    required this.userData,
  });

  @override
  State<ChooseTicketFooter> createState() => _ChooseTicketFooterState();
}

class _ChooseTicketFooterState extends State<ChooseTicketFooter> {
  TextEditingController controller = TextEditingController();
  final keystate = GlobalKey<FormState>();

  int discount = 0;

  @override
  Widget build(BuildContext context) {
    int originalTotal = widget.price * widget.ticketCount;
    int discountedTotal = originalTotal - ((originalTotal * discount) ~/ 100);

    return BlocListener<PostBloc, PostState>(
      listenWhen:
          (previous, current) =>
              current is CouponValid || current is CouponInvalid,
      listener: (context, state) {
        if (state is CouponValid) {
          setState(() {
            discount = state.discount;
          });
        } else if (state is CouponInvalid) {
          setState(() {
            discount = 0;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Invalid coupon")));
        }
      },
      child: Form(
        key: keystate,
        child: Column(
          children: [
            originalTotal > 0
                ? ApplyCoupon(
                  controller: controller,
                  validator: validator,
                  onTap: () {
                    if (keystate.currentState!.validate()) {
                      context.read<PostBloc>().add(
                        CouponStatusCheck(
                          totalPrice: originalTotal,
                          couponCode: controller.text,
                        ),
                      );
                    }
                  },
                )
                : SizedBox(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StyleText(text: 'Number of seats', size: 18),
                Row(
                  children: [
                    if (widget.ticketCount > 0)
                      gestureControl(
                        icon: Icon(Icons.remove),
                        color: grey20,
                        onTap: () {
                          context.read<PostBloc>().add(
                            DecrementTicket(ticketCount: widget.ticketCount),
                          );
                        },
                      ),
                    SizedBox(width: 10),
                    Text(widget.ticketCount.toString()),
                    SizedBox(width: 20),
                    if (widget.ticketCount < widget.count)
                      gestureControl(
                        icon: Icon(Icons.add, color: white),
                        color: themeColor,
                        onTap: () {
                          context.read<PostBloc>().add(
                            IncrementTicket(ticketCount: widget.ticketCount),
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
            if (discount > 0) StyleText(text: 'Discount: $discount%'),
            StyleText(text: 'Total Amount: ₹$discountedTotal', size: 18),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  widget.selectedTicketType == null || widget.ticketCount == 0
                      ? null
                      : () {
                        PaymentModel payment = PaymentModel(
                          postImage: widget.postImage,
                          userUid: widget.userUid,
                          organizerUid: widget.organizerUid,
                          totalTickets: widget.ticketCount,
                          totalPrice: discountedTotal,
                          ticketType: widget.selectedTicketType!,
                          postName: widget.postName,
                          postID: widget.postID,
                          country: widget.country,
                          venue: widget.venue,
                          date: widget.date,
                          timestamp: Timestamp.now(),
                        );
                        context.read<PostBloc>().add(
                          PaymentIntiate(
                            couponCode: controller.text,
                            userData: widget.userData,
                            totalPrice: discountedTotal,
                            paymentData: payment,
                          ),
                        );
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: innerTheme,
                padding: EdgeInsets.symmetric(horizontal: 130, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: StyleText(
                text: widget.count != 0 ? 'Continue' : 'Full Booked',
                fontWeight: FontWeight.w500,
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget gestureControl({
  required Icon icon,
  required Color color,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: icon,
    ),
  );
}

String? validator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter code';
  }
  return null;
}
