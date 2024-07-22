import 'package:e_commerance_app_firebase/models/fluttertoast/toastmessage.dart';
import 'package:e_commerance_app_firebase/screen/login_screen.dart';
import 'package:e_commerance_app_firebase/widge/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 

class DummayScreen extends StatefulWidget {
  const DummayScreen({super.key});

  @override
  State<DummayScreen> createState() => _DummayScreenState();
}

class _DummayScreenState extends State<DummayScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Routes().push(LoginScreen(), context);
                }).onError((error, stackTrace) {
                  Utilies().toast(error.toString());
                });
              },
              child: Text('Logout'))),
    );
  }
}
