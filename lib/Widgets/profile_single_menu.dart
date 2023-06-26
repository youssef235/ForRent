import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromARGB(255, 255, 99, 99),
                  Color.fromARGB(255, 255, 170, 170),
                ])),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: press,
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              Expanded(child: Text(text)),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
