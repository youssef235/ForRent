// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

class CustomTextFormField {
  Widget customtextformfield(TextEditingController controller,
      String errorMessage, int AcceptableLength, IconData icon, bool enable) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                enabled: enable,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15), // add padding to adjust icon
                    child: Icon(icon),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                validator: (val) {
                  if ((val!.length < AcceptableLength)) {
                    return errorMessage;
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
