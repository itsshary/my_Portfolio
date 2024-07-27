import 'package:news_app/Models/categories_news_models.dart';
import 'package:news_app/Models/new_channel_headlines_model.dart';
import 'package:news_app/repositiary/news_repositary/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();
  Future<NewsChannelsHeadlinesModel> fetchNewsChanelHeadlinesapi(
      String name) async {
    final response = await _rep.fetchNewsChannelHeadlinesApi(name);
    return response;
  }

  Future<CategoeriesNewsModel> fetchCategoriesNews(String name) async {
    final response = await _rep.fetchCategoriesNews(name);
    return response;
  }
}
