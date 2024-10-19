import 'package:compairifuel/src/global/ui/widgets/header.dart';
import 'package:compairifuel/src/global/ui/widgets/header_title.dart';
import 'package:compairifuel/src/global/ui/widgets/logo.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('Header has a title and logo', (WidgetTester tester) async {
    var identifier = 'Usermanual';
    var widget = Header(title: HeaderTitle(text: identifier));

    await tester.pumpWidgetInEnv(widget);
    final titleFinder = find.text(identifier);
    final logoFinder = find.byType(Logo);
    final widgetFinder = find.byWidget(widget);

    expect(titleFinder, findsOneWidget);
    expect(logoFinder, findsOneWidget);
    expect(widgetFinder, findsOneWidget);
  });
  testWidgets('Header has a logo', (WidgetTester tester) async {
    var widget = const Header();

    await tester.pumpWidgetInEnv(widget);
    final titleFinder = find.byType(HeaderTitle);
    final logoFinder = find.byType(Logo);
    final widgetFinder = find.byWidget(widget);

    expect(titleFinder, findsNothing);
    expect(logoFinder, findsOneWidget);
    expect(widgetFinder, findsOneWidget);
  });
}
