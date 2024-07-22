 

// class FirebasestorageHelper {
//   static FirebasestorageHelper instance = FirebasestorageHelper();
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<String> uploaduserimage(File image) async {
//     String userid = FirebaseAuth.instance.currentUser!.uid;
//     TaskSnapshot taskSnapshot = await _storage.ref(userid).putFile(image);
//     String imageurl = await taskSnapshot.ref.getDownloadURL();
//     return imageurl;
//   }
// }
