import 'package:blog_app_firebase/models/bolg_model.dart';
import 'package:blog_app_firebase/screens/blog_details_view/blog_details_view.dart';
import 'package:blog_app_firebase/screens/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:blog_app_firebase/screens/comments_screen/comments_section.dart';
import 'package:blog_app_firebase/screens/home_screen/home_screen.dart';
import 'package:blog_app_firebase/screens/offline_save_blog_screen/offline_blogs_save.dart';
import 'package:blog_app_firebase/screens/splash_screen/splash_screen.dart';
import 'package:blog_app_firebase/screens/upload_blogs/upload_blogs.dart';
import 'package:blog_app_firebase/screens/user_profile_screen/user_profile.dart';
import 'package:blog_app_firebase/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import '../../../screens/auth_screens/forget_password.dart';
import '../../../screens/auth_screens/login_screen.dart';
import '../../../screens/auth_screens/signup_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routesname.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case Routesname.homescreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case Routesname.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LogninScreen());
      case Routesname.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());
      case Routesname.blogdetailsview:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlogDetailsView(
                  blog: settings.arguments as Blog,
                ));
      case Routesname.commentsectionscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CommentSectionScreen());
      case Routesname.saveofflineblogs:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SaveBlogsOffline());
      case Routesname.userprofile:
        return MaterialPageRoute(
            builder: (BuildContext context) => UserProfile(
                  userId: settings.arguments as String,
                ));
      case Routesname.forgetpassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgetPassword());
      case Routesname.uploadBlogs:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UploadBlogs());
      case Routesname.bottomNavigationbarScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavigationScreen());

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
