import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/repositiary/splashServices/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    services.splashscreen(context);
  }

  SplashServices services = SplashServices();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'images/news.png',
            fit: BoxFit.cover,
            height: height * .5,
          ),
          const Text('News Up',
              style: TextStyle(
                  letterSpacing: 5.0,
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 50.0,
          ),
          const SpinKitDualRing(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
