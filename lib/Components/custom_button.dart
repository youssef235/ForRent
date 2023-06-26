import 'package:flutter/material.dart';

class CustomButton {
  Widget customButton(String text, Color color, Function() press) {
    return SizedBox(
      width: 75,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
        ),
        child: Text(text),
      ),
    );
  }
}
