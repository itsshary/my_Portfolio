import 'package:e_commerance_app_firebase/models/Bestproductmodel.dart';
import 'package:e_commerance_app_firebase/models/catagorymodel.dart';
import 'package:e_commerance_app_firebase/models/firebase_firestore.dart';
import 'package:e_commerance_app_firebase/screen/products_details/producs_details.dart';
 
import 'package:flutter/material.dart';
 

class CatagoryviewScree extends StatefulWidget {
  final UserModel userModel;
  const CatagoryviewScree({super.key, required this.userModel});

  @override
  State<CatagoryviewScree> createState() => _CatagoryviewScreeState();
}

class _CatagoryviewScreeState extends State<CatagoryviewScree> {
  List<ProductModel> bestProductsList = [];
  bool isloading = false;

  void getcatogrieslist() async {
    setState(() {
      isloading = true;
    });

    bestProductsList = await FirebaseFirestoreHelper.instance
        .getCataogryProduct(widget.userModel.id.toString());
    bestProductsList.shuffle();

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    getcatogrieslist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
        ),
        body: isloading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: bestProductsList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        ProductModel singleproduct = bestProductsList[index];
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                singleproduct.image.toString(),
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                singleproduct.name.toString(),
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Price \$${singleproduct.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              SizedBox(
                                height: 45,
                                width: 100,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                          Colors.red.withOpacity(0.6),
                                      side: const BorderSide(
                                        color: Colors.red,
                                        width: 1.7,
                                      )),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductsDetails(
                                              singleproduct: singleproduct),
                                        ));
                                  },
                                  child: const Text('Buy'),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
  }
}
