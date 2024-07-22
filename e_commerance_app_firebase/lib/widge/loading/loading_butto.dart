import 'package:flutter/material.dart';

class DropButtonLoating extends StatelessWidget {
  const DropButtonLoating({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 85,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(),
            Text(
              'Your Request is Processed',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
