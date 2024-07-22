// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:project_app/models/firebase_firestore.dart';
// import 'package:project_app/models/ordermodel/ordermodel.dart';

// class OrderScreen extends StatefulWidget {
  
//   const OrderScreen({super.key, });

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Order Screen"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('orders').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final res = snapshot.data!.docs[index];
//                 return ExpansionTile(
//                   tilePadding: EdgeInsets.zero,
//                   collapsedShape: const RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.red, width: 2.3),
//                   ),
//                   shape: const RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.red, width: 2.3),
//                   ),
//                   title: Row(
//                     children: [
//                       Container(
//                         height: 145,
//                         width: 140,
//                         color: Colors.red.withOpacity(0.5),
//                         child: Image.network(
//                           res['images'][0],
//                           height: 100,
//                           width: 100,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 140,
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 res['products'][2].toString(),
//                                 style: const TextStyle(
//                                     fontSize: 12.0,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                          orderModel.products.length > 1
//                                   ? SizedBox.fromSize()
//                                   : Column(
//                                       children: [
//                                         Text(
//                                           "Quantity: ${orderModel.products[0].quantity}",
//                                           style: const TextStyle(
//                                             fontSize: 12.0,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 12.0),
//                                       ],
//                                     ),
//                               Text(
//                                 "Total Price:\$${orderModel.totalPrice}",
//                                 style: const TextStyle(
//                                   fontSize: 12.0,
//                                 ),
//                               ),
//                               const SizedBox(height: 12.0),
//                               Text(
//                                 "Order Staus:${orderModel.status}",
//                                 style: const TextStyle(
//                                   fontSize: 12.0,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 5.0,
//                               ),
//                               orderModel.status == "Pending" ||
//                                       orderModel.status == "Delivery"
//                                   ? ElevatedButton(
//                                       onPressed: () async {
//                                         await FirebaseFirestoreHelper.instance
//                                             .updateOrder(orderModel, "Cancel");
//                                         orderModel.status = "Cancel";
//                                         setState(() {});
//                                       },
//                                       child: const Text('Cancel Order'))
//                                   : SizedBox.fromSize(),
//                               orderModel.status == "Delivery"
//                                   ? ElevatedButton(
//                                       onPressed: () async {
//                                         await FirebaseFirestoreHelper.instance
//                                             .updateOrder(
//                                                 orderModel, "Completed");
//                                         orderModel.status = "Completed";
//                                         setState(() {});
//                                       },
//                                       child: const Text('Delivered Order'))
//                                   : SizedBox.fromSize(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   children: orderModel.products.length > 1
//                       ? []
//                       : [
//                           const Text("Details"),
//                           const Divider(color: Colors.red),
//                           ...orderModel.products.map((singleproduct) {
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 12, top: 6.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           height: 130,
//                                           width: 130,
//                                           color: Colors.red.withOpacity(0.5),
//                                           child: Image.network(
//                                               singleproduct.image.toString()),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: SizedBox(
//                                           height: 145,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(10.0),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   singleproduct.name.toString(),
//                                                   style: const TextStyle(
//                                                       fontSize: 12.0,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                                 Column(
//                                                   children: [
//                                                     Text(
//                                                       "Quantity: ${singleproduct.quantity.toString()}",
//                                                       style: const TextStyle(
//                                                         fontSize: 12.0,
//                                                       ),
//                                                     ),
//                                                     const SizedBox(
//                                                         height: 12.0),
//                                                   ],
//                                                 ),
//                                                 Text(
//                                                   "Price:\$${singleproduct.price.toString()}",
//                                                   style: const TextStyle(
//                                                     fontSize: 12.0,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const Divider(
//                                     color: Colors.red,
//                                   )
//                                 ],
//                               ),
//                             );
//                           }).toList()
//                         ],
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
