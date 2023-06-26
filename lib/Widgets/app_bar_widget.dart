import 'package:flutter/material.dart';

PreferredSizeWidget homeAppBar(String title, IconData icon,
    GestureTapCancelCallback press, bool backLeading, double leadingwidth) {
  return AppBar(
    leadingWidth: leadingwidth,
    automaticallyImplyLeading: backLeading,
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 25,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          press;
        },
        icon: Icon(
          icon,
          size: 25,
          color: Colors.black,
        ),
      ),
    ],
  );
}

PreferredSizeWidget constAppBar(String title, BuildContext context) {
  return AppBar(
    leadingWidth: 25,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    ),
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 25,
      ),
    ),
  );
}
