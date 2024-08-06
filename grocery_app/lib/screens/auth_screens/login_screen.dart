import 'package:flutter/material.dart';
import 'package:grocery_app/resources/app_text_styles/app_text_styles.dart';
import 'package:grocery_app/resources/appcolors/appcolors.dart';
import 'package:grocery_app/resources/compnets/buttons/roundbutton.dart';
import 'package:grocery_app/resources/compnets/textfield/textfield_componets.dart';
import 'package:grocery_app/utilis/routes/routes_name.dart';
import 'package:sizedbox_extention/sizedbox_extention.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/grocery.png",
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Login",
                        style: AppTextStyles.custom(
                            fontSize: 40, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const TextfieldComponent(
                hintText: 'Enter your name',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              20.height,
              const TextfieldComponent(
                hintText: 'Enter your password',
                isPassword: true,
                icon: Icons.lock,
              ),
              20.height,
              Button(
                  textcolor: AppColors.background,
                  bgcolor: const Color.fromARGB(255, 1, 110, 4),
                  title: "Login",
                  ontap: () {}),
              5.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Don't have any account",
                      style: AppTextStyles.caption),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routesname.signUp);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.button,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
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
                      "Sigin With Google",
                      style: AppTextStyles.subheadline,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
