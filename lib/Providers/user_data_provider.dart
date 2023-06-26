// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:for_rent/Firebase/Firestore/user_to_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UserDataProvider with ChangeNotifier {
  File? PHOTO;
  String? profileurl;
  String? username;
  String? lastname;
  String? phoneNumber;
  String? ownerpic;
  String? address;
  String? fileName;
  String? destination;
  File? photo;
  bool ischanged = false;
  bool ispressed = false;

  Future imgFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedFile != null) {
        ispressed = true;
        PHOTO = File(pickedFile.path);
        fileName = basename(PHOTO!.path);
        photo = PHOTO!;
        ischanged = true;

        notifyListeners();
      }
    } catch (error) {
      if (kDebugMode) {
        print('THIS IS ERROR {$error}');
      }
    }
  }

  UploadToFirebase() async {
    profileurl = null;
    ispressed = false;
    destination = 'files/$fileName';
    final ref = FirebaseStorage.instance.ref(destination).child('file/');
    await ref.putFile(PHOTO!);
    profileurl = await ref.getDownloadURL();
    UserToFirestore().setprofilepic(profileurl!);
    ischanged = false;
    notifyListeners();
  }

  getprofilepic(String uid) {
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) {
      profileurl = value.data()!["profilepic"];
      notifyListeners();
    });
  }

  getusername(String uid) {
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) {
      username = value.data()!["firstname"];
      notifyListeners();
    });
  }

  getuserLastname(String uid) {
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) {
      lastname = value.data()!["lastname"];
      notifyListeners();
    });
  }

  getuserPhNumber(String uid) {
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) {
      phoneNumber = value.data()!["phone"];
      notifyListeners();
    });
  }

  getuserAddress(String uid) {
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) {
      address = value.data()!["address"];
      notifyListeners();
    });
  }

  getuserPic(String uid) {
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) {
      ownerpic = value.data()!["profilepic"];
      notifyListeners();
    });
  }
}
