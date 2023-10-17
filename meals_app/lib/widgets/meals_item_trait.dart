import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.trait});

  final IconData icon;
  final String trait;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Icon(icon),
        ),
        // const SizedBox(
        //   width: 5,
        // ),
        Text(
          trait,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
