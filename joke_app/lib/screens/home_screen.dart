import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:joke_app/models/funny_model.dart';
import 'package:http/http.dart' as http;
import 'package:joke_app/screens/details_joke_screen.dart';
import 'package:joke_app/widgets/card_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Fetch data from API based on the type
  Future<FunnyModel?> getdata(String type) async {
    final response = await http.get(
      Uri.parse('https://official-joke-api.appspot.com/jokes/$type/random'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return FunnyModel.fromJson(data);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Joke App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue.shade900,
      ),
      body: GridView(
        padding: const EdgeInsets.all(5.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.8,
          mainAxisExtent: 120,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JokeScreen(
                    type: 'programming',
                    cardColor: Colors.deepPurple.shade400,
                  ),
                ),
              );
            },
            child: const CustomContainer(
              imageUrl:
                  'https://images.pexels.com/photos/1089440/pexels-photo-1089440.jpeg',
              text: 'Programming',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JokeScreen(
                    type: 'knock-knock',
                    cardColor: Colors.amber.shade200,
                  ),
                ),
              );
            },
            child: const CustomContainer(
              imageUrl:
                  'https://images.pexels.com/photos/6670219/pexels-photo-6670219.jpeg',
              text: 'Knock-Knock',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JokeScreen(
                    type: 'general',
                    cardColor: Colors.deepOrange.shade400,
                  ),
                ),
              );
            },
            child: const CustomContainer(
              imageUrl:
                  'https://images.pexels.com/photos/11629494/pexels-photo-11629494.jpeg',
              text: 'General',
            ),
          ),
        ],
      ),
    );
  }
}
