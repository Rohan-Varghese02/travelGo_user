import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:travelgo_user/core/constants/stripe_constants.dart';
class StripeServices {
  StripeServices._();

  static final StripeServices instance = StripeServices._();

  Future<String?> makePayment(int amount) async {
    try {
      final paymentIntentData = await _createPaymentIntent(amount, "usd");

      if (paymentIntentData == null) return null;

      final String paymentIntentClientSecret = paymentIntentData['client_secret'];
      final String paymentIntentId = paymentIntentData['id'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "TravLGo App",
        ),
      );

      await processPayment();

      return paymentIntentId; // Return the payment ID here
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": calucalteAmount(amount),
        "currency": currency,
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.data != null) {
        print(response.data);
        return {
          "client_secret": response.data['client_secret'],
          "id": response.data['id'], // Payment ID
        };
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  String calucalteAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }
}