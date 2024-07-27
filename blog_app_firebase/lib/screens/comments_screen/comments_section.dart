import 'package:blog_app_firebase/models/bolg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentSectionScreen extends StatefulWidget {
  const CommentSectionScreen({super.key});

  @override
  _CommentSectionScreenState createState() => _CommentSectionScreenState();
}

class _CommentSectionScreenState extends State<CommentSectionScreen> {
  final _commentController = TextEditingController();
  Blog? _blog; // Make _blog nullable

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Blog) {
      _blog = args;
    } else {
      // Handle the error appropriately, e.g., show a message or navigate back
      Navigator.pop(context);
    }
  }

  void _addComment() async {
    if (_commentController.text.isNotEmpty && _blog != null) {
      final newComment = Comment(
        userId: "currentUserId", // Replace with actual current user ID
        text: _commentController.text,
      );

      await FirebaseFirestore.instance
          .collection('blogs')
          .doc(_blog!.id)
          .update({
        'comments': FieldValue.arrayUnion([newComment.toMap()])
      });

      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handle null _blog gracefully
    if (_blog == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: const Center(
          child: Text('Error: Blog data not available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('blogs')
                  .doc(_blog!.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('Blog not found'));
                }

                final blog =
                    Blog.fromMap(snapshot.data!.data() as Map<String, dynamic>);
                return ListView.builder(
                  itemCount: blog.comments.length,
                  itemBuilder: (context, index) {
                    final comment = blog.comments[index];
                    return ListTile(
                      title: Text(comment.text),
                      subtitle: Text(comment.userId),
                      trailing: Text(
                        '${comment.createdAt.hour}:${comment.createdAt.minute}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
