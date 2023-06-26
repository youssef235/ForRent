import 'package:flutter/material.dart';
import 'package:for_rent/Components/items_bottom_nav_bar.dart';
import 'package:for_rent/Widgets/app_bar_widget.dart';
import 'package:for_rent/Widgets/user_items_list.dart';

class UserProducts extends StatelessWidget {
  const UserProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: constAppBar("Yours", context),
      body: Column(
        children: [
          Expanded(
            child: UserItemsList(),
          ),
        ],
      ),
      bottomNavigationBar: const ItemsBottomNavBar(),
    );
  }
}
