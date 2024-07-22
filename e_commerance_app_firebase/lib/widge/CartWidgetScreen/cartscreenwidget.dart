import 'package:e_commerance_app_firebase/models/Bestproductmodel.dart';
import 'package:e_commerance_app_firebase/models/fluttertoast/toastmessage.dart';
import 'package:e_commerance_app_firebase/provider/app_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 
import 'package:provider/provider.dart';

class CartWidgetScreen extends StatefulWidget {
  final ProductModel singleproduct;
  const CartWidgetScreen({super.key, required this.singleproduct});

  @override
  State<CartWidgetScreen> createState() => _CartWidgetScreenState();
}

class _CartWidgetScreenState extends State<CartWidgetScreen> {
  int quantity = 1;

  @override
  void initState() {
    quantity = widget.singleproduct.quantity ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: const Color.fromRGBO(244, 67, 54, 1),
            width: 2.9,
          )),
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: 145,
                color: Colors.red.withOpacity(0.5),
                child: Image.network(widget.singleproduct.image.toString())),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 145,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //fitted box
                            FittedBox(
                              child: Text(
                                widget.singleproduct.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                        appProvider.updatequanttity(
                                            widget.singleproduct, quantity);
                                      }
                                    });
                                  },
                                  child: const CircleAvatar(
                                    maxRadius: 15,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                    appProvider.updatequanttity(
                                        widget.singleproduct, quantity);
                                  },
                                  child: const CircleAvatar(
                                    maxRadius: 15,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CupertinoButton(
                                child: Text(
                                  appProvider.getfavouriteProductList
                                          .contains(widget.singleproduct)
                                      ? "Remove to WishList"
                                      : "Add to Wishlist",
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                onPressed: () {
                                  if (!appProvider.getfavouriteProductList
                                      .contains(widget.singleproduct)) {
                                    appProvider.addFavouriteProducts(
                                        widget.singleproduct);
                                    Utilies().toast("Added To Wishlist");
                                  } else {
                                    appProvider.removefavouriteProducts(
                                        widget.singleproduct);
                                    Utilies().toast("Removed To Wishlist");
                                  }
                                })
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "\$${widget.singleproduct.price.toString()}",
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const CircleAvatar(
                          backgroundColor: Colors.red,
                          maxRadius: 17,
                          child: Icon(
                            Icons.delete,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          appProvider.removeCartProducts(widget.singleproduct);
                          Utilies().toast("Removed From Cart");
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
