import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoProvider with ChangeNotifier {
  File? PHOTO;

  Future imgFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedFile != null) {
        PHOTO = File(pickedFile.path);
        notifyListeners();
      }
    } catch (error) {
      print('THIS IS ERROR {$error}');
    }
  }
}
