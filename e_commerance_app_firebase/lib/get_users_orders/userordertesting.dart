// import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class GetUserOrders extends StatefulWidget {
//   const GetUserOrders({super.key});

//   @override
//   State<GetUserOrders> createState() => _GetUserOrdersState();
// }

// class _GetUserOrdersState extends State<GetUserOrders> {
//   @override
//   Widget build(BuildContext context) {
//     final ref=FirebaseFirestore.instance.collection('userodders').doc('order').get();
//     return FutureBuilder(
//       future: ref,
//       builder: (context, snapshot) {
      
//       return  ListView.builder(
 
//         itemBuilder: (BuildContext context, int index) {
//           return ;
//         },
//       ),
//     },);
//   }
// }
