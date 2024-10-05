import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final Widget icon;
  final String name;
  final Function location;

  const NavItem(
      {super.key,
      required this.icon,
      required this.name,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Column(
        children: [
          icon,
          Text(
            name,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
      onPressed: () => location(),
      color: Colors.white,
    );
  }
}
