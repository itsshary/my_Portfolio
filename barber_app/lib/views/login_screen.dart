import 'package:barber_app_with_admin_panel/resorces/app_colors/app_colors.dart';
import 'package:barber_app_with_admin_panel/resorces/appstrings/appstrings.dart';
import 'package:barber_app_with_admin_panel/resorces/extension/extension.dart';
import 'package:barber_app_with_admin_panel/resorces/text_styles.dart/app_text_style.dart';
import 'package:barber_app_with_admin_panel/resorces/widgets/roundbutton.dart';
import 'package:barber_app_with_admin_panel/resorces/widgets/spin_kit.dart';
import 'package:barber_app_with_admin_panel/resorces/widgets/top_container_login.dart';
import 'package:barber_app_with_admin_panel/utils/routes/routes_name.dart';
import 'package:barber_app_with_admin_panel/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LogninScreen extends StatefulWidget {
  const LogninScreen({Key? key}) : super(key: key);

  @override
  State<LogninScreen> createState() => _LogninScreenState();
}

class _LogninScreenState extends State<LogninScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passwordC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return ModalProgressHUD(
      inAsyncCall: viewModel.isloading,
      progressIndicator: const SpinKitFlutter(),
      child: Scaffold(
        body: Stack(
          children: [
            const TopContainerTwo(),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                        controller: emailC,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.email,
                              color: AppColors.textFieldIconColor),
                        ),
                      ),
                      10.sH,
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        controller: passwordC,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          prefixIcon: Icon(Icons.lock,
                              color: AppColors.textFieldIconColor),
                        ),
                      ),
                      15.sH,
                      Button(
                        textcolor: AppColors.whiteColor,
                        bgcolor: AppColors.signInButtonColor,
                        title: 'SignIn',
                        ontap: () async {
                          if (_key.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            try {
                              await viewModel.loginViewModel(emailC.text.trim(),
                                  passwordC.text.trim(), context);
                              clearFields();
                            } catch (e) {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("$e"),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      Row(
                        children: [
                          Text(signingText,
                              style: AppTextStyle.donthaveaccount),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routesname.signUp);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: AppColors.firstGradientColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearFields() {
    passwordC.clear();
    emailC.clear();
  }
}
