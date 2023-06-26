// ignore_for_file: must_be_immutable
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Components/coustom_bottom_nav_bar.dart';
import 'package:for_rent/Constants/enums.dart';
import 'package:for_rent/Providers/user_data_provider.dart';
import 'package:for_rent/Widgets/app_bar_widget.dart';
import 'package:for_rent/Widgets/profile_menu_widget.dart';
import 'package:for_rent/Widgets/profile_pic_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget with ChangeNotifier {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserDataProvider>(context);

    return Scaffold(
      appBar: constAppBar("Profile", context),
      body: Menu(),
      floatingActionButton: Visibility(
        visible: userprovider.ispressed,
        child: FloatingActionButton(
          onPressed: () async {
            if (userprovider.ischanged == true) {
              userprovider.UploadToFirebase();
              userprovider.getusername(uid);
              userprovider.getprofilepic(uid);
            }

            if (kDebugMode) {
              print(userprovider.username);
            }
          },
          child: const Text('Save'),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
