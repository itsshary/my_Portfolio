import 'package:flutter/material.dart';
import 'package:grocery_app/provider/app_Provider.dart';
import 'package:grocery_app/resources/appcolors/appcolors.dart';
import 'package:grocery_app/resources/compnets/buttons/roundbutton.dart';
import 'package:grocery_app/resources/compnets/cart_widget/cartscreenwidget.dart';
import 'package:grocery_app/screens/checkout_screen/check_out.dart';
import 'package:grocery_app/utilis/toastmessage.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    getlist();
    super.initState();
  }

  void getlist() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getCartProductList;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: const Text(
          "Cart Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          appProvider.getCartProductList.isEmpty
              ? const Center(
                  child: Text(
                    "No item In Cart",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      bottom: 80), // Adjust padding to avoid overlap
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: appProvider.getCartProductList.length,
                    itemBuilder: (context, index) {
                      return CartWidgetScreen(
                        singleproduct: appProvider.getCartProductList[index],
                      );
                    },
                  ),
                ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white, // Ensure the background is white
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Adjust height as needed
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${appProvider.Totalprice().toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Button(
                    textcolor: AppColors.background,
                    title: "CheckOut",
                    ontap: () {
                      if (appProvider.getCartProductList.isNotEmpty) {
                        appProvider
                            .addBuyProductCartList(); // Move cart items to buy list
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartItemCheckout(
                              totalPrice: appProvider.Totalprice(),
                            ),
                          ),
                        );
                      } else {
                        Utilies().toast("Cart is empty");
                      }
                    },
                    bgcolor: AppColors.primary,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
