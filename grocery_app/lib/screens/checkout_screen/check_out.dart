// CartItemCheckout.dart
import 'package:flutter/material.dart';
import 'package:grocery_app/firebase/firebasefirestore_helper.dart';
import 'package:grocery_app/provider/app_Provider.dart';
import 'package:grocery_app/screens/home_screen/home_screen.dart';
import 'package:grocery_app/screens/stripe_method/stripe_method.dart';
import 'package:grocery_app/utilis/toastmessage.dart';
import 'package:provider/provider.dart';
import '../../resources/compnets/buttons/roundbutton.dart';

class CartItemCheckout extends StatefulWidget {
  final double totalPrice;

  const CartItemCheckout({super.key, required this.totalPrice});

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
            Text("The total price is \$${widget.totalPrice}"),
            const SizedBox(height: 36.0),
            buildPaymentOption(1, Icons.money, "Cash On Delivery"),
            const SizedBox(height: 15.0),
            buildPaymentOption(2, Icons.credit_card, "Pay Online"),
            const SizedBox(height: 20.0),
            Button(
              title: "Continue",
              ontap: () async {
                if (groupvalue == 1) {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();
                  await processOrder(context, appProvider, "Cash on Delivery");
                } else if (groupvalue == 2) {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();
                  await processStripePayment(context, appProvider);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentOption(int value, IconData icon, String text) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.red, width: 3.0),
      ),
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: groupvalue,
            onChanged: (value) {
              setState(() {
                groupvalue = value!;
              });
            },
          ),
          Icon(icon),
          const SizedBox(width: 12.0),
          Text(
            text,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> processOrder(BuildContext context, AppProvider appProvider,
      String paymentMethod) async {
    bool isOrderSuccessful =
        await FirebasefirestoreHelper.instance.uploadorderProductFirebase(
      appProvider.getbuyproductlist,
      paymentMethod,
    );
    if (isOrderSuccessful) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    }
  }

  Future<void> processStripePayment(
      BuildContext context, AppProvider appProvider) async {
    double totalPrice = widget.totalPrice;

    int totalPriceInCents = (totalPrice * 100).toInt();

    bool isSuccessfulPayment =
        await Stripehelper.instance.makePayment(totalPriceInCents.toString());
    if (isSuccessfulPayment) {
      await processOrder(context, appProvider, "Paid");
    } else {
      await processOrder(context, appProvider, "Payment Cancelled");
    }
  }
}
