// roundbutton.dart (Button widget)
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function() ontap;
  final Color? bgcolor;
  final Color? textcolor;

  const Button({
    Key? key,
    required this.title,
    required this.ontap,
    this.bgcolor,
    this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor ?? Theme.of(context).primaryColor,
      ),
      child: Text(
        title,
        style: TextStyle(color: textcolor ?? Colors.white),
      ),
    );
  }
}
