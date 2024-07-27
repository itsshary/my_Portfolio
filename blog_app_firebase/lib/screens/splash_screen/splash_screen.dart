import 'package:blog_app_firebase/screens/splash_screen/splase_services.dart';
import 'package:blog_app_firebase/utils/text_styles.dart/app_text_style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashscreen = SplashServices();

  @override
  void initState() {
    super.initState();
    splashscreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/blog.png",
              height: 200,
              width: 200,
            ),
            Text(
              "Write Today Todo ",
              style: AppTextStyle.defaulttextsize.copyWith(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
