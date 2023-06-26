// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:for_rent/Components/category_item.dart';
import 'package:for_rent/Screens/all_rental_items_screen.dart';
import 'package:for_rent/Widgets/popular_items_list_widget.dart';

class Cat {
  int? id;
  String? icon;
  String? ttite;
  Cat(int id, String icon, String ttite) {
    this.id = id;
    this.icon = icon;
    this.ttite = ttite;
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryItem(
                icon: "assets/icons/electrical.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllRentalItems(
                            catego: 'Electronics',
                          )));
                },
                text: 'Electronics',
              ),
              CategoryItem(
                icon: "assets/icons/car.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllRentalItems(
                            catego: 'Cars',
                          )));
                },
                text: 'Cars',
              ),
              CategoryItem(
                icon: "assets/icons/furniture.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllRentalItems(
                            catego: 'Furniture',
                          )));
                },
                text: 'Furniture',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryItem(
                icon: "assets/icons/bike.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllRentalItems(
                            catego: 'Bikes',
                          )));
                },
                text: 'Bikes',
              ),
              CategoryItem(
                icon: "assets/icons/motorcycle.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllRentalItems(
                            catego: 'Motorcycles',
                          )));
                },
                text: 'Motorcycles',
              ),
              CategoryItem(
                icon: "assets/icons/carpentry.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllRentalItems(
                            catego: 'Carpentry Tools',
                          )));
                },
                text: 'Carpentry Tools',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryItem(
                icon: "assets/icons/mobile.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllRentalItems(
                            catego: 'Phones',
                          )));
                },
                text: 'Phones',
              ),
              CategoryItem(
                icon: "assets/icons/health.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllRentalItems(
                            catego: 'Health tools',
                          )));
                },
                text: 'Health tools',
              ),
              CategoryItem(
                icon: "assets/icons/gold.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllRentalItems(
                            catego: 'Gold',
                          )));
                },
                text: 'Gold',
              ),
            ],
          ),
        ),
        Card(
            color: Color.fromARGB(255, 243, 243, 243),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                  child: Text(
                    "Popular Products",
                    //  style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Icon(
                    Icons.forward_outlined,
                  ),
                )
              ],
            )),
        Expanded(
          child: PopularItems(),
        ),
      ],
    );
  }
}
