import 'package:flutter/material.dart';
import 'package:for_rent/Constants/enums.dart';
import 'package:for_rent/Firebase/Auth/signup.dart';
import 'package:for_rent/Providers/user_data_provider.dart';
import 'package:for_rent/Screens/login_screen.dart';
import 'package:for_rent/Widgets/home_widget.dart';
import '../Components/coustom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    UserDataProvider().getprofilepic(uid!);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 25,
          ),
        ),
      ),
      body: const HomeWidget(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
