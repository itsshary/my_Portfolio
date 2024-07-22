import 'package:e_commerance_app_firebase/firebasehelper/firebase_auth_helper.dart';
import 'package:e_commerance_app_firebase/screen/Custom_Bottom_bar/custom_bottom_bar.dart';
import 'package:e_commerance_app_firebase/widge/botton/roundbutton.dart';
import 'package:e_commerance_app_firebase/widge/routes/routes.dart';
import 'package:flutter/material.dart';

 

import 'login_screen.dart';

class SigningScreen extends StatefulWidget {
  const SigningScreen({super.key});

  @override
  State<SigningScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SigningScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: kToolbarHeight + 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: name,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      fillColor: Colors.white60,
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      fillColor: Colors.white60,
                      hintText: 'enter email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'enter password',
                      prefixIcon: Icon(Icons.password),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Button(
            title: 'Sign In',
            ontap: () {
              if (_formkey.currentState!.validate()) {
                FirebaseAuthHelper.instance
                    .SignUptest(name.text, email.text, password.text, context);
                Routes().pushandremovedunti(const CustomBottomBar(), context);
              }
            },
            bgcolor: Colors.deepOrange,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already Have an account'),
              const SizedBox(
                width: 5.0,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  },
                  child: const Text('Log In')),
            ],
          ),
        ]),
      ),
    );
  }
}
