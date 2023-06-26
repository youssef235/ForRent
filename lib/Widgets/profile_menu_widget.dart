// ignore_for_file: use_key_in_widget_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Screens/login_screen.dart';
import 'package:for_rent/Screens/privacy_screen.dart';
import 'package:for_rent/Screens/user_rental_products.dart';
import 'package:for_rent/Widgets/header_widget.dart';
import 'package:for_rent/Widgets/profile_pic_widget.dart';
import 'package:for_rent/Widgets/profile_single_menu.dart';
import 'package:provider/provider.dart';

import '../Providers/get_location_provider.dart';
import '../Providers/user_data_provider.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserDataProvider>(context);
    var location = Provider.of<GetLocationProvider>(context);

    final double _headerHeight = 300;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: _headerHeight,
            child: HeaderWidget(
                _headerHeight, false, Icons.person_2_outlined, ProfilePic()),
          ),
          SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const SizedBox(height: 50),
                ProfileMenu(
                  text: "Your Rental Products",
                  icon: Icons.production_quantity_limits,
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UserProducts()));
                  },
                ),
                ProfileMenu(
                  text: "Privacy",
                  icon: Icons.privacy_tip_outlined,
                  press: () async {
                    userData.getuserPhNumber(uid);
                    userData.getuserAddress(uid);
                    userData.getuserLastname(uid);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrivacyScreen()));
                  },
                ),
                ProfileMenu(
                  text: "Log Out",
                  icon: Icons.logout_outlined,
                  press: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                ),
              ])),
        ],
      ),
    );
  }
}
