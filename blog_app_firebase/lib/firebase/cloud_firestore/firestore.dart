import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:blog_app_firebase/models/bolg_model.dart';
import 'package:blog_app_firebase/models/usermodel.dart';

class CloudFirestoreHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch user details from Firestore
  Future<UserModel?> fetchUser(String userId) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return UserModel.fromjson(userDoc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Stream blogs ordered by creation date
  Stream<List<Blog>> streamBlogs() {
    return _firestore
        .collection('blogs')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return Blog.fromFirestore(doc);
      }).toList();
    });
  }

  // Get likes count for a blog
  Future<int> getLikesCount(String blogId) async {
    final blogDoc = await _firestore.collection('blogs').doc(blogId).get();
    final blogData = blogDoc.data() as Map<String, dynamic>;
    List<String> likes = List<String>.from(blogData['likes'] ?? []);
    return likes.length;
  }

  // Update likes for a blog
  Future<void> updateBlogLikes(String blogId, List<String> likes) async {
    await _firestore.collection('blogs').doc(blogId).update({
      'likes': likes,
    });
  }

  // Upload an image to Firebase Storage and return the URL
  static Future<String> uploadImage(File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    Reference storageRef =
        FirebaseStorage.instance.ref().child('blogs/$fileName');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    return await taskSnapshot.ref.getDownloadURL();
  }

  // Upload a new blog to Firestore
  static Future<void> uploadBlog(Blog blog) async {
    String blogId = FirebaseFirestore.instance.collection('blogs').doc().id;
    await FirebaseFirestore.instance
        .collection('blogs')
        .doc(blogId)
        .set(blog.toMap());
  }

  // Update followers for a user
  Future<void> updateUserFollowers(
      String userId, List<String> followers) async {
    await _firestore.collection('users').doc(userId).update({
      'followers': followers,
    });
  }

  // Add a comment to a blog
  Future<void> addComment(String blogId, Comment comment) async {
    await _firestore.collection('blogs').doc(blogId).update({
      'comments': FieldValue.arrayUnion([comment.toMap()])
    });
  }

  // Stream comments for a specific blog
  Stream<List<Comment>> streamComments(String blogId) {
    return _firestore.collection('blogs').doc(blogId).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        List<dynamic> commentsData =
            (doc.data() as Map<String, dynamic>)['comments'] ?? [];
        return commentsData
            .map((comment) => Comment.fromMap(comment as Map<String, dynamic>))
            .toList();
      }
      return [];
    });
  }
}
