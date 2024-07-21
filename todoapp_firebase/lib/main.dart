import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp_firebase/screens/auth_screens/login_screen.dart';
import 'package:todoapp_firebase/utils/routes/routes.dart';
import 'package:todoapp_firebase/utils/routes/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAPYYOKb-yeRqcHML8FSH1YWd8Piplbo1I",
          appId: "1:88087465839:android:87c86d30459f0e9bfe629a",
          messagingSenderId: "88087465839",
          projectId: "todoportfolio-cd604"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo App',
      home: LogninScreen(),
      initialRoute: Routesname.splashScreen,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
