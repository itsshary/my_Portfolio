// import 'package:flutter/services.dart';
// import 'package:project_app/screen/Checkout/payment_configration.dart';

// class GPayClass {
//   static const platform = MethodChannel(defaultGooglePay);

//   static Future<bool> makePayment(String totalAmount) async {
//     try {
//       final bool result =
//           await platform.invokeMethod('makePayment', <String, dynamic>{
//         'totalAmount': totalAmount,
//       });
//       return result;
//     } on PlatformException catch (e) {
//       print("Failed to make payment: '${e.message}'.");
//       return false;
//     }
//   }
// }
