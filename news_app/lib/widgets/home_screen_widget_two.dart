import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/new_channel_headlines_model.dart';
import 'package:news_app/screen/news_details_screen/news_details_screen.dart';
import 'package:news_app/viewModel/news_view_model.dart';

enum Filterlist { bbcNews, aryNews, cbc, alJezeera }

class HomeScreenWidgetTwo extends StatefulWidget {
  HomeScreenWidgetTwo({super.key});

  @override
  State<HomeScreenWidgetTwo> createState() => _HomeScreenWidgetTwoState();
}

class _HomeScreenWidgetTwoState extends State<HomeScreenWidgetTwo> {
  final formate = DateFormat('MMMM dd,yyyy');

  Filterlist? selectedvalue;

  NewsViewModel newsViewModel = NewsViewModel();

  String name = "bbc-news";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return SizedBox(
      height: height * .55,
      width: width,
      child: FutureBuilder<NewsChannelsHeadlinesModel>(
        future: newsViewModel.fetchNewsChanelHeadlinesapi(name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitCircle(
              size: 50,
              color: Colors.blue,
            );
          } else {
            return Expanded(
              flex: 3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.articles!.length,
                itemBuilder: (context, index) {
                  DateTime dateTime = DateTime.parse(
                      snapshot.data!.articles![index].publishedAt.toString());
                  return SizedBox(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsDetailScreen(
                                      snapshot.data!.articles![index].urlToImage
                                          .toString(),
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      snapshot
                                          .data!.articles![index].publishedAt
                                          .toString(),
                                      snapshot.data!.articles![index].author
                                          .toString(),
                                      snapshot
                                          .data!.articles![index].description
                                          .toString(),
                                      snapshot.data!.articles![index].content
                                          .toString(),
                                      snapshot
                                          .data!.articles![index].source!.name
                                          .toString(),
                                    )));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height * .6,
                            width: width * .9,
                            padding:
                                EdgeInsets.symmetric(horizontal: height * .02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const SpinKitCircle(
                                  color: Colors.black,
                                  size: 50,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.all(15.0),
                                height: height * .22,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width * 0.7,
                                      child: Text(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            formate.format(dateTime),
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
