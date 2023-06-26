import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserToFirestore {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Users');

  uploadUser(var newUser, String firstname, String lastname, String phone,
      String email, String userid) {
    if (newUser != null) {
      Map<String, dynamic> dataToSend = {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'phone': phone,
        'userid': userid,
      };
      _reference.doc(userid).set(dataToSend).catchError((e) {
        ("EEEERRROOOORRR $e");
      });
    }
  }

  setprofilepic(String imgurl) {
    _reference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'profilepic': imgurl})
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
  }
}
