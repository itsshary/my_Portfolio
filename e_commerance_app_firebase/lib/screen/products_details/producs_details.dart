import 'package:e_commerance_app_firebase/models/Bestproductmodel.dart';
import 'package:e_commerance_app_firebase/models/fluttertoast/toastmessage.dart';
import 'package:e_commerance_app_firebase/provider/app_Provider.dart';
import 'package:e_commerance_app_firebase/screen/Checkout/checkout.dart';
import 'package:e_commerance_app_firebase/screen/cartscreen.dart';
import 'package:e_commerance_app_firebase/widge/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 
 
import 'package:provider/provider.dart';

class ProductsDetails extends StatefulWidget {
  final ProductModel singleproduct;
  const ProductsDetails({super.key, required this.singleproduct});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.shopping_cart,
                ))
          ],
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.singleproduct.image.toString(),
                  height: 350,
                  width: 350,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleproduct.name.toString(),
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleproduct.isfavourite =
                              !widget.singleproduct.isfavourite;
                        });
                        if (widget.singleproduct.isfavourite) {
                          appProvider
                              .addFavouriteProducts(widget.singleproduct);
                        } else {
                          appProvider
                              .removefavouriteProducts(widget.singleproduct);
                        }
                      },
                      icon: Icon(appProvider.getfavouriteProductList
                              .contains(widget.singleproduct)
                          ? Icons.favorite
                          : Icons.favorite_border))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        if (quantity >= 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      });
                    },
                    child: const SizedBox(
                      width: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    child: const SizedBox(
                      width: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2.5),
                        ),
                        onPressed: () {
                          ProductModel productModel =
                              widget.singleproduct.copyWith(quantity: quantity);
                          appProvider.addCartProducts(productModel);
                          Utilies().toast("Your Product Add TO Cart");
                        },
                        child: const Text('ADD TO CART'),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          ProductModel productModel =
                              widget.singleproduct.copyWith(quantity: quantity);
                          Routes().push(
                              CheckOut(singleproductmodel: productModel),
                              context);
                        },
                        child: const Text('BUY'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
