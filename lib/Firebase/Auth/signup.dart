import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Firebase/Firestore/user_to_firestore.dart';
import 'package:for_rent/Screens/upload_item_screen.dart';

final _auth = FirebaseAuth.instance;
final uid = _auth.currentUser?.uid;

class FireAuth {
  auth(String email, String password, String firstname, String lastname,
      String phone, BuildContext context) async {
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const UploadScreen()));

    UserToFirestore()
        .uploadUser(newUser, firstname, lastname, phone, email, uid!);
  }

  signout() {
    FirebaseAuth.instance.signOut();
  }
}
