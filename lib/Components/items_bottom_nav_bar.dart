import 'package:flutter/material.dart';
import 'package:for_rent/Constants/enums.dart';
import 'package:for_rent/Screens/all_rental_items_screen.dart';
import 'package:for_rent/Screens/home_screen.dart';
import 'package:for_rent/Screens/upload_item_screen.dart';
import 'package:for_rent/Widgets/items_list_widget.dart';

class ItemsBottomNavBar extends StatelessWidget {
  const ItemsBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UploadScreen()));
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          )),
    );
  }
}
