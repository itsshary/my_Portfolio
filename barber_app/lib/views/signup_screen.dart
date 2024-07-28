import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../utils/utilis.dart';
import '../view_model/auth_view_model.dart';
import '../resorces/app_colors/app_colors.dart';
import '../resorces/widgets/roundbutton.dart';
import '../resorces/widgets/spin_kit.dart';
import '../resorces/widgets/top_container.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File? _image;
  final picker = ImagePicker();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ToastMsg.toastMessage("No image selected");
      }
    });
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadProfilePictureAndSignUp() async {
    if (_formKey.currentState!.validate() && _image != null) {
      setState(() {
        isLoading = true;
      });

      try {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        firebase_storage.Reference ref =
            storage.ref().child('ProfilePictures/$timestamp');
        await ref.putFile(_image!);
        String imageUrl = await ref.getDownloadURL();

        final viewModel = Provider.of<AuthViewModel>(context, listen: false);
        await viewModel.signupViewModel(
          imageUrl,
          emailController.text.trim(),
          nameController.text.trim(),
          passwordController.text.trim(),
          context,
        );

        clearFields();
      } catch (e) {
        // Handle errors accordingly
        print('Error: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else if (_image == null) {
      ToastMsg.toastMessage("Please select an image");
    }
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const SpinKitFlutter(),
        child: Stack(
          children: [
            const TopContainer(),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _showImagePickerDialog(context),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child: _image == null
                                ? const Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: nameController,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter your name'
                              : null,
                          decoration: InputDecoration(
                            hintText: 'Enter Name',
                            prefixIcon: Icon(Icons.person,
                                color: AppColors.textFieldIconColor),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            prefixIcon: Icon(Icons.email,
                                color: AppColors.textFieldIconColor),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter a password'
                              : null,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            prefixIcon: Icon(Icons.lock,
                                color: AppColors.textFieldIconColor),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Button(
                          title: "SignUp",
                          bgcolor: AppColors.firstGradientColor,
                          textcolor: AppColors.whiteColor,
                          ontap: _uploadProfilePictureAndSignUp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
