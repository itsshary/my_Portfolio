import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/Models/offline_news_model.dart';
import 'package:news_app/screen/splash_screen/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(OfflineNewsModelAdapter());
  await Hive.openBox<OfflineNewsModel>('news');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
