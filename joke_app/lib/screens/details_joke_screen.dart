import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:joke_app/models/general_model.dart';

class JokeScreen extends StatefulWidget {
  final String type;
  final Color cardColor;

  const JokeScreen({super.key, required this.type, required this.cardColor});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  List<GeneralModel> getdatalist = [];

  Future<void> getdata() async {
    final response = await http.get(
      Uri.parse(
          'https://official-joke-api.appspot.com/jokes/${widget.type}/random'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        getdatalist.clear();
        for (var element in data) {
          getdatalist.add(GeneralModel.fromJson(element));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          '${widget.type} Joke',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: widget.cardColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.cardColor,
        onPressed: () async {
          await getdata();
        },
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: getdatalist.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: getdatalist.length,
                itemBuilder: (context, index) {
                  var joke = getdatalist[index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      child: Container(
                        height: 400,
                        width: 100,
                        decoration: BoxDecoration(
                            color: widget.cardColor,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    joke.setup!.toString(),
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Punchline: ',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                            text: joke.punchline!.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
