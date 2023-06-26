import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon;
  final String text;
  final GestureTapCancelCallback press;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Card(
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: press,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          icon,
                          width: 40,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          maxLines: 1,
                          text,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
