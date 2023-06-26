import 'package:flutter/material.dart';

Widget UserWidget(String image) {
  return Row(
    children: [
      CircleAvatar(
        backgroundImage: NetworkImage(image),
        /*  FadeInImage.assetNetwork(
          image: image,
          placeholder: "assets/images/Loading.png",
          //  height: imageHeight,
          //  width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ), */
      ),
      const Padding(
        padding: EdgeInsets.only(left: 5),
        child: Text(
          "Owner",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}
