// ignore_for_file: prefer_final_fields, must_be_immutable
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Constants/alert_dialog.dart';
import 'package:for_rent/Widgets/item_widget.dart';

class ItemsList extends StatefulWidget with ChangeNotifier {
  ItemsList({
    Key? key,
    required this.catego,
  }) : super(key: key);
  String catego;

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Items');

  late Stream<QuerySnapshot> _stream =
      _reference.where("Category", isEqualTo: widget.catego).snapshots();

  List<Map<String, dynamic>> items = [];

  List<Map<String, dynamic>> foundItems = [];

  List<Map<String, dynamic>> results = [];
  bool activeSearch = false;

  String test = "dddd";

  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 13.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 226, 226),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onChanged: (value) => runFilter(value),
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Search product",
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Some error occurred ${snapshot.error}'));
                  }

                  if (snapshot.hasData) {
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                    items = documents
                        .map((e) => e.data() as Map<String, dynamic>)
                        .toList();
                    if (!activeSearch) {
                      foundItems = items;
                    }

                    return ListView.builder(
                        itemCount: foundItems.length,
                        itemBuilder: (context, Index) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          Map thisItem = foundItems[Index];

                          return thisItem.containsKey('image')
                              ? Item(
                                  image: thisItem['image'],
                                  name: thisItem['name'],
                                  details: thisItem['details'],
                                  price: thisItem['price'],
                                  phNumber: thisItem['userphone'],
                                  ownerpic: thisItem['ownerpic'],
                                  address: thisItem['address'],
                                  imageHeight: 220,
                                  expanded: false,
                                )
                              : const Text("NO ITEMS");
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      results = items;
    } else {
      results = items
          .where((item) => item["name"]
              .toLowerCase()
              .startsWith(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      activeSearch = true;
      foundItems = results;
    });
  }
}
