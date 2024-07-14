import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_practice/provider/countProvider.dart';
import 'package:provider_practice/provider/countexapmle.dart';
import 'package:provider_practice/screens/favouritescreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.withOpacity(0.5),
          title: const Text("Drop down Button"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavouriteScreen(),
                      ));
                },
                icon: const Icon(Icons.filter_vintage_outlined))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //just this part state will changed
            Consumer<Countexample>(
              builder: (context, value, child) {
                return Text(
                  value.count.toString(),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                );
              },
            ),
            Consumer<Providercount>(
              builder: (context, value, child) {
                return Slider(
                    min: 0,
                    max: 1.0,
                    value: value.value,
                    onChanged: (val) {
                      value.doublefun(val);
                    });
              },
            ),
            Consumer<Providercount>(
              builder: (context, value, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.green.withOpacity(value.value),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.red.withOpacity(value.value),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
        floatingActionButton: Consumer<Countexample>(
          builder: (context, value, child) {
            return FloatingActionButton(
              onPressed: () {
                value.functionad();
              },
              child: const Icon(Icons.add),
            );
          },
        ));
  }
}
