import 'package:e_commerance_app_firebase/firebasehelper/firebase_auth_helper.dart';
import 'package:e_commerance_app_firebase/provider/app_Provider.dart';
import 'package:e_commerance_app_firebase/screen/signing_screen.dart';
import 'package:e_commerance_app_firebase/widge/botton/roundbutton.dart';
import 'package:e_commerance_app_firebase/widge/loading/loading_butto.dart';
import 'package:e_commerance_app_firebase/widge/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
 
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final _key = GlobalKey<FormState>();

  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: appProvider.isLoading,
      progressIndicator: const DropButtonLoating(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const Positioned(
                top: 60,
                left: 60,
                child: Column(
                  children: [
                    Text(
                      'E-Bazzar!',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Login in Your Account',
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  ],
                )),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            )),
                            fillColor: Colors.white60,
                            hintText: 'enter email',
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            )),
                            hintText: 'enter password',
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Button(
                bgcolor: Colors.deepOrange,
                title: 'Login',
                ontap: () {
                  if (_key.currentState!.validate()) {
                    FirebaseAuthHelper.instance
                        .login(email.text, password.text, context);
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have any account"),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: TextButton(
                          onPressed: () {
                            Routes().push(const SigningScreen(), context);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 20, color: Colors.deepOrange),
                          )),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
