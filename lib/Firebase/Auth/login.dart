// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Screens/home_screen.dart';

final _auth = FirebaseAuth.instance;
final uid = _auth.currentUser?.uid;

class FireLogIn {
  LogIn(String email, String password, BuildContext context) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
