// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:compairifuel/NavIcon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:compairifuel/Navbar.dart';
import 'package:compairifuel/Pagination.dart';
import 'package:compairifuel/Page.dart' as PageComponent;
import 'package:compairifuel/Manual/UserManual.dart';
import 'package:compairifuel/Main.dart';


void main() {
  testWidgets(skip: false, 'navIcon test', (WidgetTester tester) async {
    await tester.pumpWidget(NavIcon(AssetImage("assets/images/map.png")));

    final navIcon = find.byType(NavIcon);
    //https://api.flutter.dev/flutter/flutter_test/CommonFinders/byType.html
    expect(navIcon, findsOneWidget);
  });

  testWidgets(skip: true, 'myapp test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // await tester.pumpWidget(MyApp(key:, pages: [
    //   PageComponent.Page(title: "title",
    //       content: UserManual(),
    //       navbar: Navbar(navItemList: []),
    //       pagination: Pagination())
    // ],
    // ));
  });
}