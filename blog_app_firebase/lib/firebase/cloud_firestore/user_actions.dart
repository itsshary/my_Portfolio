import 'package:cloud_firestore/cloud_firestore.dart';

class UserActions {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> followUser(String currentUserId, String targetUserId) async {
    await _firebaseFirestore.collection('users').doc(currentUserId).update({
      'following': FieldValue.arrayUnion([targetUserId])
    });

    await _firebaseFirestore.collection('users').doc(targetUserId).update({
      'followers': FieldValue.arrayUnion([currentUserId])
    });

    // Optional: Send notification or update feed
  }

  Future<void> unfollowUser(String currentUserId, String targetUserId) async {
    await _firebaseFirestore.collection('users').doc(currentUserId).update({
      'following': FieldValue.arrayRemove([targetUserId])
    });

    await _firebaseFirestore.collection('users').doc(targetUserId).update({
      'followers': FieldValue.arrayRemove([currentUserId])
    });

    // Optional: Send notification or update feed
  }

  Future<bool> isFollowing(String currentUserId, String targetUserId) async {
    DocumentSnapshot userDoc =
        await _firebaseFirestore.collection('users').doc(currentUserId).get();
    List<dynamic> following = userDoc['following'] ?? [];
    return following.contains(targetUserId);
  }
}
