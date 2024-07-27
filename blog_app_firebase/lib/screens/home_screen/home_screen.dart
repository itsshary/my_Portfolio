import 'package:blog_app_firebase/firebase/cloud_firestore/firestore.dart';
import 'package:flutter/material.dart';

import 'package:blog_app_firebase/models/bolg_model.dart';
import 'package:blog_app_firebase/models/usermodel.dart';
import 'package:blog_app_firebase/screens/blog_details_view/blog_details_view.dart';
import 'package:blog_app_firebase/utils/app_colors/app_colors.dart';
import 'package:blog_app_firebase/utils/routes/routes_name.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.floatingactionbuttoncolor,
        shape: OutlineInputBorder(
            borderSide: const BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(50.0)),
        onPressed: () {
          Navigator.pushNamed(context, Routesname.uploadBlogs);
        },
        child: const FaIcon(
          FontAwesomeIcons.penToSquare,
          color: AppColors.whiteColor,
        ),
      ),
      body: StreamBuilder<List<Blog>>(
        stream: CloudFirestoreHelper().streamBlogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                  title: Container(
                    color: Colors.grey,
                    height: 16,
                    width: 100,
                  ),
                  subtitle: Container(
                    color: Colors.grey,
                    height: 16,
                    width: 150,
                  ),
                ),
              ),
            );
          }

          List<Blog> blogs = snapshot.data!;
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              Blog blog = blogs[index];
              return FutureBuilder<UserModel?>(
                future: CloudFirestoreHelper().fetchUser(blog.userId),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Container(
                        color: Colors.grey,
                        height: 50,
                        width: 100,
                      ),
                      subtitle: Container(
                        color: Colors.grey,
                        height: 50,
                        width: 150,
                      ),
                    );
                  }

                  UserModel user = userSnapshot.data!;
                  return FutureBuilder<int>(
                    future: CloudFirestoreHelper().getLikesCount(blog.id),
                    builder: (context, likesCountSnapshot) {
                      int numberOfLikes = likesCountSnapshot.data ?? 0;

                      return Card(
                        margin: const EdgeInsets.all(10),
                        color: Colors.green.shade50,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BlogDetailsView(blog: blog),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    user.image!,
                                  ),
                                ),
                                title: Text(
                                  user.name!,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                  CachedNetworkImage(
                                    imageUrl: blog.imageUrl,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const SpinKitCircle(
                                      color: Colors.green,
                                      size: 50.0,
                                      duration: Duration(seconds: 3),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  blog.content,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('$numberOfLikes Likes'),
                                    Text('${blog.comments.length} Comments'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
