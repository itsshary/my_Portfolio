import 'package:e_commerance_app_firebase/firebasehelper/firebase_auth_helper.dart';
import 'package:e_commerance_app_firebase/models/fluttertoast/toastmessage.dart';
import 'package:flutter/material.dart';
 
class ChangePasword extends StatefulWidget {
  const ChangePasword({super.key});

  @override
  State<ChangePasword> createState() => _ChangePaswordState();
}

class _ChangePaswordState extends State<ChangePasword> {
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: ListView(
        padding: EdgeInsets.all(25.0),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
                width: 3,
              )),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
                width: 3,
              )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
                width: 3,
              )),
              hintText: 'new password',
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
                width: 3,
              )),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
                width: 3,
              )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
                width: 3,
              )),
              hintText: 'enter password',
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                if (newpassword.text.isEmpty) {
                  Utilies().toast("New Password is empty");
                } else if (confirmpassword.text.isEmpty) {
                  Utilies().toast("Confirm Password is empty");
                } else {
                  if (newpassword.text == confirmpassword.text) {
                    FirebaseAuthHelper.instance
                        .changePassword(newpassword.text, context);
                  } else {
                    Utilies().toast("Confirm Password is not empty");
                  }
                }
              },
              child: const Text("Update Password"))
        ],
      ),
    );
  }
}
