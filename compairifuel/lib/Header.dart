import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Logo? logo;
  PageTitle? pageTitle;

  Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  logo,
                  pageTitle
                ]
              )
            ]
          )
        ]
      )
    );
  }
}