import 'package:compairifuel/Logo.dart';
import 'package:compairifuel/PageTitle.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Logo? logo;
  final PageTitle? pageTitle;

  const Header({super.key, required this.logo, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  logo!,
                  pageTitle!
                ]
              )
            ]
          )
        ]
      )
    ));
  }
}