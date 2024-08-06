import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/firebase/firebasefirestore_helper.dart';
import 'package:grocery_app/models/productmodel.dart';
import 'package:grocery_app/provider/app_Provider.dart';
import 'package:grocery_app/resources/appcolors/appcolors.dart';
import 'package:grocery_app/screens/cart_screen/cartscreen.dart';
import 'package:grocery_app/utilis/toastmessage.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sizedbox_extention/sizedbox_extention.dart';

class ProductsDetails extends StatefulWidget {
  final ProductModel singleproduct;
  const ProductsDetails({super.key, required this.singleproduct});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  List<ProductModel> relatedProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchRelatedProducts();
    quantity = widget.singleproduct.quantity ?? 1;
  }

  void _fetchRelatedProducts() async {
    // Fetch related products based on the category
    var data = await FirebasefirestoreHelper.instance
        .getProductsByCategory(widget.singleproduct.category!);
    setState(() {
      relatedProducts = data
          .where((product) => product.id != widget.singleproduct.id)
          .toList();
    });
  }

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const CartScreen(),
          //         ));
          //   },
          //   icon: const Icon(
          //     Icons.shopping_cart,
          //   ),
          // )
          Consumer<AppProvider>(builder: (context, appProvider, child) {
            return badges.Badge(
                position: BadgePosition.topEnd(top: 5, end: 5),
                badgeContent: Text(
                  appProvider.getCartProductList.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      });
                    },
                    icon: const Icon(Icons.shopping_cart)));
          })
        ],
        elevation: 0.0,
        backgroundColor: AppColors.primary,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
                bottom: 80), // Prevents content overlap with button
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: AppColors.primary.withOpacity(0.2),
                  child: Image.network(
                    widget.singleproduct.imageurl.toString(),
                    fit: BoxFit.scaleDown,
                    height: 320,
                    width: 320,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.singleproduct.name.toString(),
                            style: const TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$${widget.singleproduct.price.toString()}",
                            style: const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.grey,
                              child: const Icon(
                                Icons.remove,
                                color: Colors.black,
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
                            child: CircleAvatar(
                              backgroundColor: AppColors.grey,
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.singleproduct.description.toString(),
                        maxLines: 4,
                        style: const TextStyle(
                          fontSize: 16.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      10.height,
                      const Text(
                        "Related Products",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      relatedProducts.isEmpty
                          ? Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.2),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: relatedProducts.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductsDetails(
                                              singleproduct:
                                                  relatedProducts[index]),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary
                                              .withOpacity(0.2),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              relatedProducts[index]
                                                  .imageurl
                                                  .toString(),
                                              height: 60,
                                              width: 60,
                                            ),
                                            Text(
                                              relatedProducts[index].name!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                      const SizedBox(height: 20), // Space for bottom button
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white, // Ensure the background is white
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.width,
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleproduct.copyWith(quantity: quantity);
                        appProvider.addCartProducts(productModel);
                        Utilies().toast("Your Product Add TO Cart");
                      },
                      child: const Text(
                        'ADD TO CART',
                        style: TextStyle(
                            fontSize: 18.0, color: AppColors.background),
                      ),
                    ),
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
