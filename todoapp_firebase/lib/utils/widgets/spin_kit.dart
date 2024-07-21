import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinKitFlutter extends StatelessWidget {
  const SpinKitFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitCircle(
      color: Colors.red,
      size: 50.0,
    );
  }
}
