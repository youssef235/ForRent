import 'package:flutter/material.dart';
import 'package:for_rent/Screens/popular_item_screen.dart';

class PopularItem extends StatelessWidget {
  const PopularItem({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.detalis,
    required this.address,
    required this.phNumber,
    required this.ownerpic,
  }) : super(key: key);

  final String image;
  final String name;
  final String price;
  final String detalis;
  final String address;
  final String phNumber;
  final String ownerpic;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 111, 111, 111),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PopularScreen(
                    address: address,
                    details: detalis,
                    image: image,
                    name: name,
                    phNumber: phNumber,
                    ownerpic: ownerpic,
                    price: price)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: SizedBox(
                      width: 150,
                      child: FadeInImage.assetNetwork(
                        image: image,
                        placeholder: "assets/images/Loading.png",
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "$price EGP",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 1),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 1, bottom: 3),
                child: SizedBox(
                  width: 120,
                  child: Text(
                    detalis,
                    style: const TextStyle(fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
