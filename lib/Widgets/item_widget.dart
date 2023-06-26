import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:for_rent/Providers/user_data_provider.dart';
import 'package:for_rent/Widgets/user_widget.dart';
import 'package:provider/provider.dart';

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.image,
    required this.name,
    required this.details,
    required this.price,
    required this.phNumber,
    required this.ownerpic,
    required this.address,
    required this.imageHeight,
    required this.expanded,
  }) : super(key: key);

  final String image;
  final String name;
  final String details;
  final String price;
  final String phNumber;
  final String ownerpic;
  final String address;
  final double imageHeight;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    var profilepicprovider = Provider.of<UserDataProvider>(context);

    return InkWell(
      child: Card(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                expanded
                    ? Expanded(
                        child: Center(
                          child: Container(
                              alignment: Alignment.topLeft,
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: FadeInImage.assetNetwork(
                                  image: image,
                                  placeholder: "assets/images/Loading.png",
                                  height: imageHeight,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      )
                    : Center(
                        child: Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(top: 20, bottom: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: FadeInImage.assetNetwork(
                                image: image,
                                placeholder: "assets/images/Loading.png",
                                height: imageHeight,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "$price EGP",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          details,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 143, 143, 143)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        address,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 143, 143, 143),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5.0, left: 12, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserWidget(ownerpic),
                      OutlinedButton.icon(
                        onPressed: () {
                          callOwner();
                        },
                        icon: const Icon(
                          Icons.call,
                          size: 24.0,
                          color: Colors.red,
                        ),
                        label: const Text(
                          'Call',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  callOwner() async {
    await FlutterPhoneDirectCaller.callNumber(phNumber);
  }
}
