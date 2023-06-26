import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Constants/CircularProgress.dart';
import 'package:for_rent/Constants/enums.dart';
import 'package:for_rent/Providers/user_data_provider.dart';
import 'package:for_rent/Screens/home_screen.dart';
import 'package:for_rent/Screens/profile_screen.dart';
import 'package:for_rent/Screens/upload_item_screen.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget with ChangeNotifier {
  CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserDataProvider>(context);
    //String uid = FirebaseAuth.instance.currentUser!.uid;

    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: const Icon(Icons.home),
                  color: MenuState.home == selectedMenu
                      ? Colors.red
                      : inActiveIconColor,
                  onPressed: () {
                    userprovider.ischanged = false;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  }),
              IconButton(
                  icon: const Icon(Icons.upload),
                  color: MenuState.upload == selectedMenu
                      ? Colors.red
                      : inActiveIconColor,
                  onPressed: () {
                    userprovider.ischanged = false;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UploadScreen()));
                  }),
              IconButton(
                  icon: const Icon(Icons.person),
                  color: MenuState.profile == selectedMenu
                      ? Colors.red
                      : inActiveIconColor,
                  onPressed: () async {
                    userprovider
                        .getprofilepic(FirebaseAuth.instance.currentUser!.uid);
                    userprovider
                        .getusername(FirebaseAuth.instance.currentUser!.uid);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                  }),
            ],
          )),
    );
  }
}
