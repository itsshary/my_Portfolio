import 'package:hive/hive.dart';
import 'package:news_app/Models/offline_news_model.dart';

class Boxes {
  static Box<OfflineNewsModel> getData() => Hive.box<OfflineNewsModel>('news');
}
