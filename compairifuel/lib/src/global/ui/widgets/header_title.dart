import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  final String text;

  const HeaderTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    );
  }
}
