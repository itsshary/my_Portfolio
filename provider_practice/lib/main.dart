import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_practice/provider/countProvider.dart';
import 'package:provider_practice/provider/countexapmle.dart';
import 'package:provider_practice/provider/favouriteprovider.dart';
import 'package:provider_practice/screens/exampleonescreen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //multi provider use for multiple provider classess
      providers: [
        ChangeNotifierProvider(
          create: (context) => Providercount(),
        ),
        ChangeNotifierProvider(
          create: (context) => Countexample(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouriteProvider(),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}
