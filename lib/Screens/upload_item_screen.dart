// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Constants/CircularProgress.dart';
import 'package:for_rent/Constants/enums.dart';
import 'package:for_rent/Firebase/Firestore/item_to_firestore.dart';
import 'package:for_rent/Providers/get_location_provider.dart';
import 'package:for_rent/Providers/selected_value_provider.dart';
import 'package:for_rent/Providers/item_photo_provider.dart';
import 'package:for_rent/Providers/user_data_provider.dart';
import 'package:for_rent/Themes/theme_helper.dart';
import 'package:for_rent/Widgets/app_bar_widget.dart';
import 'package:for_rent/Widgets/select_catigory.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../Components/coustom_bottom_nav_bar.dart';
import '../Widgets/Uploaded_Photo_widget.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? imageUrl;
  String? fileName;
  String? destination;
  File? photo;

  TextEditingController itemNameEditingController = TextEditingController();
  TextEditingController itemDescriptionEditingController =
      TextEditingController();
  TextEditingController itemPriceEditingController = TextEditingController();

  String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    var selectedValueProvider = Provider.of<ValueProvider>(context);
    var UrlProvider = Provider.of<PhotoProvider>(context);
    var location = Provider.of<GetLocationProvider>(context);
    var userDatalProvider = Provider.of<UserDataProvider>(context);

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: constAppBar("Upload Your Item", context),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Center(
                  child: PhotoWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: itemNameEditingController,
                    decoration: ThemeHelper()
                        .textInputDecoration('Item Name', 'Enter itme name'),
                    validator: (val) {
                      if ((val!.isEmpty) || val.length < 5) {
                        return "Enter a valid name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: itemDescriptionEditingController,
                    decoration: ThemeHelper().textInputDecoration(
                        'Item Description', 'Enter itme description'),
                    validator: (val) {
                      if ((val!.isEmpty) || val.length < 25) {
                        return "Enter more description";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
                    controller: itemPriceEditingController,
                    keyboardType: TextInputType.number,
                    decoration: ThemeHelper().textInputDecoration(
                        'Rent Price (Per a DAY)', 'price (per a day)'),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Rent Price";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectCatigory(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 59, 59, 59),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 15.0 // Background color
                              ),
                          onPressed: () {
                            location.country = "";
                            location.province = "";
                            location.street = "";
                            location.getLocation(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Check Address",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 71, 71),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (location.country == "" ||
                              location.province == "" ||
                              location.street == "") {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc) {
                                  return SafeArea(
                                    child: Wrap(
                                      children: const <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.error),
                                          title: Text(
                                              'Error : Location is not specified'),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            Progress().showLoaderDialog(context);
                            userDatalProvider.getuserPhNumber(uid!);
                            userDatalProvider.getuserPic(uid!);
                            fileName = basename(UrlProvider.PHOTO!.path);
                            photo = UrlProvider.PHOTO!;
                            destination = 'files/$fileName';
                            final ref = FirebaseStorage.instance
                                .ref(destination)
                                .child('file/');
                            await ref.putFile(UrlProvider.PHOTO!);
                            imageUrl = await ref.getDownloadURL();
                            //Upload To FIRESTORE
                            ItemToFirestore().uploadItem(
                                itemNameEditingController.text +
                                    itemPriceEditingController.text +
                                    itemDescriptionEditingController.text,
                                itemNameEditingController.text,
                                selectedValueProvider.CategoryValue,
                                itemDescriptionEditingController.text,
                                imageUrl,
                                itemPriceEditingController.text,
                                uid!,
                                "${location.country} , ${location.province} , ${location.street}",
                                userDatalProvider.phoneNumber!,
                                userDatalProvider.ownerpic!);
                            ItemToFirestore().upload_User_Item(
                                itemNameEditingController.text +
                                    itemPriceEditingController.text +
                                    itemDescriptionEditingController.text,
                                itemNameEditingController.text,
                                selectedValueProvider.CategoryValue,
                                itemDescriptionEditingController.text,
                                imageUrl,
                                itemPriceEditingController.text,
                                uid!,
                                "${location.country} , ${location.province} , ${location.street}");
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            location.country = "";
                            location.province = "";
                            location.street = "";
                            UrlProvider.PHOTO = null;
                            selectedValueProvider.CategoryValue = null;
                            itemNameEditingController.clear();
                            itemDescriptionEditingController.clear();
                            itemPriceEditingController.clear();
                          }
                        }
                      },
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Upload",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.upload),
    );
  }
}
