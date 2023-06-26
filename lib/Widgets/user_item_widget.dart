import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Constants/alert_dialog.dart';

class UserItem extends StatelessWidget {
  UserItem({
    Key? key,
    required this.image,
    required this.name,
    required this.details,
    required this.price,
    required this.itemID,
  }) : super(key: key);

  final String image;
  final String name;
  final String details;
  final String price;
  final String itemID;

  @override
  Widget build(BuildContext context) {
    final CollectionReference item_reference =
        FirebaseFirestore.instance.collection("Items");

    final CollectionReference user_reference = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Items");

    return Card(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Center(
                  child: Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 20, bottom: 15),
                      child: FadeInImage.assetNetwork(
                        image: image,
                        placeholder: "assets/images/Loading.png",
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$price EGP",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          AlertDialod().alert(context, () {
                            item_reference.doc(itemID).delete();
                            user_reference.doc(itemID).delete();
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text("Delete Item")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 2,
                        details,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 143, 143, 143)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.location_on,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Egypt , Sharkia , Belbies",
                      style: TextStyle(
                          color: Color.fromARGB(255, 143, 143, 143),
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
