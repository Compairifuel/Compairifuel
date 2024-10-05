import 'package:flutter/material.dart';
import 'package:compairifuel/src/global/ui/widgets/logo.dart';
import 'package:compairifuel/src/global/ui/widgets/header_title.dart';

class Header extends StatelessWidget {
  final Logo logo;
  final HeaderTitle? title;

  const Header({super.key, this.logo = const Logo(), this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [logo, title].nonNulls.toList(),
    );
  }
}
