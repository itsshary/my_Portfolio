import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/Models/offline_news_model.dart';
import 'package:news_app/screen/news_details_screen/news_details_screen.dart';
import 'package:news_app/screen/offline_screens/offline_news_details_screen.dart';
import 'dart:io';

import '../../Models/Boxes.dart';

class OfflineNewsScreen extends StatefulWidget {
  const OfflineNewsScreen({super.key});

  @override
  State<OfflineNewsScreen> createState() => _OfflineNewsScreenState();
}

class _OfflineNewsScreenState extends State<OfflineNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Offline News"),
      ),
      body: ValueListenableBuilder<Box<OfflineNewsModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, value, child) {
          var data = value.values.toList().cast<OfflineNewsModel>();
          return data.isEmpty
              ? const Center(
                  child: Text('No News Saved Offline'),
                )
              : ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OfflineNewsDetailsScreen(
                                    newsimage: data[index].image.toString(),
                                    newstitle: data[index].title.toString(),
                                    newsdes:
                                        data[index].description.toString())));
                      },
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            height: 60,
                            width: 60,
                            child: Image.file(
                              File(data[index]
                                  .image
                                  .toString()), // Use File() to create a File object from the file path
                              fit: BoxFit.fill,
                            ),
                          ),
                          title: Text(data[index].title.toString()),
                          subtitle: Text(data[index].description.toString()),
                          trailing: IconButton(
                            onPressed: () {
                              //delete notes
                              deleteNotes(data[index]);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  void deleteNotes(OfflineNewsModel notesModel) {
    notesModel.delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(microseconds: 50),
        content: Text("Notes is Deleted"),
      ),
    );
  }
}
