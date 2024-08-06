import 'package:flutter/material.dart';
import 'package:grocery_app/resources/appcolors/appcolors.dart';

class TextfieldComponent extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final IconData? icon;

  const TextfieldComponent({
    super.key,
    this.labelText,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: AppColors.logininiconscolors,
              )
            : null,
        fillColor: AppColors.grey,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
