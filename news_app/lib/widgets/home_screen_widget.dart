import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/categories_news_models.dart';
import 'package:news_app/repositiary/news_repositary/news_repository.dart';

class HomeScreenWidget extends StatelessWidget {
  HomeScreenWidget({super.key});
  final formate = DateFormat('MMMM dd,yyyy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<CategoeriesNewsModel>(
        future: NewsRepository().fetchCategoriesNews("General"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitCircle(
              size: 50,
              color: Colors.blue,
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: snapshot.data!.articles!.length,
              itemBuilder: (context, index) {
                DateTime dateTime = DateTime.parse(
                    snapshot.data!.articles![index].publishedAt.toString());
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!.articles![index].urlToImage
                              .toString(),
                          fit: BoxFit.cover,
                          height: height * .18,
                          width: width * .3,
                          placeholder: (context, url) => Container(
                            child: const Center(
                              child: SpinKitCircle(
                                color: Colors.blue,
                                size: 50,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: height * .18,
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data!.articles![index].title
                                    .toString(),
                                maxLines: 3,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      snapshot
                                          .data!.articles![index].source!.name
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text(
                                    formate.format(dateTime),
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
