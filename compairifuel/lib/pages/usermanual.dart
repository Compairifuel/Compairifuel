import 'package:flutter/material.dart';

class UserManualPage extends StatefulWidget {
  const UserManualPage({super.key, required this.title});

  final String title;

  @override
  State<UserManualPage> createState() => _UserManualPageState();
}

class _UserManualPageState extends State<UserManualPage> {
  int index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("UserManualPage didChangeDependencies: $index");
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: index);
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: const <Widget>[
                  Text(
                    'This is the usermanual about compairifuel.'
                    ' we will explain how to use this app. please read this manual carefully.'
                    ' if you have any question, please contact us.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontFamilyFallback: <String>['RobotoSans'],
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'second page of usermanual',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontFamilyFallback: <String>['RobotoSans'],
                      fontSize: 18,
                    ),
                  ),
                ],
                onPageChanged: (int index) {
                  setState(() {
                    index = index;
                  });
                }
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
                      child: SegmentedButton(
                          segments: <ButtonSegment>[
                            ButtonSegment(
                              label: Text(''),
                                value: 0,
                            ),
                            ButtonSegment(
                              label: Text(''),
                              value: 1,
                            ),
                          ],
                        selected: {index},
                        onSelectionChanged: (newSelection) {
                          setState(() {
                            index = newSelection.first;
                          });
                          controller.animateToPage(index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                      ),
                    ),
                  ]),
            ],
          )
        ],
      ),
      // bottomNavigationBar: const NavBar(),
    );
  }
}
