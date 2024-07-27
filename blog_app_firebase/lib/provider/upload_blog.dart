import 'dart:io';
import 'package:blog_app_firebase/firebase/cloud_firestore/firestore.dart';
import 'package:blog_app_firebase/models/bolg_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadBlogsProvider extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  XFile? image;
  bool isLoading = false;
  final _key = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  get key => _key;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = pickedFile;
      notifyListeners();
    }
  }

  Future<void> uploadBlog(BuildContext context) async {
    if (titleController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        image != null) {
      try {
        isLoading = true;
        notifyListeners();

        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          // Handle user not signed in
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please sign in to upload a blog')),
          );
          isLoading = false;
          notifyListeners();
          return;
        }

        // Upload image and blog
        String downloadUrl =
            await CloudFirestoreHelper.uploadImage(File(image!.path));
        Blog blog = Blog(
          id: '',
          title: titleController.text,
          content: contentController.text,
          imageUrl: downloadUrl,
          userId: user.uid,
        );
        await CloudFirestoreHelper.uploadBlog(blog);

        // Clear the form
        titleController.clear();
        contentController.clear();
        image = null;
        isLoading = false;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Blog uploaded successfully')),
        );
      } catch (e) {
        isLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload blog: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
    }
  }
}
