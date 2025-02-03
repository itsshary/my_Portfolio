import 'package:blog_app_firebase/provider/blogprovider.dart';
import 'package:blog_app_firebase/screens/auth_screens/login_screen.dart';
import 'package:blog_app_firebase/utils/routes/routes.dart';
import 'package:blog_app_firebase/utils/routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "",
    appId: " ",
    messagingSenderId: "",
    projectId: "",
    storageBucket: "",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlogProvider>(
      create: (context) => BlogProvider(),
      child: const MaterialApp(
        title: 'Blog app',
        home: LogninScreen(),
        initialRoute: Routesname.login,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
