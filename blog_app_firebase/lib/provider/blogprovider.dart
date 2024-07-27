import 'package:flutter/material.dart';
import 'package:blog_app_firebase/models/bolg_model.dart';
import 'package:blog_app_firebase/models/usermodel.dart';
import 'package:blog_app_firebase/firebase/cloud_firestore/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BlogProvider with ChangeNotifier {
  final CloudFirestoreHelper _firestoreHelper = CloudFirestoreHelper();
  UserModel? _currentUser;

  BlogProvider() {
    _init();
  }

  Future<void> _init() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    _currentUser = await _firestoreHelper.fetchUser(userId);
    notifyListeners();
  }

  UserModel? get currentUser => _currentUser;

  Future<UserModel?> fetchUser(String userId) {
    return _firestoreHelper.fetchUser(userId);
  }

  Future<void> toggleLike(Blog blog) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    List<String> likes = List<String>.from(blog.likes);
    if (likes.contains(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
    blog.likes = likes;
    await _firestoreHelper.updateBlogLikes(blog.id, likes);
    notifyListeners();
  }

  Future<bool> isBlogLiked(Blog blog) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return blog.likes.contains(userId);
  }

  Future<void> toggleFollow(String userId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    UserModel? user = await fetchUser(userId);

    if (user != null) {
      List<String> followers = List<String>.from(user.followers);
      if (followers.contains(currentUserId)) {
        followers.remove(currentUserId);
      } else {
        followers.add(currentUserId);
      }
      await _firestoreHelper.updateUserFollowers(userId, followers);
      notifyListeners();
    }
  }

  Future<bool> isFollowing(String userId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    UserModel? user = await fetchUser(userId);
    if (user != null) {
      return user.followers.contains(currentUserId);
    }
    return false;
  }

  Future<void> postComment(String blogId, String text) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Comment comment = Comment(userId: userId, text: text);
    await _firestoreHelper.addComment(blogId, comment);
    notifyListeners();
  }

  Stream<List<Comment>> fetchComments(String blogId) {
    return _firestoreHelper.streamComments(blogId);
  }
}
