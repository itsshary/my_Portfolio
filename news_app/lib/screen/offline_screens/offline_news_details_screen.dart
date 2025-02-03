import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfflineNewsDetailsScreen extends StatefulWidget {
  final String newsimage;
  final String newstitle;
  final String newsdes;
  const OfflineNewsDetailsScreen(
      {super.key,
      required this.newsimage,
      required this.newstitle,
      required this.newsdes});

  @override
  State<OfflineNewsDetailsScreen> createState() =>
      _OfflineNewsDetailsScreenState();
}

class _OfflineNewsDetailsScreenState extends State<OfflineNewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 0.1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(
                height: 100,
                width: 100,
                File(widget.newsimage
                    .toString()), // Use File() to create a File object from the file path
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Flexible(
              child: Text(
                widget.newstitle,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(widget.newsdes,
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
