import 'package:barber_app_with_admin_panel/resorces/app_colors/app_colors.dart';
import 'package:barber_app_with_admin_panel/utils/routes/routes_name.dart';
import 'package:barber_app_with_admin_panel/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget(
      {super.key,
      required this.name,
      required this.email,
      required this.imageurl});
  final String name;
  final String email;
  final String? imageurl;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Uri? link;
  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.secondGradientColor,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.secondGradientColor),
                accountName: Text(
                  widget.name.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                accountEmail: Text(widget.email.toString()),
                currentAccountPictureSize: const Size.square(50),
                // ignore: unnecessary_null_comparison
                currentAccountPicture: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      widget.imageurl.toString(),
                    ))),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.pushNamed(context, Routesname.profileedit,
                  arguments: [widget.imageurl, widget.name]);
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_active_rounded),
            title: const Text('Active Service'),
            onTap: () {
              Navigator.pushNamed(context, Routesname.activeservice);
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Shop Location'),
            onTap: () async {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              authViewModel.logoutauthview(context);
            },
          ),
        ],
      ),
    );
  }
}
