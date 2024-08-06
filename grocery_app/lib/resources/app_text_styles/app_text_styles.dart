import 'package:flutter/material.dart';

class AppTextStyles {
  // Define different text styles

  // Headline style
  static const TextStyle headline = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Subheadline style
  static const TextStyle subheadline = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Body text style
  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  // Caption text style
  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  // Button text style
  static const TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Error text style
  static const TextStyle error = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );

  // Custom style example
  static TextStyle custom({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
