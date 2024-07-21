import 'package:flutter/material.dart';
import 'package:todoapp_firebase/utils/widgets/app_colors/app_colors.dart';

class AppTextStyle {
  static TextStyle logintextstyle = const TextStyle(
      color: AppColors.whiteColor, fontSize: 32.0, fontWeight: FontWeight.bold);

  static TextStyle donthaveaccount = const TextStyle(fontSize: 20.0);

  static TextStyle defaulttextsize = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0);

  static TextStyle namesize = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30.0);

  static TextStyle services = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0);
}
