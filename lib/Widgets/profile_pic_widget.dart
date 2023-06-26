// ignore_for_file: non_constant_identifier_names, unused_field
import 'dart:io';
import 'package:image_fade/image_fade.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Providers/user_data_provider.dart';
import 'package:provider/provider.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final CollectionReference _referenceS =
      FirebaseFirestore.instance.collection('users');

  String? Username = 'Loading ...';
  File? _photo;
  late bool imageAvilable = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var profilepicprovider = Provider.of<UserDataProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(55.0),
              child: SizedBox(
                height: 115,
                width: 115,
                child: profilepicprovider.profileurl == null
                    ? Icon(
                        Icons.person,
                        color: Colors.grey.shade300,
                        size: 80.0,
                      )
                    : profilepicprovider.ischanged
                        ? FutureBuilder(
                            future: Future.delayed(const Duration(seconds: 1)),
                            builder: (c, s) =>
                                s.connectionState == ConnectionState.done
                                    ? Image.file(
                                        profilepicprovider.PHOTO!,
                                        fit: BoxFit.cover,
                                      )
                                    : const CircularProgressIndicator(),
                          )
                        : ClipRect(
                            child: ImageFade(
                              image:
                                  NetworkImage(profilepicprovider.profileurl!),
                              fit: BoxFit.cover,
                              placeholder: Container(
                                color: const Color(0xFFCFCDCA),
                                alignment: Alignment.center,
                                child: const Icon(Icons.photo,
                                    color: Colors.white30, size: 50.0),
                              ),
                            ),
                          ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(70, 80, 0, 0),
              child: IconButton(
                onPressed: () {
                  profilepicprovider.imgFromGallery();
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          profilepicprovider.username == null
              ? "Loading ... "
              : profilepicprovider.username!,
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              fontFamily: 'OpenSans',
              color: Colors.white),
        )
      ],
    );
  }
}
