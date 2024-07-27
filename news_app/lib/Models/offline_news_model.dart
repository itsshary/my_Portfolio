import 'package:hive/hive.dart';

part 'offline_news_model.g.dart';

@HiveType(typeId: 0)
class OfflineNewsModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? image;
  OfflineNewsModel(
      {required this.title, required this.description, required this.image});
}
