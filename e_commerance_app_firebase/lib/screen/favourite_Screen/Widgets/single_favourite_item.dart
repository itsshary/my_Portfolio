import 'package:e_commerance_app_firebase/models/Bestproductmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 
import 'package:provider/provider.dart';

class SingleFavouriteitem extends StatefulWidget {
  final ProductModel singleproduct;
  const SingleFavouriteitem({super.key, required this.singleproduct});

  @override
  State<SingleFavouriteitem> createState() => _CartWidgetScreenState();
}

class _CartWidgetScreenState extends State<SingleFavouriteitem> {
  @override
  Widget build(BuildContext context) {
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
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.singleproduct.name.toString(),
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          CupertinoButton(
                              child: const Text(
                                "Removed to WishList",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                AppProvider appProvider =
                                    Provider.of<AppProvider>(context,
                                        listen: false);
                                appProvider.removefavouriteProducts(
                                    widget.singleproduct);
                                Utilies().toast("Removed From Wishlist");
                              }),
                        ],
                      ),
                      SizedBox.expand(
                        child: Text(
                          "\$${widget.singleproduct.price.toString()}",
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
