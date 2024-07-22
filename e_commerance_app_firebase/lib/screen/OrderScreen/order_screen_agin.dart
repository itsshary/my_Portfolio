import 'package:e_commerance_app_firebase/models/firebase_firestore.dart';
import 'package:e_commerance_app_firebase/models/ordermodel/ordermodel.dart';
import 'package:flutter/material.dart';

 

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Screen"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<OrderModel>? orders = snapshot.data;
          if (orders == null || orders.isEmpty) {
            return const Center(child: Text("No orders found"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            padding: const EdgeInsets.all(10.0),
            itemBuilder: (context, index) {
              OrderModel orderModel = snapshot.data![index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red, width: 2.3),
                    ),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red, width: 2.3),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          color: Colors.red.withOpacity(0.5),
                          child: Image.network(
                            orderModel.products![0].image.toString(),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 250,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderModel.products![0].name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  //show quantity
                                  // orderModel.products!.length > 1
                                  //     ? SizedBox.fromSize()
                                  //     : Column(
                                  //         children: [
                                  //           Text(
                                  //             'Total Price: \$${orderModel.totalPrice.toString()}',
                                  //             style: const TextStyle(
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //         ],
                                  //       ),
                                  Text(
                                    'Total Quantity:${orderModel.products![0].quantity.toString()}',
                                    style: const TextStyle(),
                                  ),
                                  Text(
                                    'Total Price Of Products:\$${orderModel.totalPrice.toString()}',
                                  ),
                                  Text(
                                    'Order Status:${orderModel.status.toString()}',
                                  ),

                                  orderModel.status == "pending" ||
                                          orderModel.status == "Delivery"
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            await FirebaseFirestoreHelper
                                                .instance
                                                .updateOrder(
                                                    orderModel, "Cancel");
                                            orderModel.status = "Cancel";
                                            setState(() {});
                                          },
                                          child: const Text("Cancel Order"))
                                      : SizedBox.fromSize(),
                                  orderModel.status == "Delivery"
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            await FirebaseFirestoreHelper
                                                .instance
                                                .updateOrder(
                                                    orderModel, "Completed");
                                            orderModel.status == "Completed";
                                            setState(() {});
                                          },
                                          child: const Text("Delivered Order"))
                                      : SizedBox.fromSize(),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    children: orderModel.products!.length > 1
                        ? [
                            const Text('Products Deatils'),
                            const Divider(
                              color: Colors.red,
                            ),
                            ...orderModel.products!.map((singleproduct) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        color: Colors.red.withOpacity(0.5),
                                        child: Image.network(
                                          singleproduct.image.toString(),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: SizedBox(
                                          height: 100,
                                          child: Column(
                                            children: [
                                              Text(
                                                singleproduct.name.toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              //show quantity
                                              Column(
                                                children: [
                                                  Text(
                                                    'Price: \$${singleproduct.price.toString()}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Total Quantity:${singleproduct.quantity.toString()}',
                                                style: const TextStyle(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.red,
                                  ),
                                ],
                              );
                            }).toList(),
                          ]
                        : []),
              );
            },
          );
        },
      ),
    );
  }
}
