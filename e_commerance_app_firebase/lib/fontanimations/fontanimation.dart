import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'font',
);

class FontAnimation extends StatelessWidget {
  const FontAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            'WELCOME IN',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            'E-BAZAAR',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
      ),
    );
  }
}
