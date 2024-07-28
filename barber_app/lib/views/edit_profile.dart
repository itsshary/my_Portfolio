import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  List<dynamic> listdata = [];
  EditProfile({super.key, required this.listdata});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(widget.listdata[0]),
            ),
            TextFormField(
              controller: nameC,
              decoration: InputDecoration(
                hintText: widget.listdata[1],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
