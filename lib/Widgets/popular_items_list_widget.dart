import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Screens/popular_item_screen.dart';
import 'package:for_rent/Widgets/popular_item_widget.dart';

class PopularItems extends StatelessWidget {
  PopularItems({
    Key? key,
  }) : super(key: key);

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Items');
  late final Stream<QuerySnapshot> _stream =
      _reference.where("price", isEqualTo: "1250").snapshots();
  List<Map<String, dynamic>> items = [];

  final uid = FirebaseAuth.instance.currentUser?.uid;

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
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, Index) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                Map thisItem = items[Index];

                return thisItem.containsKey('image')
                    ? PopularItem(
                        image: thisItem['image'],
                        name: thisItem['name'],
                        price: thisItem['price'],
                        detalis: thisItem['details'],
                        address: thisItem['address'],
                        phNumber: thisItem['userphone'],
                        ownerpic: thisItem['ownerpic'],
                      )
                    : const Text("NO ITEMS");
              });
        });
  }
}
