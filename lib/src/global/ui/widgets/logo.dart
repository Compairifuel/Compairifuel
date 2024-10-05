import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String image;

  const Logo(
      {super.key, this.image = "assets/images/logo_compairifuel_primary.png"});

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(image), fit: BoxFit.fitHeight);
  }
}
