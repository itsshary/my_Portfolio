import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/utilis/toastmessage.dart';
import 'package:http/http.dart' as http;

class Stripehelper {
  static Stripehelper instance = Stripehelper();
  Map<String, dynamic>? PaymentIntent;

  Future<bool> makePayment(String amount) async {
    try {
      PaymentIntent = await createPaymentIntent(amount, 'USD');
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "USD", testEnv: true);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: PaymentIntent!['client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: 'Abi',
            googlePay: gpay,
          ))
          .then((value) {});

      await displayPaymentSheet();
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        Utilies().toast('Payment successful');
      });
    } catch (e) {
      print(e);
      if (e is StripeException && e.error.code == FailureCode.Canceled) {
        Utilies().toast('Payment canceled');
      } else {
        Utilies().toast("Payment failed");
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': '',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to create payment intent: ${response.body}');
        Utilies().toast('Failed to create payment intent: ${response.body}');
        return null;
      }
    } catch (e) {
      print(e);
      Utilies().toast('Error creating payment intent: $e');
      return null;
    }
  }
}
