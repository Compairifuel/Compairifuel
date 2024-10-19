import 'package:compairifuel/src/global/ui/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('NavItem has a icon, name and location', (tester) async {
    var identifier = 'Usermanual';
    var iconIdentifier = const Icon(Icons.home);
    var widget =
        NavItem(icon: iconIdentifier, name: identifier, location: () {});

    await tester.pumpWidgetInEnv(widget);
    final titleFinder = find.text(identifier);
    final iconFinder = find.byWidget(iconIdentifier);
    final widgetFinder = find.byWidget(widget);
    final iconButtonFinder = find.byType(IconButton);

    expect(titleFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
    expect(widgetFinder, findsOneWidget);
    expect(iconButtonFinder, findsOneWidget);
  });
}
