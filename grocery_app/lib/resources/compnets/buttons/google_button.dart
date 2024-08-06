import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white, // Text color
        side: BorderSide(color: Colors.grey.shade300), // Border color
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 5.0,
              width: 5, // Adjust as needed
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}
