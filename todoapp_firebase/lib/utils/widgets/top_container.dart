import 'package:flutter/material.dart';
import 'package:todoapp_firebase/utils/widgets/app_colors/app_colors.dart';

class TopContainer extends StatefulWidget {
  const TopContainer({super.key});

  @override
  State<TopContainer> createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
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
    );
  }
}
