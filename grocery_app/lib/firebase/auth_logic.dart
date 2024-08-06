import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/usermodel.dart';
import 'package:grocery_app/utilis/toastmessage.dart';

class AuthLogics {
  final _auth = FirebaseAuth.instance;
  static AuthLogics instance = AuthLogics();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> signUpFunction(String imagePath, String name, String email,
      String password, String address, BuildContext context) async {
    try {
      UserCredential? userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Upload image to Firebase Storage
      String imageUrl =
          await _uploadImageToStorage(imagePath, userCredential.user!.uid);

      UserModel newUserModel = UserModel(
          image: imageUrl,
          id: userCredential.user!.uid,
          name: name,
          email: email,
          address: address);

      _firebaseFirestore
          .collection("users")
          .doc(newUserModel.id)
          .set(newUserModel.tojson());
      return "success";
    } on FirebaseException catch (e) {
      Utilies().toast(e.toString());
      return "failed";
    }
  }

  Future<String> _uploadImageToStorage(String imagePath, String userId) async {
    try {
      File imageFile = File(imagePath);
      Reference ref = _firebaseStorage.ref().child('user_images').child(userId);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw FirebaseException(
          plugin: 'firebase_storage', message: 'Image upload failed');
    }
  }

  Future<String> updateProfileImage(File imageFile, String userId) async {
    try {
      Reference ref = _firebaseStorage.ref().child('user_images').child(userId);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw FirebaseException(
          plugin: 'firebase_storage', message: 'Image upload failed');
    }
  }

  Future<void> updateProfile(
      String userId, String? name, String? imageUrl) async {
    try {
      Map<String, dynamic> updatedData = {};
      if (name != null && name.isNotEmpty) {
        updatedData['name'] = name;
      }
      if (imageUrl != null && imageUrl.isNotEmpty) {
        updatedData['image'] = imageUrl;
      }

      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .update(updatedData);
    } catch (e) {
      throw FirebaseException(
          plugin: 'firebase_firestore', message: 'Profile update failed');
    }
  }
}
