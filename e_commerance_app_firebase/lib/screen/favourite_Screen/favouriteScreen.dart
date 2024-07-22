import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/provider/app_Provider.dart';
import 'package:project_app/screen/favourite_Screen/Widgets/single_favourite_item.dart';

import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        title: const Text("Favourite Screen"),
        centerTitle: true,
      ),
      body: appProvider.getfavouriteProductList.isEmpty
          ? const Center(
              child: Text(
                "No item In favourite",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: appProvider.getfavouriteProductList.length,
              itemBuilder: (context, index) {
                return SingleFavouriteitem(
                  singleproduct: appProvider.getfavouriteProductList[index],
                );
              },
            ),
    );
  }
}
