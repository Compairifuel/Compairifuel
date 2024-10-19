import 'package:compairifuel/src/global/ui/widgets/nav_bar.dart';
import 'package:compairifuel/src/global/ui/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('NavBar has a list of NavItems', (tester) async {
    var navItems = [
      NavItem(icon: const Icon(Icons.home), name: 'Home', location: () {}),
    ];
    var widget = NavBar(items: navItems);

    await tester.pumpWidgetInEnv(widget);
    final navItemFinders = find.byType(NavItem);
    final widgetFinder = find.byWidget(widget);

    expect(navItemFinders, findsNWidgets(1));
    expect(widgetFinder, findsOneWidget);
  });
  testWidgets('NavBar has a list of default NavItems', (tester) async {
    var widget = const NavBar();

    await tester.pumpWidgetInEnv(widget);
    final navItemFinders = find.byType(NavItem);
    final widgetFinder = find.byWidget(widget);

    expect(navItemFinders, findsNWidgets(2));
    expect(widgetFinder, findsOneWidget);
  });
}
