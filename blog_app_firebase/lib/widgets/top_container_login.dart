import 'package:blog_app_firebase/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class TopContainerTwo extends StatelessWidget {
  const TopContainerTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 50.0, left: 30),
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColors.firstGradientColor,
            AppColors.secondGradientColor,
            AppColors.thirdGradientColor,
          ]),
        ),
        child: const Text(
          "Hello Welcome \n Back",
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ));
  }
}
