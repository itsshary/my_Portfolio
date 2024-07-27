import 'dart:io';

import 'package:blog_app_firebase/firebase/auth_logics/auth_logics.dart';
import 'package:blog_app_firebase/utils/app_colors/app_colors.dart';
import 'package:blog_app_firebase/utils/routes/routes_name.dart';
import 'package:blog_app_firebase/widgets/roundbutton.dart';
import 'package:blog_app_firebase/widgets/spin_kit.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  final FocusNode emailnode = FocusNode();
  final FocusNode passwordnode = FocusNode();
  final FocusNode nameNode = FocusNode();
  final _key = GlobalKey<FormState>();
  bool isloading = false;
  XFile? imageFile;
  bool validateImage = false;

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    emailnode.dispose();
    passwordnode.dispose();
    passwordC.dispose();
    nameC.dispose();
    nameNode.dispose();
  }

  void _onImagePicked(XFile? pickedFile) {
    setState(() {
      imageFile = pickedFile;
      validateImage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        progressIndicator: const SpinKitFlutter(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Section
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.firstGradientColor,
                      AppColors.secondGradientColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add your logo here
                    Text(
                      'Welcome to BlogApp',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Sign up to continue',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // Form Section
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: imageFile != null
                            ? FileImage(File(imageFile!.path))
                            : null,
                        child: InkWell(
                          onTap: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            _onImagePicked(pickedFile);
                          },
                          child: imageFile == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                )
                              : null,
                        ),
                      ),
                      if (validateImage && imageFile == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Please select an image',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nameC,
                        focusNode: nameNode,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
                          prefixIcon: Icon(Icons.person,
                              color: AppColors.textFieldIconColor),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(emailnode);
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                        controller: emailC,
                        focusNode: emailnode,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.email,
                              color: AppColors.textFieldIconColor),
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(passwordnode);
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordC,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        obscureText: true,
                        focusNode: passwordnode,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          prefixIcon: Icon(Icons.lock,
                              color: AppColors.textFieldIconColor),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Button(
                        bgcolor: AppColors.firstGradientColor,
                        title: "Sign Up",
                        textcolor: AppColors.whiteColor,
                        ontap: () async {
                          setState(() {
                            validateImage = imageFile == null;
                          });
                          if (_key.currentState!.validate() &&
                              imageFile != null) {
                            setState(() {
                              isloading = true;
                            });

                            String result = await AuthLogics.instance
                                .signUpFunction(imageFile!.path, nameC.text,
                                    emailC.text, passwordC.text, context);

                            setState(() {
                              isloading = false;
                            });

                            if (result == "success") {
                              Navigator.pushReplacementNamed(context,
                                  Routesname.bottomNavigationbarScreen);
                            } else {
                              // Handle sign up failure
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Footer Section
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routesname.login);
                  },
                  child: Text(
                    'Already have an account? Log in',
                    style: TextStyle(color: AppColors.firstGradientColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
