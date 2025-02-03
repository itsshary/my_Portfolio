import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Models/categories_news_models.dart';
import 'package:news_app/Models/new_channel_headlines_model.dart';

class NewsRepository {
  //must save in secure storage

  String url = '';

  Future<NewsChannelsHeadlinesModel> fetchNewsChanelHeadlinesapi() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String newsChannel) async {
    String newsUrl = '';

    final response = await http.get(Uri.parse(newsUrl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  Future<CategoeriesNewsModel> fetchCategoriesNews(String category) async {
    String newsUrl = ' ';

    final response = await http.get(Uri.parse(newsUrl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoeriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}
