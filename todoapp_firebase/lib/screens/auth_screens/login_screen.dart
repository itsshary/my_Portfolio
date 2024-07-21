import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todoapp_firebase/firebase/auth_logics/auth_logics.dart';

import 'package:todoapp_firebase/utils/routes/routes_name.dart';
import 'package:todoapp_firebase/utils/widgets/app_colors/app_colors.dart';
import 'package:todoapp_firebase/utils/widgets/appstrings/appstrings.dart';
import 'package:todoapp_firebase/utils/extension/extension.dart';
import 'package:todoapp_firebase/utils/widgets/roundbutton.dart';
import 'package:todoapp_firebase/utils/widgets/spin_kit.dart';
import 'package:todoapp_firebase/utils/widgets/text_styles.dart/app_text_style.dart';
import 'package:todoapp_firebase/utils/widgets/top_container_login.dart';

class LogninScreen extends StatefulWidget {
  const LogninScreen({super.key});

  @override
  State<LogninScreen> createState() => _LogninScreenState();
}

class _LogninScreenState extends State<LogninScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final _key = GlobalKey<FormState>();
  final FocusNode emailnode = FocusNode();
  final FocusNode passwordnode = FocusNode();
  bool isloading = false;
  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passwordC.dispose();
    emailC.text = "";
    passwordC.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
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
                        focusNode: emailnode,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(passwordnode);
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
                        focusNode: passwordnode,
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
                            setState(() {
                              isloading = true;
                            });
                            await AuthLogics.instance
                                .loginFun(emailC.text, passwordC.text, context);
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                      ),
                      Row(
                        children: [
                          Text(signingText,
                              style: AppTextStyle.donthaveaccount),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routesname.signUp);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: AppColors.firstGradientColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routesname.forgetpassword);
                            },
                            child: Text(
                              "Forget Password",
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
}
