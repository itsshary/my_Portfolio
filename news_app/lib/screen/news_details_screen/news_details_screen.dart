import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/offline_news_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../Models/Boxes.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsImage;
  final String newsTitle;
  final String newsDate;
  final String newsAuthor;
  final String newsDesc;
  final String newsContent;
  final String newsSource;
  const NewsDetailScreen(this.newsImage, this.newsTitle, this.newsDate,
      this.newsAuthor, this.newsDesc, this.newsContent, this.newsSource);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd,yyyy');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double Kwidth = MediaQuery.of(context).size.width;
    double Kheight = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[600],
            )),
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              height: Kheight * 0.455,
              width: Kwidth,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: CachedNetworkImage(
                  imageUrl: widget.newsImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Kheight * 0.4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            height: Kheight * 0.6,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              children: [
                Text('${widget.newsTitle}',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: Kheight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.newsSource}',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      '${format.format(dateTime)}',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        onPressed: () async {
                          try {
                            final response = await HttpClient()
                                .getUrl(Uri.parse(widget.newsImage));
                            final httpClientRequest = await response.close();
                            final bytes =
                                await consolidateHttpClientResponseBytes(
                                    httpClientRequest);
                            final appDocDir =
                                await getApplicationDocumentsDirectory();

                            final uuid = Uuid();
                            final fileName =
                                '${uuid.v4()}.jpg'; // Generate a unique filename for the image
                            final filePath = '${appDocDir.path}/$fileName';

                            File(filePath).writeAsBytesSync(bytes);

                            final data = OfflineNewsModel(
                              title: widget.newsTitle,
                              description: widget.newsDesc,
                              image: filePath,
                            );
                            final box = Boxes.getData();
                            box.add(data);
                            data.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("News is Saved Offline"),
                                  duration: Duration(seconds: 1)),
                            );
                          } catch (e) {
                            print('This is an error ${e.toString()}');
                          }
                        },
                        tooltip: "Save Offline",
                        icon: const Icon(size: 40.0, Icons.save_alt))
                  ],
                ),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                Text('${widget.newsDesc}',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                Text('${widget.newsContent}',
                    // maxLines: 20,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
