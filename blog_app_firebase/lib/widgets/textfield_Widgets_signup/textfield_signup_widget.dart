import 'package:blog_app_firebase/utils/app_colors/app_colors.dart';
import 'package:blog_app_firebase/utils/extension/extension.dart';
import 'package:blog_app_firebase/widgets/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required GlobalKey<FormState> value,
    required this.emailC,
    required this.emailnode,
    required this.passwordnode,
    required this.passwordC,
    required this.nameC,
    required this.nameNode,
    required this.imageFile,
    required this.onImagePicked,
    required this.validateImage,
  }) : _key = value;

  final GlobalKey<FormState> _key;
  final TextEditingController emailC;
  final FocusNode emailnode;
  final FocusNode passwordnode;
  final TextEditingController passwordC;
  final TextEditingController nameC;
  final FocusNode nameNode;
  final XFile? imageFile;
  final Function(XFile?) onImagePicked;
  final bool validateImage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  imageFile != null ? FileImage(File(imageFile!.path)) : null,
              child: InkWell(
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  onImagePicked(pickedFile);
                },
                child: imageFile == null
                    ? Icon(
                        Icons.camera_alt,
                        size: 30,
                      )
                    : null,
              ),
            ),
            if (validateImage && imageFile == null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Please select an image',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            20.sH,
            TextFormField(
              controller: nameC,
              focusNode: nameNode,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                prefixIcon:
                    Icon(Icons.person, color: AppColors.textFieldIconColor),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Name';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(emailnode);
              },
            ),
            20.sH,
            TextFormField(
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                  return 'Enter a valid email!';
                }
                return null;
              },
              controller: emailC,
              focusNode: emailnode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter Email',
                prefixIcon:
                    Icon(Icons.email, color: AppColors.textFieldIconColor),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(passwordnode);
              },
            ),
            20.sH,
            TextFormField(
              controller: passwordC,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Password';
                }
                return null;
              },
              obscureText: true,
              focusNode: passwordnode,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Enter Password',
                prefixIcon:
                    Icon(Icons.lock, color: AppColors.textFieldIconColor),
              ),
            ),
            50.sH,
            Button(
              bgcolor: AppColors.firstGradientColor,
              title: "Sign Up",
              textcolor: AppColors.whiteColor,
              ontap: () {
                if (_key.currentState!.validate() && imageFile != null) {
                  // Perform sign up action
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
