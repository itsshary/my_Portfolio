import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:grocery_app/firebase/auth_logic.dart';
import 'package:grocery_app/resources/app_text_styles/app_text_styles.dart';
import 'package:grocery_app/resources/appcolors/appcolors.dart';
import 'package:grocery_app/resources/compnets/buttons/roundbutton.dart';
import 'package:grocery_app/resources/compnets/textfield/textfield_componets.dart';
import 'package:grocery_app/screens/home_screen/home_screen.dart';
import 'package:grocery_app/utilis/routes/routes_name.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizedbox_extention/sizedbox_extention.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController addressC = TextEditingController();
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
    return ModalProgressHUD(
      inAsyncCall: isloading,
      progressIndicator: const CircularProgressIndicator(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Image.asset(
                    "assets/images/grocery.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    imageFile != null ? FileImage(File(imageFile!.path)) : null,
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
              50.height,
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextfieldComponent(
                  controller: nameC,
                  hintText: 'Enter your name',
                  icon: Icons.person_2,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: TextfieldComponent(
                  controller: emailC,
                  hintText: 'Enter your emial',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextfieldComponent(
                  controller: passwordC,
                  hintText: 'Enter your password',
                  icon: Icons.lock,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: TextfieldComponent(
                  controller: addressC,
                  hintText: 'Enter your Address',
                  icon: Icons.home,
                  keyboardType: TextInputType.streetAddress,
                ),
              ),
              Button(
                  textcolor: AppColors.background,
                  bgcolor: const Color.fromARGB(255, 1, 110, 4),
                  title: "Sign Up",
                  ontap: () async {
                    setState(() {
                      validateImage = imageFile == null;
                    });
                    if (_key.currentState!.validate() && imageFile != null) {
                      setState(() {
                        isloading = true;
                      });

                      String result = await AuthLogics.instance.signUpFunction(
                          imageFile!.path,
                          nameC.text,
                          emailC.text,
                          passwordC.text,
                          addressC.text,
                          context);

                      setState(() {
                        isloading = false;
                      });

                      if (result == "success") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }
                    }
                  }),
              5.height,
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Don't have any account",
                        style: AppTextStyles.caption),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routesname.login);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: AppColors.button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/img.png",
                        height: 55,
                      ),
                      const Text(
                        "Signup With Google",
                        style: AppTextStyles.subheadline,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
