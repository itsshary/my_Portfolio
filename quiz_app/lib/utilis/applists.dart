import 'dart:ui';

class Applists {
  static Applists instance = Applists();

  List<String> topic = ["C++", "Python", "JavaScript"];
  List<String> images = [
    "images/c++.png",
    "images/python.png",
    "images/js.png"
  ];

  List<Color> bgcolor = [
    const Color.fromARGB(255, 8, 134, 238),
    const Color.fromARGB(255, 240, 226, 30),
    const Color.fromARGB(255, 206, 160, 21),
  ];
}
