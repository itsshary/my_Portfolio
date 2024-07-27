import 'dart:io';

import 'package:blog_app_firebase/provider/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadBlogs extends StatelessWidget {
  const UploadBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UploadBlogsProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Blog'),
        ),
        body: Consumer<UploadBlogsProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: provider.key,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: provider.pickImage,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: provider.image == null
                              ? Center(child: Text('Tap to select an image'))
                              : Image.file(
                                  File(provider.image!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: provider.titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: provider.contentController,
                        decoration: const InputDecoration(
                          labelText: 'Content',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter content';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      provider.isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () => provider.uploadBlog(context),
                              child: Text('Submit'),
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
