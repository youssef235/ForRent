import 'package:flutter/material.dart';
import 'package:for_rent/Constants/CircularProgress.dart';
import 'package:for_rent/Providers/user_data_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class GetLocationProvider extends ChangeNotifier {
  String country = "";
  String province = "";
  String street = "";
  getLocation(BuildContext CT) async {
    Progress().showLoaderDialog(CT);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint(
        'latitude: ${position.latitude} longitude ${position.longitude}');
    List<Placemark> addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    country = addresses.first.country!;
    province = addresses.first.administrativeArea!;
    street = addresses.first.locality!;
    print("$country , $province , $street ");
    // ignore: use_build_context_synchronously
    Navigator.of(CT).pop();

    notifyListeners();
  }
}
