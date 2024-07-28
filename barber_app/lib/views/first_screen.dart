import 'package:barber_app_with_admin_panel/resorces/app_colors/app_colors.dart';
import 'package:barber_app_with_admin_panel/resorces/assets/images_strings.dart';

import 'package:flutter/material.dart';

import '../view_model/splash_service.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  SplashServices splashscreen = SplashServices();
  @override
  void initState() {
    super.initState();
    splashscreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldbackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              AppImages.firstPageImages,
              height: 300.0,
              width: 300.0,
            ),
          ],
        ),
      ),
    );
  }
}
