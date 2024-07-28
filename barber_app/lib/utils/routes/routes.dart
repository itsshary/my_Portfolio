// ignore_for_file: unreachable_switch_case

import 'package:barber_app_with_admin_panel/utils/routes/routes_name.dart';
import 'package:barber_app_with_admin_panel/views/active_service.dart';
import 'package:barber_app_with_admin_panel/views/details_screen.dart';
import 'package:barber_app_with_admin_panel/views/edit_profile.dart';
import 'package:barber_app_with_admin_panel/views/first_screen.dart';
import 'package:barber_app_with_admin_panel/views/home_screen.dart';
import 'package:barber_app_with_admin_panel/views/login_screen.dart';
import 'package:barber_app_with_admin_panel/views/signup_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routesname.firstScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FirstScreen());
      case Routesname.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case Routesname.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LogninScreen());
      case Routesname.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());
      case Routesname.detailscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => DetailsScreen(
                  services: settings.arguments as String,
                ));
      case Routesname.profileedit:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditProfile(
                  listdata: settings.arguments as List<dynamic>,
                ));
      case Routesname.activeservice:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ActiveService());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: Text("No Routes Defines"),
                  ),
                ));
    }
  }
}
