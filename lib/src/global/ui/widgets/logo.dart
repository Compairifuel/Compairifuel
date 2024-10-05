import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String image;

  const Logo(
      {super.key, this.image = "assets/images/LogoComparifuelPrimary.svg"});

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(image), fit: BoxFit.fitHeight);
  }
}
