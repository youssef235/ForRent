import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Components/coustom_textformfield.dart';
import 'package:for_rent/Providers/get_location_provider.dart';
import 'package:for_rent/Providers/user_data_provider.dart';
import 'package:for_rent/Providers/selected_value_provider.dart';
import 'package:for_rent/Providers/item_photo_provider.dart';
import 'package:for_rent/Screens/home_screen.dart';
import 'package:for_rent/Screens/login_screen.dart';
import 'package:for_rent/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'Widgets/items_list_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await DioHelperPayment.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PhotoProvider>(create: (_) => PhotoProvider()),
        ChangeNotifierProvider<UserDataProvider>(
            create: (_) => UserDataProvider()),
        ChangeNotifierProvider<ValueProvider>(
            create: (context) => ValueProvider()),
        ChangeNotifierProvider<GetLocationProvider>(
            create: (_) => GetLocationProvider()),
        ChangeNotifierProvider<ItemsList>(
            create: (_) => ItemsList(
                  catego: 'Furniture',
                )),
      ],
      child: MaterialApp(
        title: 'For Rent',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null) {
                return Login();
              } else {
                return HomeScreen();
              }
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
