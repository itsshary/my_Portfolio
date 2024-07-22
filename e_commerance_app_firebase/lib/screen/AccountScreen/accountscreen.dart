import 'package:e_commerance_app_firebase/models/fluttertoast/toastmessage.dart';
import 'package:e_commerance_app_firebase/provider/app_Provider.dart';
import 'package:e_commerance_app_firebase/screen/favourite_Screen/favouriteScreen.dart';
import 'package:e_commerance_app_firebase/widge/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 
import 'package:provider/provider.dart';

import '../changePassword.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _auth = FirebaseAuth.instance;
  void signout() async {
    await _auth.signOut().then((value) {
      Utilies().toast("Logout SuccessFully");
    }).onError((error, stackTrace) {
      Utilies().toast(error.toString());
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 50,
                    child: Icon(
                      color: Colors.white,
                      Icons.person,
                      size: 70,
                    ),
                  ),
                  Text(
                    appProvider.getuserinformation.name.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    appProvider.getuserinformation.email.toString(),
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const OrderScreen(),
                        //     ));
                      },
                      leading: const Icon(Icons.shopping_bag_outlined),
                      title: const Text('Your Order'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FavouriteScreen(),
                            ));
                      },
                      leading: const Icon(Icons.favorite_outline),
                      title: const Text('Favourite'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.info_outline),
                      title: const Text('About Us'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.support_agent_outlined),
                      title: const Text('Support'),
                    ),
                    ListTile(
                      onTap: () {
                        Routes().push(const ChangePasword(), context);
                      },
                      leading: const Icon(Icons.lock_outline),
                      title: const Text('Change Password'),
                    ),
                    ListTile(
                      onTap: () {
                        signout();
                        setState(() {});
                      },
                      // onTap: () async {
                      //   await _auth.signOut();
                      //   setState(() {});
                      // },
                      leading: const Icon(Icons.logout),
                      title: const Text('LogOut'),
                    ),
                    const Text('Version 1.0.0'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
