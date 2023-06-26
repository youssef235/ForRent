import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemToFirestore {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Items');

  final CollectionReference user_reference = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("Items");

  uploadItem(
      String itemId,
      String itemName,
      String? itemCategory,
      String itemDetails,
      String? imageUrl,
      String price,
      String uid,
      String address,
      String userphone,
      String ownerpic) {
    Map<String, dynamic> dataToSend = {
      'id': itemId,
      'name': itemName,
      'price': price,
      'details': itemDetails,
      'image': imageUrl,
      'Category': itemCategory,
      'Userid': uid,
      'address': address,
      'userphone': userphone,
      'ownerpic': ownerpic,
    };

    _reference.doc(itemId).set(dataToSend).catchError((e) {
      ("EEEERRROOOORRR $e");
    });
  }

  upload_User_Item(
      String itemId,
      String itemName,
      String? itemCategory,
      String itemDetails,
      String? imageUrl,
      String price,
      String uid,
      String address) {
    Map<String, dynamic> dataToSend = {
      'id': itemId,
      'name': itemName,
      'price': price,
      'details': itemDetails,
      'image': imageUrl,
      'Category': itemCategory,
      'Userid': uid,
      'address': address
    };

    user_reference.doc(itemId).set(dataToSend).catchError((e) {
      ("EEEERRROOOORRR $e");
    });
  }
}
