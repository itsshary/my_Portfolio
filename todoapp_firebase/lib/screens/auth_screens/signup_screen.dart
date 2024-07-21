import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todoapp_firebase/firebase/auth_logics/auth_logics.dart';
import 'package:todoapp_firebase/utils/widgets/app_colors/app_colors.dart';
import 'package:todoapp_firebase/utils/extension/extension.dart';
import 'package:todoapp_firebase/utils/widgets/roundbutton.dart';
import 'package:todoapp_firebase/utils/widgets/spin_kit.dart';
import 'package:todoapp_firebase/utils/widgets/top_container.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final FocusNode emailnode = FocusNode();
  final FocusNode passwordnode = FocusNode();
  final _key = GlobalKey<FormState>();
  bool isloading = false;
  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    emailnode.dispose();
    passwordnode.dispose();
    passwordC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: isloading,
      progressIndicator: const SpinKitFlutter(),
      child: Stack(
        children: [
          const TopContainer(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 30.0, left: 20.0, right: 20, top: 20.0),
              child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
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
                        focusNode: emailnode,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: 'Enter Email',
                            prefixIcon: Icon(Icons.email,
                                color: AppColors.textFieldIconColor)),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(passwordnode);
                        },
                      ),
                      20.sH,
                      TextFormField(
                        controller: passwordC,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        obscureText: true,
                        focusNode: passwordnode,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: 'Enter Password',
                            prefixIcon: Icon(Icons.lock,
                                color: AppColors.textFieldIconColor)),
                      ),
                      50.sH,
                      Button(
                          bgcolor: AppColors.firstGradientColor,
                          title: "SignUp",
                          textcolor: AppColors.whiteColor,
                          ontap: () async {
                            if (_key.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                isloading = true;
                              });
                              await AuthLogics.instance
                                  .signup(emailC.text, passwordC.text, context);
                              setState(() {
                                isloading = false;
                              });
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
