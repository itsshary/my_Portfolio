import 'package:blog_app_firebase/screens/edit_blog/edit_blog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog_app_firebase/models/usermodel.dart';
import 'package:blog_app_firebase/models/bolg_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfile extends StatelessWidget {
  final String userId;

  UserProfile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final blogRef = FirebaseFirestore.instance
        .collection('blogs')
        .where('userId', isEqualTo: userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: userRef.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final user =
              UserModel.fromjson(snapshot.data!.data() as Map<String, dynamic>);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                user.image != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user.image!),
                        radius: 50,
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.person),
                        radius: 50,
                      ),
                const SizedBox(height: 10),
                Text(
                  user.name ?? 'User',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        FutureBuilder<int>(
                          future: _getCount(user.followers),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('0',
                                  style: TextStyle(fontSize: 18));
                            }
                            if (snapshot.hasError) {
                              return const Text('Error',
                                  style: TextStyle(fontSize: 18));
                            }
                            return Text('${snapshot.data ?? 0}',
                                style: const TextStyle(fontSize: 18));
                          },
                        ),
                        const Text('Followers'),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        FutureBuilder<int>(
                          future: _getCount(user.following),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('0',
                                  style: TextStyle(fontSize: 18));
                            }
                            if (snapshot.hasError) {
                              return const Text('Error',
                                  style: TextStyle(fontSize: 18));
                            }
                            return Text('${snapshot.data ?? 0}',
                                style: const TextStyle(fontSize: 18));
                          },
                        ),
                        const Text('Following'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: blogRef.snapshots(),
                    builder: (context, blogSnapshot) {
                      if (!blogSnapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final blogs = blogSnapshot.data!.docs
                          .map((doc) => Blog.fromFirestore(doc))
                          .toList();

                      return blogs.isEmpty
                          ? const Center(
                              child: Text("No Blogs uploaded"),
                            )
                          : ListView.builder(
                              itemCount: blogs.length,
                              itemBuilder: (context, index) {
                                final blog = blogs[index];
                                return Card(
                                  color: Colors.green.shade50,
                                  shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                blog.title,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          blog.imageUrl.isNotEmpty
                                              ? CachedNetworkImage(
                                                  imageUrl: blog.imageUrl,
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          blog.content,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (currentUser.uid == blog.userId)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                // Navigate to the edit screen with blog data
                                                _editBlog(context, blog);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                _deleteBlog(context, blog.id);
                                              },
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<int> _getCount(List<String> ids) async {
    return ids.length;
  }

  void _editBlog(BuildContext context, Blog blog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBlogScreen(blog: blog),
      ),
    );
  }

  void _deleteBlog(BuildContext context, String blogId) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Blog'),
        content: const Text('Are you sure you want to delete this blog?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmDelete) {
      await FirebaseFirestore.instance.collection('blogs').doc(blogId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Blog deleted successfully')),
      );
    }
  }
}
