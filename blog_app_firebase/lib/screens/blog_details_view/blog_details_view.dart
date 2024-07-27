import 'package:blog_app_firebase/provider/blogprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_app_firebase/models/bolg_model.dart';
import 'package:blog_app_firebase/models/usermodel.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogDetailsView extends StatefulWidget {
  final Blog blog;

  const BlogDetailsView({super.key, required this.blog});

  @override
  State<BlogDetailsView> createState() => _BlogDetailsViewState();
}

class _BlogDetailsViewState extends State<BlogDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog.title),
      ),
      body: Consumer<BlogProvider>(
        builder: (context, blogProvider, child) {
          return FutureBuilder<UserModel?>(
            future: blogProvider.fetchUser(widget.blog.userId),
            builder: (context, snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              UserModel user = snapshot.data!;
              String formattedDate =
                  DateFormat.yMMMd().format(widget.blog.createdAt);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.blog.title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(user.image!),
                          ),
                          const SizedBox(width: 10),
                          Text(user.name!,
                              style: const TextStyle(fontSize: 20)),
                          FutureBuilder<bool>(
                            future:
                                blogProvider.isFollowing(user.id.toString()),
                            builder: (context, followSnapshot) {
                              if (followSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return TextButton(
                                  onPressed: () {},
                                  child: const Text("..."),
                                );
                              }

                              bool isFollowing = followSnapshot.data ?? false;

                              return TextButton(
                                onPressed: () => blogProvider
                                    .toggleFollow(user.id.toString()),
                                child:
                                    Text(isFollowing ? "Unfollow" : "Follow"),
                              );
                            },
                          ),
                        ],
                      ),
                      Text(formattedDate,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 20),
                      widget.blog.imageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: widget.blog.imageUrl,
                              height: 300,
                              width: double.infinity,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      Text(widget.blog.content,
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      LikeCommentSection(blog: widget.blog),
                      const SizedBox(height: 20),
                      const Text(
                        'Comments',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<List<Comment>>(
                        stream: blogProvider.fetchComments(widget.blog.id),
                        builder: (context, commentsSnapshot) {
                          if (commentsSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (commentsSnapshot.hasError) {
                            return const Center(
                                child: Text('Error loading comments'));
                          }

                          List<Comment> comments = commentsSnapshot.data ?? [];

                          if (comments.isEmpty) {
                            return const Center(
                                child: Text('No comments yet. Be the first!'));
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return _buildCommentItem(
                                  comments[index], blogProvider);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCommentItem(Comment comment, BlogProvider blogProvider) {
    return FutureBuilder<UserModel?>(
      future: blogProvider.fetchUser(comment.userId),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            title: Text('Loading user...'),
          );
        }

        if (userSnapshot.hasError || !userSnapshot.hasData) {
          return const ListTile(
            title: Text('User information not available'),
          );
        }

        UserModel user = userSnapshot.data!;
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.image!),
          ),
          title: Text(user.name!),
          subtitle: Text(comment.text),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class LikeCommentSection extends StatelessWidget {
  final Blog blog;

  LikeCommentSection({super.key, required this.blog});
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogProvider>(
      builder: (context, blogProvider, child) {
        return FutureBuilder<bool>(
          future: blogProvider.isBlogLiked(blog),
          builder: (context, isLikedSnapshot) {
            if (isLikedSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            bool isLiked = isLikedSnapshot.data ?? false;
            int likeCount = blog.likes.length;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                        color: isLiked ? Colors.green : null,
                      ),
                      onPressed: () => blogProvider.toggleLike(blog),
                    ),
                    Text('$likeCount'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.65,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: commentController,
                                  decoration: const InputDecoration(
                                    labelText: 'Write a comment...',
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    blogProvider.postComment(
                                        blog.id, commentController.text);
                                    Navigator.pop(context);
                                    commentController.clear();
                                  },
                                  child: const Text('Post Comment'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    StreamBuilder<List<Comment>>(
                      stream: blogProvider.fetchComments(blog.id),
                      builder: (context, commentsSnapshot) {
                        if (commentsSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (commentsSnapshot.hasError) {
                          return const Center(
                              child: Text('Error loading comments'));
                        }

                        List<Comment> comments = commentsSnapshot.data ?? [];
                        return Text('${comments.length}');
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // Implement sharing logic
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
