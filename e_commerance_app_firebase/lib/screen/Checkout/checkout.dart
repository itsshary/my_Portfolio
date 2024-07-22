import 'package:flutter/material.dart';
import 'package:project_app/models/Bestproductmodel.dart';
import 'package:project_app/models/firebase_firestore.dart';
import 'package:project_app/provider/app_Provider.dart';
import 'package:project_app/screen/Checkout/payment_configration.dart';
import 'package:project_app/screen/Custom_Bottom_bar/custom_bottom_bar.dart';
import 'package:project_app/widge/roundbutton.dart';
import 'package:project_app/widge/routes/routes.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  final ProductModel singleproductmodel;
  const CheckOut({super.key, required this.singleproductmodel});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int? groupvalue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("CheckOut"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 36.0,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.red, width: 3.0),
              ),
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupvalue,
                      onChanged: (value) {
                        setState(() {
                          groupvalue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cash On Delivery",
                    style:
                        TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.red, width: 3.0),
              ),
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupvalue,
                      onChanged: (value) {
                        setState(() {
                          groupvalue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Pay Online",
                    style:
                        TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Button(
                title: "Continues",
                ontap: () async {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProduct(widget.singleproductmodel);
                  bool value = await FirebaseFirestoreHelper.instance
                      .uploadorderProductFirebase(appProvider.getbuyproductlist,
                          groupvalue == 1 ? "Cash on delevery" : "Paid");
                  appProvider.clearBuyProduct();
                  if (value) {
                    Future.delayed(const Duration(seconds: 2));
                    Routes.instance.push(const CustomBottomBar(), context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}






//  if (groupvalue == 1) {
//                   bool value = await FirebaseFirestoreHelper.instance
//                       .uploadorderProductFirebase(
//                           appProvider.getbuyproductlist, "Cash On Delivery");
//                   appProvider.clearBuyProduct();
//                   if (value) {
//                     Future.delayed(const Duration(seconds: 3), () {
//                       Routes.instance.push(const CustomBottomBar(), context);
//                     });
//                   } else {
//                     int value = double.parse(
//                             appProvider.TotalpriceButyproductList().toString())
//                         .round()
//                         .toInt();
//                     String totalprice = (value * 100).toString();
//                     bool issuccessfullypayment = await stripehelper.instace
//                         .makepayment(totalprice.toString()); //
//                     if (issuccessfullypayment) {
//                       bool value = await FirebaseFirestoreHelper.instance
//                           .uploadorderProductFirebase(
//                               appProvider.getbuyproductlist, "Paid");
//                       appProvider.clearBuyProduct();
//                       if (value) {
//                         Future.delayed(const Duration(seconds: 3), () {
//                           Routes.instance
//                               .push(const CustomBottomBar(), context);
//                         });
//                       }
//                     }
//                   }
//                 }
//               },


                
