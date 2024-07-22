import 'package:e_commerance_app_firebase/screen/splashscreen/splash_services.dart';
import 'package:flutter/material.dart';
 

import '../../fontanimations/fontanimation.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: Image.asset(
                'images/main.png',
                height: 170,
                width: 400,
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          const Center(child: FontAnimation()),
        ],
      ),
    );
  }
}
