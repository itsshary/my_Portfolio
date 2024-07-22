import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Stripehelper {
  static Stripehelper instance = Stripehelper();
  Map<String, dynamic>? PaymentIntent;
  Future<bool> makePayment(String amount) async {
    try {
      PaymentIntent = await createPaymentIntent('10000', 'USD');
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
      //add displaypamentsheet function
      displayPaymentSheet();
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print('Payment Successfully');
      });
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51P7AcrK7CAbmirkaeYNa9Ao7ZR5R0UjiWhN7rO09MVFyLbMMbjyuzMOCIiqTerMCUVoF5Vm1uWX4bDOKX7HMAEV500HYhFWpZm ',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
