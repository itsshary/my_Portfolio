import 'package:flutter/material.dart';
import 'package:quiz_app/controller/App_controller.dart';

import 'package:quiz_app/utilis/applists.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Applists.instance.topic.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () => AppController.instance
                  .navigateToQuiz(Applists.instance.topic[index], context),
              child: Card(
                color: Applists.instance.bgcolor[index],
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 100.0,
                        width: 100.0,
                        Applists.instance.images[index],
                        scale: 1.0,
                      ),
                      Text(
                        Applists.instance.topic[index],
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
