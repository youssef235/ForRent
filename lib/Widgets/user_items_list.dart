import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Widgets/user_item_widget.dart';

class UserItemsList extends StatelessWidget {
  UserItemsList({
    Key? key,
  }) : super(key: key);

  final uid = FirebaseAuth.instance.currentUser?.uid;

  final CollectionReference _reference = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("Items");

  late final Stream<QuerySnapshot> _stream = _reference.snapshots();
  List<Map<String, dynamic>> items = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            items =
                documents.map((e) => e.data() as Map<String, dynamic>).toList();
          }

          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, Index) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                Map thisItem = items[Index];

                return thisItem.containsKey('image')
                    ? UserItem(
                        image: thisItem['image'],
                        name: thisItem['name'],
                        details: thisItem['details'],
                        price: thisItem['price'],
                        itemID: thisItem['id'],
                      )
                    : Container(
                        child: Text("NO ITEMS"),
                      );
              });
        });
  }
}
