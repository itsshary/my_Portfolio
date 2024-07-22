import 'package:e_commerance_app_firebase/models/Bestproductmodel.dart';
import 'package:e_commerance_app_firebase/models/catagorymodel.dart';
import 'package:e_commerance_app_firebase/models/firebase_firestore.dart';
import 'package:e_commerance_app_firebase/provider/app_Provider.dart';
import 'package:e_commerance_app_firebase/screen/Custom_Bottom_bar/custom_bottom_bar.dart';
import 'package:e_commerance_app_firebase/screen/catagoryview/categoryview.dart';
import 'package:e_commerance_app_firebase/screen/products_details/producs_details.dart';
import 'package:flutter/material.dart';
 
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> categoriesimage = []; //catagoryMobel==usermodel
  List<ProductModel> bestProductsList = [];
  bool isloading = false;

  @override
  void initState() {
    getcatogrieslist();
    const CustomBottomBar();
    FirebaseFirestoreHelper.instance.updatetokenfromfirebase();

    super.initState();
  }

  void getcatogrieslist() async {
    setState(() {
      isloading = true;
    });
    categoriesimage = await FirebaseFirestoreHelper.instance.getCategories();
    //  FirebaseFirestoreHelper.instance.updatetokenfromfirebase();
    bestProductsList = await FirebaseFirestoreHelper.instance.getBestProduct();
    AppProvider appProvider =
        await Provider.of<AppProvider>(context, listen: false);
    appProvider.getuserinfoFirebase();
    bestProductsList.shuffle();
    setState(() {
      isloading = false;
    });
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void serachProducts(String value) {
    searchList = bestProductsList
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: isloading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 20.0, top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'E-Commrance App',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      controller: search,
                      onChanged: (value) => serachProducts(value),
                      decoration: InputDecoration(
                          hintText: "Search....",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    categoriesimage.isEmpty
                        ? const Center(
                            child: Text('Category is empty'),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categoriesimage
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CatagoryviewScree(
                                                          userModel: e)));
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          elevation: 8.0,
                                          child: Container(
                                            height: 85,
                                            width: 85,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            child: Image.network(
                                              e.image.toString(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                    !isSearched()
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Best Products',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        : SizedBox.fromSize(),
                    search.text.isNotEmpty && searchList.isEmpty
                        ? const Center(
                            child: Text("No products found"),
                          )
                        : searchList.isNotEmpty
                            ? bestProductsList.isEmpty
                                ? const Center(
                                    child: Text("Best product is Empty "),
                                  )
                                : Expanded(
                                    child: GridView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 70.0),
                                      primary: false,
                                      itemCount: searchList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 20.0,
                                        mainAxisSpacing: 20.0,
                                        childAspectRatio: 0.7,
                                      ),
                                      itemBuilder: (context, index) {
                                        ProductModel singleproduct =
                                            searchList[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "Price \$${singleproduct.price}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 6.0,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 100,
                                                child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.red
                                                                  .withOpacity(
                                                                      0.6),
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.red,
                                                            width: 1.7,
                                                          )),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductsDetails(
                                                                  singleproduct:
                                                                      singleproduct),
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
                                  )
                            : bestProductsList.isEmpty
                                ? const Center(
                                    child: Text("No item "),
                                  )
                                : Expanded(
                                    child: GridView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 70.0),
                                      primary: false,
                                      itemCount: bestProductsList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 20.0,
                                        mainAxisSpacing: 20.0,
                                        childAspectRatio: 0.7,
                                      ),
                                      itemBuilder: (context, index) {
                                        ProductModel singleproduct =
                                            bestProductsList[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "Price \$${singleproduct.price}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 6.0,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 100,
                                                child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.red
                                                                  .withOpacity(
                                                                      0.6),
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.red,
                                                            width: 1.7,
                                                          )),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductsDetails(
                                                                  singleproduct:
                                                                      singleproduct),
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
                ),
              ),
      ),
    );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

// List<String> catogaeryimage = [
//   //dummy image urls
// ];

// List<UserModel> bestProducts = [
//   UserModel(
//       image:
//           "https://e7.pngegg.com/pngimages/675/836/png-clipart-banana-juice-cavendish-banana-fruit-eating-delicious-delicious-banana-food-tropical-fruit-thumbnail.png",
//       id: "1",
//       name: "Banana",
//       price: "1",
//       description: "This is good banana for health",
//       status: "Pending",
//       isfavourite: false),
//   UserModel(
//       image:
//           "https://e7.pngegg.com/pngimages/9/79/png-clipart-juice-smoothie-pineapple-fruit-canning-pineapple-fruit-pineapple-orange-pineapple-fruit-natural-foods-food-thumbnail.png",
//       id: "2",
//       name: "PineApple",
//       price: "5",
//       description: "Pineapple is best for health",
//       status: "Pending",
//       isfavourite: false),
//   UserModel(
//       image:
//           "https://e7.pngegg.com/pngimages/967/503/png-clipart-peach-peaches-slit-red-thumbnail.png",
//       id: "3",
//       name: "Peach",
//       price: "3",
//       description: "This is good banana for health",
//       status: "Pending",
//       isfavourite: false),
//   UserModel(
//       image:
//           "https://e7.pngegg.com/pngimages/944/390/png-clipart-grape-fruit-kyoho-white-wine-cardinal-grape-grape-natural-foods-frutti-di-bosco-thumbnail.png",
//       id: "4",
//       name: "Grapes",
//       price: "4",
//       description: "Grapes is best for health ",
//       status: "Pending",
//       isfavourite: false),
// ];
