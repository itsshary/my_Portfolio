import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/provider/app_Provider.dart';
import 'package:grocery_app/screens/auth_screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: ' NTyXw',
      appId: '  ',
      messagingSenderId: '37',
      storageBucket: "g ",
      projectId: 'g ',
    ),
  );
  runApp(const MyApp());
  Stripe.publishableKey = '  ';
  await Stripe.instance.applySettings();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignupScreen(),
      ),
    );
  }
}
