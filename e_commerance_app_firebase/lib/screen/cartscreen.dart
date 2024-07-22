import 'package:e_commerance_app_firebase/cart_item_checkout/cart_item_checkout.dart';
import 'package:e_commerance_app_firebase/models/fluttertoast/toastmessage.dart';
import 'package:e_commerance_app_firebase/provider/app_Provider.dart';
import 'package:e_commerance_app_firebase/widge/CartWidgetScreen/cartscreenwidget.dart';
import 'package:e_commerance_app_firebase/widge/botton/roundbutton.dart';
import 'package:e_commerance_app_firebase/widge/routes/routes.dart';
import 'package:flutter/material.dart';
 
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${appProvider.Totalprice().toString()}",
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Button(
                title: "CheckOut",
                ontap: () {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();
                  if (appProvider.getbuyproductlist.isEmpty) {
                    Utilies().toast("Cart is empty");
                  } else {
                    Routes.instance.push(const CartItemCheckout(), context);
                  }
                },
                bgcolor: Colors.red,
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        title: const Text("Cart Screen"),
        centerTitle: true,
      ),
      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text(
                "No item In Cart",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: appProvider.getCartProductList.length,
              itemBuilder: (context, index) {
                return CartWidgetScreen(
                  singleproduct: appProvider.getCartProductList[index],
                );
              },
            ),
    );
  }
}
