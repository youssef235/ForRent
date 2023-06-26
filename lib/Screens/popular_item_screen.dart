import 'package:flutter/material.dart';
import 'package:for_rent/Components/items_bottom_nav_bar.dart';
import 'package:for_rent/Widgets/app_bar_widget.dart';
import 'package:for_rent/Widgets/item_widget.dart';

class PopularScreen extends StatelessWidget {
  PopularScreen(
      {super.key,
      required this.address,
      required this.details,
      required this.image,
      required this.name,
      required this.phNumber,
      required this.ownerpic,
      required this.price});

  String address;
  String details;
  String image;
  String name;
  String phNumber;
  String ownerpic;
  String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: constAppBar("title", context),
      body: Item(
        address: address,
        details: details,
        image: image,
        name: name,
        phNumber: phNumber,
        ownerpic: ownerpic,
        price: price,
        imageHeight: 500,
        expanded: true,
      ),
      bottomNavigationBar: const ItemsBottomNavBar(),
    );
  }
}
