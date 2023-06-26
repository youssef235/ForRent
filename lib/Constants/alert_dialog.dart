import 'package:flutter/material.dart';

class AlertDialod {
  void alert(BuildContext context, Function() press) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Sure!'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('The product will be completely Delleted'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(child: const Text('Yes'), onPressed: press),
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }
}
