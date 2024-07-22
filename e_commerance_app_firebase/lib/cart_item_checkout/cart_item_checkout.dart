import 'package:e_commerance_app_firebase/models/firebase_firestore.dart';
import 'package:e_commerance_app_firebase/provider/app_Provider.dart';
import 'package:e_commerance_app_firebase/screen/Custom_Bottom_bar/custom_bottom_bar.dart';
import 'package:e_commerance_app_firebase/stripe_method/stripe_method.dart';
import 'package:e_commerance_app_firebase/widge/botton/roundbutton.dart';
import 'package:e_commerance_app_firebase/widge/routes/routes.dart';
import 'package:flutter/material.dart';
 
import 'package:provider/provider.dart';

class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({
    super.key,
  });

  @override
  State<CartItemCheckout> createState() => _CheckOutState();
}

class _CheckOutState extends State<CartItemCheckout> {
  int groupvalue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("CartItemCheckout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 36.0,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.red, width: 3.0),
              ),
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupvalue,
                      onChanged: (value) {
                        setState(() {
                          groupvalue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cash On Delivery",
                    style:
                        TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.red, width: 3.0),
              ),
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupvalue,
                      onChanged: (value) {
                        setState(() {
                          groupvalue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Pay Online",
                    style:
                        TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Button(
                title: "Continues",
                ontap: () async {
                  if (groupvalue == 1) {
                    bool value = await FirebaseFirestoreHelper.instance
                        .uploadorderProductFirebase(
                            appProvider.getbuyproductlist, "Cash on Deleivery");
                    appProvider.clearBuyProduct();
                    if (value) {
                      Future.delayed(const Duration(seconds: 2));
                      () {
                        Routes.instance.push(const CustomBottomBar(), context);
                      };
                    }
                  } else if (groupvalue == 2) {
                    double totalprice = appProvider.Totalprice() * 100;
                    bool issuccessfullpayment = await Stripehelper.instance
                        .makePayment(totalprice.toString());
                    if (issuccessfullpayment) {
                      bool value = await FirebaseFirestoreHelper.instance
                          .uploadorderProductFirebase(
                              appProvider.getbuyproductlist, "Paid");
                      appProvider.clearBuyProduct();
                      if (value) {
                        Future.delayed(const Duration(seconds: 2));
                        () {
                          Routes.instance
                              .push(const CustomBottomBar(), context);
                        };
                      }
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
