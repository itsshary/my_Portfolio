import 'package:barber_app_with_admin_panel/services/firebase/firebase_auth/firebase_auth_helper.dart';
import 'package:barber_app_with_admin_panel/utils/routes/routes_name.dart';
import 'package:barber_app_with_admin_panel/utils/utilis.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  FirebaseAuthHelper authservices = FirebaseAuthHelper();
  bool _isLoading = false;
  bool get isloading => _isLoading;
  Future signupViewModel(
      String image,String email, String name, String password, BuildContext context) async {
    _isLoading = true; // Set loading to true before signing up
    notifyListeners();
    await authservices
        .signUp(image,name, email, password, context)
        .onError((error, stackTrace) {
      ToastMsg.toastMessage(error.toString());
    });
    _isLoading = false; // Set loading to true before signing up
    notifyListeners();
  }

  Future loginViewModel(
      String email, String password, BuildContext context) async {
    _isLoading = true; // Set loading to true before signing up
    notifyListeners();
    await authservices.loginFunction(email, password, context);
    _isLoading = false; // Set loading to true before signing up
    notifyListeners();
  }

  Future logoutauthview(BuildContext context) async {
    await authservices.logoutfun().then((value) {
      Navigator.pushReplacementNamed(context, Routesname.login);
      ToastMsg.toastMessage("Logout SuccessFully");
    });
    notifyListeners();
  }
}
