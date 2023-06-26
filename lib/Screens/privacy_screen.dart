// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Components/custom_button.dart';
import 'package:for_rent/Providers/get_location_provider.dart';
import 'package:for_rent/Providers/user_data_provider.dart';
import 'package:for_rent/Widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../Components/coustom_textformfield.dart';

class PrivacyScreen extends StatelessWidget with ChangeNotifier {
  PrivacyScreen({super.key});

  TextEditingController Namecontroller = TextEditingController();
  TextEditingController LastnameController = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController AddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserDataProvider>(context);
    var location = Provider.of<GetLocationProvider>(context);
    Namecontroller.text = userData.username ?? "Loading ...";
    LastnameController.text = userData.lastname ?? "Loading ...";
    Phonecontroller.text = userData.phoneNumber ?? "Loading ...";
    AddressController.text = userData.address ?? "Loading ...";

    final formKey = GlobalKey<FormState>();

    String uid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference reference =
        FirebaseFirestore.instance.collection('Users');

    CustomTextFormField CTFF = CustomTextFormField();
    CustomButton CB = CustomButton();

    return Scaffold(
      appBar: constAppBar("Privacy", context),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CTFF.customtextformfield(
                  Namecontroller, "Enter a valid name", 5, Icons.person, true),
              CTFF.customtextformfield(LastnameController, "Enter a valid name",
                  5, Icons.person, true),
              CTFF.customtextformfield(Phonecontroller,
                  "Enter a valid phone number", 11, Icons.phone, true),
              CTFF.customtextformfield(
                  AddressController, "", 5, Icons.location_on, false),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      location.getLocation(context);
                      userData.address =
                          "${location.country} , ${location.province} , ${location.street}";

                      notifyListeners();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0)),
                    ),
                    child: const Center(child: Text('Refresh Location')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CB.customButton("Save", Colors.black, () {
                        if (formKey.currentState!.validate()) {
                          reference.doc(uid).update({
                            "firstname": Namecontroller.text,
                            "lastname": LastnameController.text,
                            "phone": Phonecontroller.text,
                            "address": AddressController.text,
                          });
                          print("VALIDATE");
                        }
                      }),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Expanded(
                        child:
                            CB.customButton("Cancel", Colors.black, () => null))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
