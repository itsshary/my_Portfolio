import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/categories_news_models.dart';
import 'package:news_app/repositiary/news_repositary/news_repository.dart';
import 'package:news_app/viewModel/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> btnCategories = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  NewsViewModel newsViewModel = NewsViewModel();
  final formate = DateFormat('MMMM dd,yyyy');
  String categoryName = "General";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: btnCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryName = btnCategories[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categoryName == btnCategories[index]
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Center(
                              child: Text(
                            btnCategories[index].toString(),
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 13.0),
                          )),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<CategoeriesNewsModel>(
                future: NewsRepository().fetchCategoriesNews(categoryName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
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
                                  errorWidget: (context, url, error) =>
                                      const Icon(
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
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                        Expanded(
                                          child: Text(
                                            formate.format(dateTime),
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
