import 'package:flutter/material.dart';

import '../widgets/navbar.dart';
// import 'package:flutter/services.dart' show rootBundle;

class UserManualPage extends StatelessWidget {
  const UserManualPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image(
                    image: const AssetImage(
                        'assets/images/logo_compairifuel_primary.png'),
                    height: 64,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xFF000000),
                    child: const Text(
                      'User manual',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontFamilyFallback: <String>['RobotoSans'],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: const Text('This is the usermanual about compairifuel. we will explain how to use this app. please read this manual carefully. if you have any question, please contact us.',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontFamilyFallback: <String>['RobotoSans'],
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0xFFFF0000),
                      height: 8,
                      child: const Text(''),
                    ),
                  ]),
            ],
          )
        ],
      ),
      //bottomNavigationBar: const NavBar(),
    );
  }
}
