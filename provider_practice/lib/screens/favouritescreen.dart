import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_practice/provider/favouriteprovider.dart';
import 'package:provider_practice/screens/resultscreen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final appprovider = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Screen'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResultScreen(),
                    ));
              },
              icon: const Icon(Icons.shopping_bag))
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              if (appprovider.array.contains(index)) {
                appprovider.removeitem(index);
              } else {
                appprovider.additem(index);
              }
            },
            title: Text('item $index'),
            trailing: Icon(appprovider.array.contains(index)
                ? Icons.favorite
                : Icons.favorite_outline),
          );
        },
      ),
    );
  }
}
