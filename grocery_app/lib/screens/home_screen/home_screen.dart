import 'package:flutter/material.dart';
import 'package:grocery_app/firebase/firebasefirestore_helper.dart';
import 'package:grocery_app/models/productmodel.dart';
import 'package:grocery_app/resources/app_text_styles/app_text_styles.dart';
import 'package:grocery_app/resources/appcolors/appcolors.dart';
import 'package:grocery_app/resources/compnets/cardChildrenwidget/card_children_widget.dart';
import 'package:grocery_app/screens/order_screen/order_screen.dart';
import 'package:grocery_app/screens/product_details_screen/product_details_screen.dart';
import 'package:grocery_app/screens/userprofile_screen/user_profile.dart';
import 'package:sizedbox_extention/sizedbox_extention.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> groceryItems = [
    'Fruits',
    'Bakery',
    'Snacks',
  ];

  String selectedCategory = 'Fruits';
  List<ProductModel> currentData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    var data = await FirebasefirestoreHelper.instance
        .getProductsByCategory(selectedCategory);
    setState(() {
      currentData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebasefirestoreHelper.instance.getUserInformation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Home",
                style: AppTextStyles.headline,
              ),
              centerTitle: true,
              actions: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(snapshot.data!.image.toString()),
                ),
                const SizedBox(width: 13),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              NetworkImage(snapshot.data!.image.toString()),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data!.name.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          snapshot.data!.email.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      // Navigate to home screen
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Cart'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart_checkout_outlined),
                    title: const Text('Orders'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfile()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      // Navigate to settings screen
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(
                    elevation: 0.2,
                    child: Container(
                      height: 70.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 231, 231),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OrderScreen()));
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Positioned(
                                  left: 6,
                                  child: Icon(
                                    Icons.location_on,
                                    size: 40,
                                    color: AppColors.primary,
                                  )),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.name.toString(),
                                    style: AppTextStyles.body.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(snapshot.data!.address.toString())
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.height,
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: AppColors.grey,
                      filled: true,
                      hintText: 'Search items',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: groceryItems.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = groceryItems[index];
                              _fetchData();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        selectedCategory == groceryItems[index]
                                            ? AppColors.primary
                                            : Colors.transparent,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  groceryItems[index],
                                  style: AppTextStyles.body.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        selectedCategory == groceryItems[index]
                                            ? AppColors.primary
                                            : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: currentData.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            itemCount: currentData.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 1.0,
                              mainAxisSpacing: 1.0,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductsDetails(
                                              singleproduct:
                                                  currentData[index])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CardChildrenWidget(
                                      product: currentData[index]),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
