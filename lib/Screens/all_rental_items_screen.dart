import 'package:flutter/material.dart';
import 'package:for_rent/Components/items_bottom_nav_bar.dart';
import 'package:for_rent/Widgets/app_bar_widget.dart';
import 'package:for_rent/Widgets/items_list_widget.dart';

class AllRentalItems extends StatelessWidget {
  AllRentalItems({
    Key? key,
    required this.catego,
  }) : super(key: key);
  String catego;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: constAppBar("Items", context),
      body: ItemsList(
        catego: catego,
      ),
      bottomNavigationBar: const ItemsBottomNavBar(),
    );
  }
}
