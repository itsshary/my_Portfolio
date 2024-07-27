import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String content;
  final String authorId;
  final Timestamp timestamp;

  Comment(
      {required this.id,
      required this.content,
      required this.authorId,
      required this.timestamp});

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Comment(
      id: doc.id,
      content: data['content'],
      authorId: data['authorId'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'authorId': authorId,
      'timestamp': timestamp,
    };
  }
}
