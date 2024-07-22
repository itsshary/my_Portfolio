import 'package:e_commerance_app_firebase/provider/app_Provider.dart';
import 'package:e_commerance_app_firebase/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:provider/provider.dart';

void main() async {
  Stripe.publishableKey = ' Enter your Publishable key';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MaterialApp(
          title: "E-Bazaar",
          debugShowCheckedModeBanner: false,
          home: LoginScreen()),
    );
  }
}




//  StreamBuilder(
//           stream: FirebaseAuthHelper.instance.getautchange,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return const CustomBottomBar();
//             }
//             return const LoginScreen();
//           },
//         ),
