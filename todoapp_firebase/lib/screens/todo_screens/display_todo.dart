import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_firebase/firebase/auth_logics/auth_logics.dart';
import 'package:todoapp_firebase/utils/routes/routes_name.dart';
import 'package:todoapp_firebase/utils/utilis.dart';
import 'package:todoapp_firebase/utils/widgets/app_colors/app_colors.dart';
import 'package:todoapp_firebase/utils/widgets/text_styles.dart/app_text_style.dart';

class DisplayTodo extends StatefulWidget {
  const DisplayTodo({super.key});

  @override
  State<DisplayTodo> createState() => _DisplayTodoState();
}

class _DisplayTodoState extends State<DisplayTodo> {
  final editcotroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("Todos").snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('Todos');
  @override
  void dispose() {
    // TODO: implement dispose
    editcotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AuthLogics.instance.logout(context);
            },
            icon: const Icon(Icons.logout)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Add Todo',
          style: AppTextStyle.defaulttextsize.copyWith(color: Colors.black),
        ),
        backgroundColor: AppColors.backgroundcolor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundcolor,
        onPressed: () {
          Navigator.pushNamed(context, Routesname.addTodoScreen);
        },
        shape:
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        padding: const EdgeInsets.all(20.0),
                        borderRadius: BorderRadius.circular(10.0),
                        onPressed: (context) {
                          // Delete functionality

                          ref
                              .doc(snapshot.data!.docs[index]['id'].toString())
                              .delete();
                          ToastMsg.toastMessage("Todo Deleted Successfully");
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          // // Update functionality
                          showmydialog(editcotroller.text,
                              snapshot.data!.docs[index]['id'].toString());
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Update',
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      tileColor: Colors.amber.shade200,
                      title:
                          Text(snapshot.data!.docs[index]['title'].toString()),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              "Last Edit:${snapshot.data!.docs[index]['time']}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  //for update Todo
  Future<void> showmydialog(String currentTitle, String id) async {
    editcotroller.text = currentTitle;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update'),
          content: Container(
            color: Colors.amber.shade200,
            child: TextField(
              controller: editcotroller,
              decoration: const InputDecoration(hintText: 'Enter text'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final now = DateTime.now();
                final formattedDate = DateFormat('yyyy-MM-dd').format(now);
                final formattedTime = DateFormat('HH:mm:ss').format(now);
                String updatedTitle = editcotroller.text;

                // Update the Firestore document with the new title and timestamp
                ref.doc(id).update({
                  'title': updatedTitle,
                  'time': "$formattedDate, $formattedTime",
                }).then((_) {
                  ToastMsg.toastMessage("Todo Updated");
                }).catchError((error) {
                  ToastMsg.toastMessage("Failed to update Todo: $error");
                });

                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
