import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();
  Future<dynamic> pushandremovedunti(Widget, BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Widget,
        ),
        (route) => false);
  }

  //push function

  Future<dynamic> push(Widget, BuildContext context) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Widget));
  }
}
