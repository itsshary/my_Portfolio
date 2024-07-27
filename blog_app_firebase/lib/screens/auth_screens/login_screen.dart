import 'package:blog_app_firebase/utils/routes/routes_name.dart';
import 'package:blog_app_firebase/utils/app_colors/app_colors.dart';
import 'package:blog_app_firebase/widgets/roundbutton.dart';

import 'package:blog_app_firebase/widgets/spin_kit.dart';
import 'package:blog_app_firebase/utils/text_styles.dart/app_text_style.dart';
import 'package:blog_app_firebase/widgets/top_container_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogninScreen extends StatefulWidget {
  const LogninScreen({super.key});

  @override
  State<LogninScreen> createState() => _LogninScreenState();
}

class _LogninScreenState extends State<LogninScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final _key = GlobalKey<FormState>();
  final FocusNode emailnode = FocusNode();
  final FocusNode passwordnode = FocusNode();
  bool isloading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    emailnode.dispose();
    passwordnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      progressIndicator: const SpinKitFlutter(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundcolor,
        body: Stack(
          children: [
            const TopContainerTwo(),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        focusNode: emailnode,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(passwordnode);
                        },
                        controller: emailC,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.email,
                              color: AppColors.textFieldIconColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: AppColors.textFieldIconColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: AppColors.textFieldIconColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        focusNode: passwordnode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        controller: passwordC,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          prefixIcon: Icon(Icons.lock,
                              color: AppColors.textFieldIconColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: AppColors.textFieldIconColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: AppColors.textFieldIconColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Button(
                        textcolor: AppColors.whiteColor,
                        bgcolor: AppColors.signInButtonColor,
                        title: 'Sign In',
                        ontap: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            await _auth
                                .signInWithEmailAndPassword(
                                    email: emailC.text,
                                    password: passwordC.text)
                                .then((val) {
                              Navigator.pushReplacementNamed(context,
                                  Routesname.bottomNavigationbarScreen);
                            }).catchError((err) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $err')),
                              );
                            }).whenComplete(() {
                              setState(() {
                                isloading = false;
                              });
                            });
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dont have any Account",
                            style: AppTextStyle.donthaveaccount,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routesname.signUp);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: AppColors.firstGradientColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routesname.forgetpassword);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: AppColors.firstGradientColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
