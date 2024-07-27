import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  String id;
  String title;
  String content;
  String imageUrl;
  String userId;
  List<String> likes; // List of user IDs who liked the blog
  List<Comment> comments;
  DateTime createdAt;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.userId,
    this.likes = const [],
    this.comments = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'userId': userId,
      'likes': likes,
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'createdAt': createdAt,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      likes: List<String>.from(map['likes'] ?? []),
      comments: List<Comment>.from(
        map['comments']?.map((comment) => Comment.fromMap(comment)) ?? [],
      ),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  factory Blog.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Blog(
      id: doc.id,
      title: data['title'],
      content: data['content'],
      imageUrl: data['imageUrl'],
      userId: data['userId'],
      likes: List<String>.from(data['likes'] ?? []),
      comments: List<Comment>.from(
        data['comments']?.map((comment) => Comment.fromMap(comment)) ?? [],
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}

class Comment {
  String userId;
  String text;
  DateTime createdAt;

  Comment({
    required this.userId,
    required this.text,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'text': text,
      'createdAt': createdAt,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'],
      text: map['text'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
