import 'package:barber_app_with_admin_panel/model/bookmodel.dart';
import 'package:barber_app_with_admin_panel/resorces/widgets/spin_kit.dart';
import 'package:barber_app_with_admin_panel/services/firebase/firebase_helper/firebase_firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_model/firestore_view_model.dart';

class ActiveService extends StatefulWidget {
  const ActiveService({Key? key}) : super(key: key);

  @override
  State<ActiveService> createState() => _ActiveServiceState();
}

class _ActiveServiceState extends State<ActiveService> {
  final formatDate = DateFormat('MMMM dd yyyy');

  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(hours: 1), () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Service"),
      ),
      body: StreamBuilder<List<BookModel>>(
        stream: FirebaseFirestoreHelper.instace.getUserOrderStream(),
        builder:
            (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFlutter(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No active services"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final bookModel = snapshot.data![index];
                final date = DateTime.parse(snapshot.data![index].date);

                return Card(
                  color: Colors.amber.shade100,
                  child: Column(
                    children: [
                      Text(
                        "Service: ${bookModel.service}",
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "Time: ${bookModel.time}",
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "Date: ${formatDate.format(date)}",
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Visibility(
                        visible: _isVisible,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle cancel booking logic here
                          },
                          child: const Text("Cancel Booking"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
