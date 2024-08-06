import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/firebase/auth_logic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grocery_app/utilis/toastmessage.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _nameController = TextEditingController();
  File? _imageFile;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageFile!.delete();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_nameController.text.isEmpty && _imageFile == null) {
      Utilies().toast("Please provide a name or select an image to update.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      if (_imageFile != null) {
        String imageUrl =
            await AuthLogics.instance.updateProfileImage(_imageFile!, userId);
        await AuthLogics.instance
            .updateProfile(userId, _nameController.text, imageUrl);
      } else {
        await AuthLogics.instance
            .updateProfile(userId, _nameController.text, null);
      }

      Utilies().toast("Profile updated successfully.");
    } catch (e) {
      Utilies().toast(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : const AssetImage('assets/profile_placeholder.png')
                              as ImageProvider,
                      child: _imageFile == null
                          ? const Icon(Icons.camera_alt,
                              size: 50, color: Colors.grey)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    child: const Text("Update Profile"),
                  ),
                ],
              ),
            ),
    );
  }
}
