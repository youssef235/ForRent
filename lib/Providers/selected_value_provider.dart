import 'package:flutter/material.dart';

class ValueProvider with ChangeNotifier {
  String? CategoryValue;
  void changedvalue(String value) async {
    CategoryValue = value;
    notifyListeners();
  }
}
