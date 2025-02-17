import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp_firebase/screens/auth_screens/login_screen.dart';
import 'package:todoapp_firebase/utils/routes/routes.dart';
import 'package:todoapp_firebase/utils/routes/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: " ", appId: " ", messagingSenderId: " ", projectId: " "));
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
