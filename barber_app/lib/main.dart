import 'package:barber_app_with_admin_panel/provider/app_provider.dart';
import 'package:barber_app_with_admin_panel/utils/routes/routes.dart';
import 'package:barber_app_with_admin_panel/utils/routes/routes_name.dart';
import 'package:barber_app_with_admin_panel/view_model/auth_view_model.dart';
import 'package:barber_app_with_admin_panel/view_model/firestore_view_model.dart';
import 'package:barber_app_with_admin_panel/views/first_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: " ",
          appId: " ",
          messagingSenderId: " ",
          storageBucket: ' ',
          projectId: " "));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => AppProviderClass()),
        ChangeNotifierProvider(create: (context) => FirestoreViewModel()),
      ],
      child: const MaterialApp(
        initialRoute: Routesname.firstScreen,
        onGenerateRoute: Routes.generateRoutes,
        debugShowCheckedModeBanner: false,
        home: FirstScreen(),
      ),
    );
  }
}
