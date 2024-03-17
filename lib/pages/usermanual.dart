// import 'package:flutter/material.dart';
//
// class UserManualPage extends StatefulWidget {
//   const UserManualPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<UserManualPage> createState() => _UserManualPageState();
// }
//
// class _UserManualPageState extends State<UserManualPage> {
//   int _currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final PageController controller =
//         PageController(initialPage: _currentIndex);
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Image(
//                     image: const AssetImage(
//                         'assets/images/logo_compairifuel_primary.png'),
//                     height: 64,
//                     width: MediaQuery.of(context).size.width,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     color: const Color(0xFF000000),
//                     child: const Text(
//                       'User manual',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontFamily: 'Roboto',
//                         fontFamilyFallback: <String>['RobotoSans'],
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFFFFFFFF),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 2,
//             child: PageView(
//                 controller: controller,
//                 scrollDirection: Axis.horizontal,
//                 children: const <Widget>[
//                   Text(
//                     'This is the usermanual about compairifuel.'
//                     ' we will explain how to use this app. please read this manual carefully.'
//                     ' if you have any question, please contact us.',
//                     style: TextStyle(
//                       fontFamily: 'Roboto',
//                       fontFamilyFallback: <String>['RobotoSans'],
//                       fontSize: 18,
//                     ),
//                   ),
//                   Text(
//                     'second page of usermanual',
//                     style: TextStyle(
//                       fontFamily: 'Roboto',
//                       fontFamilyFallback: <String>['RobotoSans'],
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//                 onPageChanged: (int index) {
//                   setState(() {
//                     _currentIndex = index;
//                   });
//                 }),
//           ),
//           Column(
//             children: <Widget>[
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     height: 8,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               _currentIndex = 0;
//                             });
//                             controller.animateToPage(_currentIndex,
//                                 duration: const Duration(milliseconds: 500),
//                                 curve: Curves.easeInOut);
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: () {
//                               if (_currentIndex == 0) {
//                                 return MaterialStateProperty.all<Color>(
//                                     Colors.grey);
//                               } else {
//                                 return MaterialStateProperty.all<Color>(
//                                     Colors.white);
//                               }
//                             }(),
//                             shape: MaterialStateProperty.all<CircleBorder>(
//                               const CircleBorder(
//                                 side: BorderSide(
//                                   color: Colors.grey,
//                                   width: 1,
//                                   style: BorderStyle.solid,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           child: const Text(''),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               _currentIndex = 1;
//                             });
//                             controller.animateToPage(_currentIndex,
//                                 duration: const Duration(milliseconds: 500),
//                                 curve: Curves.easeInOut);
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: () {
//                               if (_currentIndex == 1) {
//                                 return MaterialStateProperty.all<Color>(
//                                     Colors.grey);
//                               } else {
//                                 return MaterialStateProperty.all<Color>(
//                                     Colors.white);
//                               }
//                             }(),
//                             shape: MaterialStateProperty.all<CircleBorder>(
//                               const CircleBorder(
//                                 side: BorderSide(
//                                   color: Colors.grey,
//                                   width: 1,
//                                   style: BorderStyle.solid,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           child: const Text(''),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
